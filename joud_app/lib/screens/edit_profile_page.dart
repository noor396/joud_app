import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:joud_app/test/helper/authenticate.dart';
import 'package:toast/toast.dart';
import '../test/helper/authenticate.dart';
import '../test/services/auth.dart';

class EditProfilePage extends StatefulWidget {
  EditProfilePage(this.id, this.username, this.firstname, this.lastname,
      {this.key});
  final String id;
  final String username;
  final String firstname;
  final String lastname;
  final Key key;

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfilePage> {
  final usersRef = FirebaseFirestore.instance.collection('users');
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController nametext = TextEditingController();
  TextEditingController _firstname = TextEditingController();
  TextEditingController _lastname = TextEditingController();
  bool isLoading = false;
  User user;
  bool _displayNameValid = true;
  bool _bioValid = true;
  AuthMethods authMethods = new AuthMethods();
  @override
  void initState() {
    super.initState();
    getUser();
  }

  getUser() async {
    setState(() {
      isLoading = true;
    });
    DocumentSnapshot doc = await usersRef.doc(widget.id).get();
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('id', isEqualTo: widget.id)
        .get();
    nametext.text = widget.username;
    _firstname.text = widget.firstname;
    _lastname.text = widget.lastname;

    setState(() {
      isLoading = false;
    });
  }

  Column buildDisplayNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Text(
              "Display Name",
              style: TextStyle(color: Colors.grey),
            )),
        TextField(
          controller: nametext,
          decoration: InputDecoration(
           // hintText: "Update Display Name",
            errorText: _displayNameValid ? null : "Display Name too short",
          ),
        )
      ],
    );
  }
Column buildFirstNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Text(
              "First Name",
              style: TextStyle(color: Colors.grey),
            )),
        TextField(
          controller: _firstname,
          decoration: InputDecoration(
           // hintText: "Update Display Name",
            errorText: _displayNameValid ? null : "Display Name too short",
          ),
        )
      ],
    );
  }
  Column buildLastNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Text(
              "Last Name",
              style: TextStyle(color: Colors.grey),
            )),
        TextField(
          controller: _lastname,
          decoration: InputDecoration(
           // hintText: "Update Display Name",
            errorText: _displayNameValid ? null : "Display Name too short",
          ),
        )
      ],
    );
  }


  // Column buildBioField() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: <Widget>[
  //       Padding(
  //         padding: EdgeInsets.only(top: 12.0),
  //         child: Text(
  //           "Bio",
  //           style: TextStyle(color: Colors.grey),
  //         ),
  //       ),
  //       TextField(
  //         controller: bioController,
  //         decoration: InputDecoration(
  //           hintText: "Update Bio",
  //           errorText: _bioValid ? null : "Bio too long",
  //         ),
  //       )
  //     ],
  //   );
  // }

  updateProfileData() {
    setState(() {
      nametext.text.trim().length < 3 || nametext.text.isEmpty
          ? _displayNameValid = false
          : _displayNameValid = true;
    });

    if (_displayNameValid) {
      usersRef.doc(widget.id).update({
        "username": nametext.text,
        "firstname": _firstname.text,
        "lastname": _lastname.text
      });
      Toast.show("Profile updated!", context,
          duration: 3); //lan.getTexts('Post6')
      // SnackBar snackbar = SnackBar(content: Text("Profile updated!"));
      // _scaffoldKey.currentState.showSnackBar(snackbar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(230, 238, 156, 1.0),
        title: Text(
          "Edit Profile",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.done,
              size: 30.0,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                // Padding(
                //   padding: EdgeInsets.only(
                //     top: 16.0,
                //     bottom: 8.0,
                //   ),
                //   child: CircleAvatar(
                //     radius: 50.0,
                //     backgroundImage:
                //         CachedNetworkImageProvider(widget.),
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      buildDisplayNameField(),
                      buildFirstNameField(),
                      buildLastNameField(),
                    ],
                  ),
                ),

                SizedBox(
                  height: 12,
                ),
                GestureDetector(
                  onTap: () {
                    updateProfileData();
                    // ResetPassword();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 45,
                    width: MediaQuery.of(context).size.width /
                        1.5, //makes container expand vertically
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        const Color.fromRGBO(240, 244, 195, 1),
                        const Color.fromRGBO(189, 193, 146, 0.8),
                      ]),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      '    Update Profile    ',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ),

                // RaisedButton(
                //   onPressed: updateProfileData,
                //   child: Text(
                //     "Update Profile",
                //     style: TextStyle(
                //       color: Theme.of(context).primaryColor,
                //       fontSize: 20.0,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: FlatButton.icon(
                    onPressed: () {
                      authMethods.signOut();
                      // when we sign out we don't want the user to be able to go back to the chat screen so we used pushReplacement
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Authenticate()));
                    }, //logout,
                    icon: Icon(Icons.cancel, color: Colors.black),
                    label: Text(
                      "Logout",
                      style: TextStyle(color: Colors.black, fontSize: 20.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
