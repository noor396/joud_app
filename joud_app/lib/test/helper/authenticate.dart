import 'package:flutter/material.dart';
import 'package:joud_app/test/views/login.dart';
import 'package:joud_app/test/views/signup.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignInScreen = true;

  void toggleView() {
    setState(() {
      showSignInScreen = !showSignInScreen; // to switch between login and signup
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignInScreen) {
      return Login(toggleView);
    } else {
      return Signup(toggleView);
    }
  }
}
