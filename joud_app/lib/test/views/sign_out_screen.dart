import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:joud_app/test/helper/authenticate.dart';
import 'package:joud_app/test/services/auth.dart';

class SignOutScreen extends StatelessWidget {
  static const routeName = '/sign_out';
  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Sign Out", //
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Color.fromRGBO(230, 238, 156, 1.0),
        ),
        body: Container(
          width: _screenWidth,
          height: _screenHeight,
          child: Column(
            children: [
              SizedBox(
                height: 200,
              ),
              RaisedButton(
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 5, left: 50, right: 50),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    'Sign Out',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Authenticate()));
                },
              ),
            ],
          ),
        ));
  }
}
