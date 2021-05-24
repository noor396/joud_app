import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:joud_app/Widgets/progress.dart';
import 'package:joud_app/screens/profile_stream.dart';
import 'package:joud_app/test/helper/authenticate.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:joud_app/lang/language_provider.dart';
import 'package:joud_app/screens/update_profile_screen.dart';
import 'package:joud_app/test/helper/sharedPreferences.dart';
import 'package:joud_app/test/modal/users.dart';
import 'package:joud_app/test/services/auth.dart';
import 'package:joud_app/test/services/database.dart';
import 'package:joud_app/Widgets/userImagePicker.dart';
import 'package:joud_app/Widgets/widget.dart';
import 'package:joud_app/test/views/rest.dart';
import 'package:joud_app/widgets/tabs_screen.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../screens/joudApp.dart';

class EditProfilePage extends StatefulWidget {
  EditProfilePage(this.id, this.imageUrl, this.username, {this.key});
  final String id;
  final String imageUrl;
  final String username;
  final Key key;

  @override
  _EditProfilePage createState() => _EditProfilePage();
}

class _EditProfilePage extends State<EditProfilePage> {
  String imageId = Uuid().v4();
  String userId = Uuid().v4();
  final formKey = GlobalKey<FormState>();
  File userImageFile;
  TextEditingController nametext = TextEditingController();
  TextEditingController descriptiontext = TextEditingController();
  final scaffild_key = GlobalKey<ScaffoldState>();
  bool loading = false;
  User user;
  //bool _profileNameValid = true;
  // bool _BioValid = false;
  final usersReference = FirebaseFirestore.instance.collection('users');
  //Stream<DocumentSnapshot> provideDocumentFieldStream() {
  // return FirebaseFirestore.instance
  //     .collection('usrs')
  //     .doc('widget.id')
  //     .snapshots();

  //}

  void initState() {
    super.initState();
    getUserInformation();
  }

  Future getUserInformation() async {
    // setState(() {
    //   loading = true;
    // });
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('ownerId', isEqualTo: widget.id)
        .get();
    nametext.text = widget.username;
    // setState(() {
    //   loading = false;
    // });
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

  UpdateUserData() {
    usersReference.doc(widget.id).update({
      "id": widget.id,
      "username": nametext.text,
    });

    /*final snackBar = SnackBar(
        content: Text("Name Updated Successfully ! "), //  "signup_msg1"
        backgroundColor: Color.fromRGBO(127, 0, 0, 1));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);*/
  }

  void addedImage(File pickedImage) {
    userImageFile = pickedImage;
  }

  uploadImg() async {
    final imageRef = FirebaseStorage.instance
        .ref()
        .child('userImage')
        .child("$imageId.jpg"); // all camera pictures have this extension
    await imageRef.putFile(userImageFile);
    final imageUrl = await imageRef.getDownloadURL();
    //FirebaseAuth.instance.currentUser.displayName.
    final user = FirebaseAuth.instance.currentUser;

    if (formKey.currentState.validate()) {
      Map<String, dynamic> userInfoMap = {
        'username': nametext.text,
        'imageUrl': imageUrl,
        'id': userId,
      };
    }
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
              onPressed: () {
                UpdateUserData();
                uploadImg();
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
                                UserImagePicker(addedImage),
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
                              onPressed: UpdateUserData(),
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
}
