import 'dart:developer';
import 'dart:html';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:joud_app/Admin/adminlogin.dart';
import 'package:joud_app/Widgets/customTextField.dart';
import 'package:joud_app/Widgets/errorAlertDialog.dart';
import 'package:joud_app/Widgets/loadAlertDialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:joud_app/pages/joudApp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:google_sign_in/google_sign_in.dart';

class LoginSc extends StatefulWidget {
  @override
  LogInScreen createState() => LogInScreen();
}

class LogInScreen extends State<LoginSc> {
  //StatefulWidget {
  final TextEditingController emailtextEditingController =
      TextEditingController();
  final TextEditingController pass_wordtextEditingController =
      TextEditingController();
  final GlobalKey<FormState> from_key = GlobalKey<FormState>();

  //GoogleAuthProvider googleAuthProvider = new GoogleAuthProvider();

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                "app_jo.png",
                height: 240.0,
                width: 240.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Login to your account",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Form(
              key: from_key,
              child: Column(
                children: [
                  CustomTextFiled(
                    controllr: emailtextEditingController,
                    data: Icons.email,
                    hintText: "Email",
                    isObsecure: false,
                  ),
                  CustomTextFiled(
                    controllr: pass_wordtextEditingController,
                    data: Icons.person,
                    hintText: "Password",
                    isObsecure: true,
                  ),
                ],
              ),
            ),
            RaisedButton(
              onPressed: () {
                emailtextEditingController.text.isNotEmpty &&
                        pass_wordtextEditingController.text.isNotEmpty
                    ? loginUser()
                    : showDialog(
                        context: context,
                        builder: (c) {
                          return ErrorAlertDialog(
                            msg: "Please write email and password",
                          );
                        });
              },
              color: Color.fromRGBO(215, 204, 200, 1.0),
              child: Text(
                "Login",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            RaisedButton(
              color: Color.fromRGBO(215, 204, 200, 1.0),
              child: Text(
                "Sign in with Google",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              elevation: 7.0,
              onPressed: () {
                //  googleAuthProvider.
              },
            ),
            Container(
              height: 4.0,
              width: _screenWidth * 0.8,
              color: Colors.green,
            ),
            SizedBox(
              height: 10.0,
            ),
            FlatButton.icon(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AdminSignInPage())),
              icon: Icon(
                Icons.nature_people,
                color: Colors.lime[400],
              ),
              label: Text(
                "I'm Admin",
                style: TextStyle(
                    color: Color.fromRGBO(215, 204, 200, 1.0),
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void loginUser() async {
    showDialog(
        context: context,
        builder: (c) {
          return LoadAlertDialog(
            message: "Authenticating, Please wait...",
          );
        });
    User firebaseuser;
    await User_obj.auth
        .signInWithEmailAndPassword(
      email: emailtextEditingController.text.trim(),
      password: pass_wordtextEditingController.text.trim(),
    )
        .then((authuser) {
      firebaseuser = authuser.user;
      Navigator.of(context)
          .pushReplacementNamed('/home'); // the name of home page
    }).catchError((error) {
      //print(error);
      showDialog(
          context: context,
          builder: (c) {
            return ErrorAlertDialog(
              msg: error.message.toString(),
            );
          });
    });
    // be sure this is true or no ???? and the next function
    if (firebaseuser != null) {
      readData(firebaseuser);
      // to move to home page
      // Navigator.pop(context);
      // Route route = MaterialPageRoute(builder: (c) => homePage());
      //  Navigator.pushReplacement(context, route);
    }
  }

  Future readData(User fuser) async {
    // ignore: unnecessary_statements
    FirebaseFirestore.instance
        .collection("users")
        .doc(fuser.uid)
        .get()
        .then((dataSnapShot) async {
      await User_obj.sharedPreferences.setString(
          "uid", dataSnapShot.data().update("uid", (value) => User_obj.userId));
      await User_obj.sharedPreferences.setString(
          User_obj.userEmail,
          dataSnapShot
              .data()
              .update(User_obj.userEmail, (value) => User_obj.userEmail));
      await User_obj.sharedPreferences.setString(
          User_obj.userName,
          dataSnapShot
              .data()
              .update(User_obj.userName, (value) => User_obj.userName));
      await User_obj.sharedPreferences.setString(
          User_obj.userAvaterUrl,
          dataSnapShot.data().update(
              User_obj.userAvaterUrl, (value) => User_obj.userAvaterUrl));
      // await User_obj.sharedPreferences.setString("uid", dataSnapShot.data().update("uid", (value) =>User_obj.userId));
      //     await User_obj.sharedPreferences.setString(User_obj.userEmail,dataSnapShot.data().update("userEmail", (value) => User_obj.userEmail));
      //     await User_obj.sharedPreferences.setString(User_obj.userName, dataSnapShot.data().update("User_obj."userName", (value) => User_obj.userName));
      //     await User_obj.sharedPreferences.setString(User_obj.userAvaterUrl, dataSnapShot.data().update("userAvaterUrl", (value) => User_obj.userAvaterUrl));
    });
  }
}
