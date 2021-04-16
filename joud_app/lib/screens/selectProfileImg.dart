import 'dart:io';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:joud_app/Authentication/login.dart';
import 'package:joud_app/screens/joudApp.dart';
import 'package:joud_app/screens/update_profile_screen.dart';

class SelectProfilePic extends StatefulWidget {
static const routeName = '/selectImg';
  @override
  _SelectImg createState() => _SelectImg();
}

class _SelectImg extends State<SelectProfilePic> {
  File newProfilePic;
  User_obj _user_obj = new User_obj();

  @override
  Widget build(Object context) {
    return new Scaffold(
        body: newProfilePic == null ? getchooseBut() : getUploadBut());
  }

  Widget getchooseBut() {
    return new Stack(
      children: <Widget>[
        ClipPath(
          child: Container(
            color: Colors.teal.withOpacity(0.8),
          ),
          clipper: getClipper(),
        ),
        Positioned(
          width: 350.0,
          top: MediaQuery.of(context).size.height / 5,
          child: Column(
            children: <Widget>[
              Container(
                width: 150.0,
                height: 150.0,
                decoration: BoxDecoration(
                  color: Colors.red,
                  image: DecorationImage(
                      image: NetworkImage(FirebaseAuth.instance.currentUser
                          .photoURL), //NetworkImage('url'),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.all(Radius.circular(75.0)),
                  boxShadow: [BoxShadow(blurRadius: 7.0, color: Colors.black)],
                ),
              ),
              SizedBox(height: 90.0),
              Text(
                'You have signed up',
                style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Quicksand'),
              ),
              SizedBox(height: 15.0),
              Text(
                'Choose a profile picture',
                style: TextStyle(
                    fontSize: 30.0,
                    fontStyle: FontStyle.italic,
                    fontFamily: 'Quicksand'),
              ),
              SizedBox(height: 25.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: 30.0,
                    width: 95.0,
                    child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      shadowColor: Colors.yellowAccent,
                      color: Colors.yellow,
                      elevation: 7.0,
                      child: GestureDetector(
                        onTap: getImage,
                        child: Center(
                          child: Text(
                            'Change a picture',
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'Quicksand'),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget getUploadBut() {
    return new Stack(
      children: <Widget>[
        ClipPath(
          child: Container(
            color: Colors.teal.withOpacity(0.8),
          ),
          clipper: getClipper(),
        ),
        Positioned(
          width: 350.0,
          top: MediaQuery.of(context).size.height / 5,
          child: Column(
            children: <Widget>[
              Container(
                width: 150.0,
                height: 150.0,
                decoration: BoxDecoration(
                  color: Colors.red,
                  image: DecorationImage(
                      image: NetworkImage(FirebaseAuth.instance.currentUser
                          .photoURL), //NetworkImage('url'),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.all(Radius.circular(75.0)),
                  boxShadow: [BoxShadow(blurRadius: 7.0, color: Colors.black)],
                ),
              ),
              SizedBox(height: 90.0),
              Text(
                'You have signed up',
                style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Quicksand'),
              ),
              SizedBox(height: 15.0),
              Text(
                'CTap upload to proceed',
                style: TextStyle(
                    fontSize: 30.0,
                    fontStyle: FontStyle.italic,
                    fontFamily: 'Quicksand'),
              ),
              SizedBox(height: 25.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: 30.0,
                    width: 95.0,
                    child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      shadowColor: Colors.yellowAccent,
                      color: Colors.yellow,
                      elevation: 7.0,
                      child: GestureDetector(
                        onTap: UploadAnImage,
                        child: Center(
                          child: Text(
                            'Change a picture',
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'Quicksand'),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  Future getImage() async {
    var temp = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      newProfilePic = temp;
    });
  }

  Future UploadAnImage() async {
    var randomnum = Random(25);
    Reference refe = FirebaseStorage.instance
        .ref()
        .child('profilepics/${randomnum.nextInt(5000).toString()}.jpg');
    UploadTask uploadTask = refe.putFile(newProfilePic);
    uploadTask.then((value) {
      User_obj.updatePic(value.ref.getDownloadURL().toString()).then((val) {
        Navigator.of(context).pushReplacementNamed('/homepage');
      });
    }).catchError((e) {
      print(e);
    });
  }
}
