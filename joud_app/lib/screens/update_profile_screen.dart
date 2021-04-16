import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:joud_app/Authentication/login.dart';
import 'package:joud_app/screens/selectProfileImg.dart';

class updateProfile extends StatefulWidget {
  static const routeName = '/update_profile';
  @override
  UpdateProfileScreen createState() => UpdateProfileScreen();
}

class UpdateProfileScreen extends State<updateProfile> {
  var profilePicUrl;

  @override
  void initState() {
    super.initState();
    profilePicUrl = FirebaseAuth.instance.currentUser.photoURL;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Update Profile",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Color.fromRGBO(230, 238, 156, 1.0),
        ),
        body: new Stack(
          children: <Widget>[
            ClipPath(
              child: Container(
                // color: Colors.teal.withOpacity(0.80),
                color: Color.fromRGBO(230, 238, 156, 1.0),
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
                          image: NetworkImage(profilePicUrl),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.all(Radius.circular(75.0)),
                      boxShadow: [
                        BoxShadow(blurRadius: 7.0, color: Colors.black)
                      ],
                    ),
                  ),
                  SizedBox(height: 90.0),
                  Text(
                    FirebaseAuth.instance.currentUser.displayName,
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Quicksand'),
                  ),
                  // if we like to add any thing related with profile
                  // SizedBox(height: 15.0),
                  // Text(
                  //   'Subscribe',
                  //   style: TextStyle(
                  //       fontSize: 30.0,
                  //       fontStyle: FontStyle.italic,
                  //       fontFamily: 'Quicksand'),
                  // ),
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
                            onTap: () {
                              FirebaseAuth.instance.currentUser.updateProfile();
                            },
                            child: Center(
                              child: Text(
                                'Edit Name',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Quicksand'),
                              ),
                            ),
                          ),
                        ),
                      ),
                      //SizedBox(height: 25.0),
                      Container(
                        height: 30.0,
                        width: 95.0,
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          shadowColor: Colors.yellowAccent,
                          color: Colors.yellow,
                          elevation: 7.0,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                              Navigator.of(context)
                                  .pushReplacementNamed('/selectImg');
                            },
                            child: Center(
                              child: Text(
                                'Edit Photo',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Quicksand'),
                              ),
                            ),
                          ),
                        ),
                      ),
                      //SizedBox(height: 25.0),
                      Container(
                        height: 30.0,
                        width: 95.0,
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          shadowColor: Colors.yellowAccent,
                          color: Colors.yellow,
                          //color: Color.fromRgba(215, 204, 200, 1.0),
                          elevation: 7.0,
                          child: GestureDetector(
                              onTap: () {
                                FirebaseAuth.instance.signOut().then((value) {
                                  Navigator.of(context)
                                      .pushReplacementNamed('/LoginSc');
                                  Navigator.pop(context);
                                  Route route = MaterialPageRoute(
                                      builder: (c) => LoginSc());
                                  Navigator.pushReplacement(context, route);
                                }).catchError((e) {
                                  print(e);
                                });
                              },
                              child: Center(
                                child: Text(
                                  'Log out',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Quicksand'),
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ));
  }
}

class getClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height / 1.9);
    path.lineTo(size.width + 125, 0.0);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
