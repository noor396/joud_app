import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:joud_app/Authentication/userAuth.dart';
import 'package:joud_app/lang/language_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:joud_app/widgets/progress.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:image/image.dart' as Im;
import 'package:toast/toast.dart';

class PostForm extends StatefulWidget {
  @override
  _PostFormState createState() => _PostFormState();
  static const routeName = '/postform';
  PostForm(this.id, this.imageUrl, this.password, this.timestamp, this.userName,
      {this.key});

  final String id;
  final String imageUrl;
  final String password;
  final DateTime timestamp;
  final String userName;
  final Key key;
}

class _PostFormState extends State<PostForm>
    with AutomaticKeepAliveClientMixin<PostForm> {
  final user = FirebaseAuth.instance.currentUser;
  TextEditingController captionController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  bool isUploading = false;
  String postId = Uuid().v4(); //unique string
  File _image;
  final picker = ImagePicker();
  UserCredential authResult;
  DateTime timestamp;

  selectImage(parentContext, lan) {
    return showDialog(
      context: parentContext,
      builder: (context) {
        return Directionality(
          textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
          child: SimpleDialog(
            title: Text(
              lan.getTexts('PostForm1'),
            ),
            children: <Widget>[
              SimpleDialogOption(
                  child: Text(lan.getTexts('PostForm2')),
                  onPressed: () async {
                    Navigator.pop(context);
                    final pickedFile =
                        await picker.getImage(source: ImageSource.camera);
                    if (!mounted) return;
                    setState(() {
                      if (pickedFile != null) {
                        _image = File(pickedFile.path);
                      } else {
                        print('No image selected');
                      }
                    });
                  }),
              SimpleDialogOption(
                  child: Text(lan.getTexts('PostForm3')),
                  onPressed: () async {
                    Navigator.pop(context);
                    final pickedFile =
                        await picker.getImage(source: ImageSource.gallery);
                    if (!mounted) return;
                    setState(() {
                      if (pickedFile != null) {
                        _image = File(pickedFile.path);
                      } else {
                        print('No image selected');
                      }
                    });
                  }),
              SimpleDialogOption(
                child: Text(lan.getTexts('PostForm4')),
                onPressed: () => Navigator.pop(context),
              )
            ],
          ),
        );
      },
    );
  }

  Container buildSplashScreen(lan) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(15.0),
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 40.0,
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage(widget.imageUrl),
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(widget.userName)),
            ],
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: EdgeInsets.only(left: 20, top: 50),
                  child: Center(
                      child: Text(
                    lan.getTexts('PostForm5'),
                    style: TextStyle(fontSize: 25),
                  )))),
          Padding(
            padding: EdgeInsets.only(top: 50, bottom: 20.0),
            child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(215, 204, 200, 1.0),
                ),
                icon: Icon(
                  Icons.add_photo_alternate_outlined,
                  size: 30,
                  color: Colors.black,
                ),
                label: Text(
                  lan.getTexts('PostForm6'),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22.0,
                  ),
                ),
                onPressed: () => selectImage(context, lan)),
          ),
        ],
      ),
    );
  }

  clearImage() {
    if (!mounted) return;
    setState(() {
      _image = null;
    });
  }

  compressImage() async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    Im.Image imageFile = Im.decodeImage(_image.readAsBytesSync());
    final compressedImageFile = File('$path/img_$postId.jpg')
      ..writeAsBytesSync(Im.encodeJpg(imageFile, quality: 85));
    if (!mounted) return;
    setState(() {
      _image = compressedImageFile;
    });
  }

  Future<String> uploadImage(imageFile) async {
    final imageRef = FirebaseStorage.instance.ref().child("post_$postId.jpg");
    await imageRef.putFile(imageFile);
    final downloadUrl = await imageRef.getDownloadURL();
    return downloadUrl;
  }

  createPostInFirestore(
      {String mediaUrl, String location, String description}) {
    FirebaseFirestore.instance.collection('posts').doc(postId).set({
      "postId": postId,
      "ownerId": widget.id,
      "username": widget.userName,
      "imageUrl": widget.imageUrl,
      "mediaUrl": mediaUrl,
      "description": description,
      "location": location,
      "timestamp": timestamp,
    });
  }

  handleSubmit(lan) async {
    if (!mounted) return;
    setState(() {
      isUploading = true;
    });
    await compressImage();
    String mediaUrl = await uploadImage(_image);
    createPostInFirestore(
      mediaUrl: mediaUrl,
      location: locationController.text,
      description: captionController.text,
    );
    captionController.clear();
    locationController.clear();
    if (!mounted) return;
    setState(() {
      _image = null;
      isUploading = false;
      Toast.show(lan.getTexts('PostForm12'), context, duration: 3);
      postId = Uuid().v4();
    });
  }

  Scaffold buildUploadForm(lan) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          isUploading ? linearProgress() : Text(""),
          Container(
            height: 220.0,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: FileImage(_image),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(widget.imageUrl),
            ),
            title: Container(
              width: 250.0,
              child: TextField(
                controller: captionController,
                decoration: InputDecoration(
                  hintText: lan.getTexts('PostForm7'),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.pin_drop,
              color: Colors.orange,
              size: 35.0,
            ),
            title: Container(
              width: 250.0,
              child: TextField(
                controller: locationController,
                decoration: InputDecoration(
                  hintText: lan.getTexts('PostForm8'),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Container(
            width: 200.0,
            height: 100.0,
            alignment: Alignment.center,
            child: ElevatedButton.icon(
              label: Text(
                lan.getTexts('PostForm9'),
                style: TextStyle(color: Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(215, 204, 200, 1.0),
              ),
              onPressed: getUserLocation,
              icon: Icon(
                Icons.my_location,
                color: Colors.black,
              ),
            ),
          ),
          Row(
            children: [
              TextButton(
                onPressed: isUploading ? null : () => handleSubmit(lan),
                child: Text(
                  lan.getTexts('PostForm10'),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
              TextButton(
                onPressed: clearImage,
                child: Text(
                  lan.getTexts('PostForm11'),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    Placemark placemark = placemarks[0];
    String completeAddress =
        '${placemark.subThoroughfare} ${placemark.thoroughfare}, ${placemark.subLocality} ${placemark.locality}, ${placemark.subAdministrativeArea}, ${placemark.administrativeArea} ${placemark.postalCode}, ${placemark.country}';
    print(completeAddress);
    String formattedAddress = "${placemark.locality}, ${placemark.country}";
    locationController.text = formattedAddress;
  }

  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    //super.build(context);
    return _image == null ? buildSplashScreen(lan) : buildUploadForm(lan);
  }
}
