import 'package:flutter/material.dart';

class UpdateProfileScreen extends StatelessWidget {
  static const routeName = '/update_profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Profile",style: TextStyle(color: Colors.black),),
        backgroundColor: Color.fromRGBO(230, 238, 156, 1.0),
      ),
      body: Center(
        child: Text("Update Profile"),
      ),
    );
  }
}