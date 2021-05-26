import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:joud_app/Widgets/progress.dart';
import 'package:joud_app/screens/profile_stream.dart';
import 'package:joud_app/test/helper/authenticate.dart';
import 'package:uuid/uuid.dart';

class EditProfilePage extends StatefulWidget {
  EditProfilePage(this.id, this.username, {this.key});
  final String id;
  // final String imageUrl;
  final String username;
  final Key key;

  @override
  _EditProfilePage createState() => _EditProfilePage();
  static const routeName = '/editprofile';
}

class _EditProfilePage extends State<EditProfilePage> {
  // String imageId = Uuid().v4();
  // String userId = Uuid().v4();
  // final formKey = GlobalKey<FormState>();
  // File userImageFile;
  TextEditingController nametext = TextEditingController();
  final scaffild_key = GlobalKey<ScaffoldState>();
  bool loading = false;
  User user;
  final usersReference = FirebaseFirestore.instance.collection('users');

  void initState() {
    super.initState();
    getUserInformation();
  }

  // File _image;
  // String mediaUrl; // = await uploadImage(_image);
  // final picker = ImagePicker();
  // Future<String> uploadImage(imageFile) async {
  //   final imageRef = FirebaseStorage.instance.ref().child("user_$imageId.jpg");
  //   await imageRef.putFile(imageFile);
  //   final downloadUrl = await imageRef.getDownloadURL();
  //   mediaUrl = await uploadImage(_image);
  //   //   return downloadUrl;
  // }

  Future getUserInformation() async {
    setState(() {
      loading = true;
    });
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('ownerId', isEqualTo: widget.id)
        .get();
    nametext.text = widget.username;
    setState(() {
      loading = false;
    });
  }

  createProfileNametestField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 13.0),
          child: Text(
            "Profile Name",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        TextField(
          style: TextStyle(color: Colors.black),
          controller: nametext,
          decoration: InputDecoration(
            hintText: widget.username,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            hintStyle: TextStyle(color: Colors.black),
            //errorText: _profileNameValid ? null : 'Profile name is very short',
          ),
        )
      ],
    );
  }

  updateUserData() {
    usersReference.doc(widget.id).update({
      "id": widget.id,
      "username": nametext.text,
      //"imageUrl": userImageFile
    });

    final snackBar = SnackBar(
        content: Text("Name Updated Successfully ! "), //  "signup_msg1"
        backgroundColor: Color.fromRGBO(127, 0, 0, 1));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffild_key,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Edit Profile',
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.done,
                color: Colors.white,
                size: 30.0,
              ),
              onPressed: () async {
                // UpdateUserData();
                // mediaUrl= await uploadImage(_image);
                //  selectImage(context);
                usersReference.doc(widget.id).update({
                  "id": widget.id,
                  "username": nametext.text,
                  // "imageUrl": mediaUrl //_image
                });
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ProfileStream()));
              }),
        ],
      ),
      body: loading
          ? circularProgress()
          : ListView(children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    // Padding(
                    //   padding: EdgeInsets.only(top: 15.0, bottom: 7.0),
                    //   child: CircleAvatar(
                    //       radius: 52.0,
                    //       backgroundImage: NetworkImage(widget.imageUrl)),
                    // ),
                    // Padding(
                    //   padding: EdgeInsets.only(top: 15.0, bottom: 7.0),
                    //   child: ElevatedButton(
                    //     onPressed: () {
                    //       //  uploadImg();
                    //       // Navigator.push(
                    //       //     context,
                    //       //     MaterialPageRoute(
                    //       //         builder: (context) => SelectProfilePic()));
                    //     },
                    //     child: Text("change Photo"),
                    //   ),
                    // ),

                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: <Widget>[
                          createProfileNametestField(),
                          SizedBox(height: 20),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // UserImagePicker(addedImage),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 29.0, left: 50.0, right: 50.0),
                            child: ElevatedButton(
                              child: Text(
                                '          Update          ',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16.0),
                              ),
                              onPressed: updateUserData(),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 10.0, left: 50.0, right: 50.0),
                            child: ElevatedButton(
                              child: Text(
                                '  Log Out  ',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14.0),
                              ),
                              // color : Colors.red,
                              onPressed: () async {
                                await FirebaseAuth.instance.signOut();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Authenticate()));
                              },
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ]),
    );
  }
  // void addedImage(File pickedImage) {
  //   userImageFile = pickedImage;
  // }

  // uploadImg() async {
  //   final imageRef = FirebaseStorage.instance
  //       .ref()
  //       .child('userImage')
  //       .child("$imageId.jpg"); // all camera pictures have this extension
  //   await imageRef.putFile(userImageFile);
  //   final imageUrl = await imageRef.getDownloadURL();
  //   //FirebaseAuth.instance.currentUser.displayName.
  //   final user = FirebaseAuth.instance.currentUser;

  //   if (formKey.currentState.validate()) {
  //     Map<String, dynamic> userInfoMap = {
  //       'username': nametext.text,
  //       'imageUrl': imageUrl,
  //       'id': userId,
  //     };
  //   }
  // }
}
