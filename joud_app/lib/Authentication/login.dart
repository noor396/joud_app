import 'dart:io';
import 'package:flutter/material.dart';
import 'package:joud_app/test/views/rest.dart';
import 'package:joud_app/screens/home_screen.dart';
import 'package:joud_app/Widgets/userImagePicker.dart';

class LoginSc extends StatefulWidget {
  static const routeName = '/login';
  final void Function(String email, String password, String userName,
      File image, bool loggedIn, BuildContext ctx) userAuth;
  LoginSc(this.userAuth);

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginSc> {
  final formKey = new GlobalKey<FormState>();
  bool loggedIn = true;
  String email = "";
  String userName = "";
  String password = "";
  File userImageFile;

  void pickedImageFun(File pickedImage) {
    userImageFile = pickedImage;
  }

  Color greenColor = Color.fromRGBO(215, 204, 200, 1.0); //Color(0xFF00AF19);

  //To check fields during submit
  checkFields() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  //To Validate email
  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  void submit() {
    final isValid = formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (!loggedIn && userImageFile == null) {
      // ignore: deprecated_member_use
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Please pick an image'),
        backgroundColor: Theme.of(context).errorColor,
      ));
      return;
    }

    if (isValid) {
      formKey.currentState.save();
      widget.userAuth(email.trim(), password.trim(), userName.trim(),
          userImageFile, loggedIn, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal, //Color.fromRGBO(230, 238, 156, 1.0),
          flexibleSpace: Container(
            decoration: new BoxDecoration(
                gradient: new LinearGradient(
              //colors: [Colors.greenAccent , Colors.green],
              colors: [Colors.black],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            )),
          ),
          title: Text(
            'Registration',
            // lan.getTexts('Auth_Screen_AppBar'),
            style: TextStyle(
                fontSize: 25.0,
                color: Colors.white,
                fontFamily: "Schyler-Regular"),
          ),
          centerTitle: true,
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Form(key: formKey, child: _buildLoginForm())));
  }

  _buildLoginForm() {
    return Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: ListView(children: [
          SizedBox(height: 5.0),
          if (loggedIn)
            (Container(
                alignment: Alignment.bottomCenter,
                height: 125.0,
                width: 200.0,
                child: Stack(
                  children: [
                    logo(),
                  ],
                ))),

          SizedBox(height: 25.0),

          if (!loggedIn) UserImagePicker(pickedImageFun),
          TextFormField(
              decoration: InputDecoration(
                  labelText: 'EMAIL',
                  labelStyle: TextStyle(
                      fontFamily: 'Trueno',
                      fontSize: 12.0,
                      color: Colors.grey.withOpacity(0.5)),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: greenColor),
                  )),
              onChanged: (value) {
                this.email = value;
              },
              validator: (value) =>
                  value.isEmpty ? 'Email is required' : validateEmail(value)),
          if (!loggedIn)
            TextFormField(
              key: ValueKey('userName'),
              validator: (val) {
                if (val.isEmpty || val.length < 5) {
                  return 'Please enter a username with at least 5 characters';
                }
                return null;
              },
              onSaved: (val) => userName = val,
              decoration: InputDecoration(
                  labelText: 'USERNAME',
                  labelStyle: TextStyle(
                      fontFamily: 'Trueno',
                      fontSize: 12.0,
                      color: Colors.grey.withOpacity(0.5)),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: greenColor),
                  )),
            ),
          TextFormField(
              decoration: InputDecoration(
                  labelText: 'PASSWORD',
                  labelStyle: TextStyle(
                      fontFamily: 'Trueno',
                      fontSize: 12.0,
                      color: Colors.grey.withOpacity(0.5)),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: greenColor),
                  )),
              obscureText: true,
              onChanged: (value) {
                this.password = value;
              },
              validator: (value) => value.isEmpty || value.length < 6
                  ? 'Password is required'
                  : null),
          SizedBox(height: 5.0),
          GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ResetPassword()));
              },
              child: Container(
                  alignment: Alignment(1.0, 0.0),
                  padding: EdgeInsets.only(top: 15.0, left: 20.0),
                  child: InkWell(
                      child: Text('Forgot Password',
                          style: TextStyle(
                              color: Colors.teal,
                              fontFamily: 'Trueno',
                              fontSize: 11.0,
                              decoration: TextDecoration.underline))))),
          SizedBox(height: 30.0),
          RaisedButton(
              child: Text(loggedIn ? 'Login' : 'Sign up'),
              color: Color.fromRGBO(215, 204, 200, 1.0),
              onPressed: submit),
          SizedBox(height: 20.0),
          GestureDetector(
              onTap: () {
                // Navigator.of(context).push(
                //     MaterialPageRoute(builder: (context) => phoneP()));

                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
              child: Container(
                  alignment: Alignment(1.0, 0.0),
                  padding: EdgeInsets.only(top: 5.0, right: 90.0),
                  child: InkWell(
                      child: Text('Login with phone number',
                          style: TextStyle(
                              color: Colors.teal,
                              fontFamily: 'Trueno',
                              fontSize: 11.0,
                              decoration: TextDecoration.underline))))),
          SizedBox(height: 20.0),
          // GestureDetector(
          //     onTap: () {
          //       Navigator.of(context).push(
          //           MaterialPageRoute(builder: (context) => AdminSignInPage()));
          //     },
          //     child: Container(
          //         alignment: Alignment(1.0, 0.0),
          //         padding: EdgeInsets.only(top: 5.0, right: 120.0),
          //         child: InkWell(
          //             child: Text('I am an admin',
          //                 style: TextStyle(
          //                     color: Colors.teal,
          //                     fontFamily: 'Trueno',
          //                     fontSize: 11.0,
          //                     decoration: TextDecoration.underline))))),
          // SizedBox(height: 5.0),
          GestureDetector(
              onTap: () {
                setState(() {
                  loggedIn = !loggedIn;
                });
              },
              child: Container(
                  alignment: Alignment(1.0, 0.0),
                  padding: EdgeInsets.only(top: 5.0, right: 89.0),
                  child: InkWell(
                      child: Text(
                          loggedIn
                              ? 'Create a new account'
                              : 'Already have an account',
                          style: TextStyle(
                              color: Colors.teal,
                              fontFamily: 'Trueno',
                              fontSize: 11.0,
                              decoration: TextDecoration.underline))))),
        ]));
  }

  Widget logo() {
    return Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 110.0,
        child: Image.asset('assets/Joud_Logo.png'),
      ),
    );
  }
}
