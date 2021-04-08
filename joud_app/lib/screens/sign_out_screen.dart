import 'package:flutter/material.dart';
class SignOutScreen extends StatelessWidget {
  static const routeName ='/sign_out';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("Sign Out",style: TextStyle(color: Colors.black),),
          backgroundColor: Color.fromRGBO(230, 238, 156, 1.0),
    ),
    body: Center(
      child: Text("Sign Out"),
    ),);
  }
}