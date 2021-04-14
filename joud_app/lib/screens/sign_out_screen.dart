import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:joud_app/Authentication/login.dart';
import 'dart:developer';

import '../Authentication/login.dart';

class SignOutScreen extends StatelessWidget {
  static const routeName = '/sign_out';
  // double _screenWidth = MediaQuery.of(context).size.width;
  //double _screenHeight = MediaQuery.of(context).size.height;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sign Out",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color.fromRGBO(230, 238, 156, 1.0),
      ),

      // child: Text("Sign Out"),
      body: Column(
        children: [
          RaisedButton(
            onPressed: () {
              //signOutGoogle();

              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) {
                return LoginSc();
              }), ModalRoute.withName('/'));
              Navigator.of(context).pushNamed(LoginSc.routeName);
            },
          ),
          RaisedButton(
            child: Container(
              // width: _screenWidth / 2,
              //height: _screenHeight / 18,
              margin: EdgeInsets.only(top: 25),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.black),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      height: 30.0,
                      width: 30.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            onPressed: () {
              FirebaseAuth.instance.signOut().then((value) {
                //Navigator.of(context).pushReplacementNamed('/LoginSc');
                Navigator.pop(context);
                Route route = MaterialPageRoute(builder: (c) => LoginSc());
                Navigator.pushReplacement(context, route);
              }).catchError((e) {
                print(e);
              });
            },
          ),
        ],
      ),
    );
  }
}
