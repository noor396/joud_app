import 'dart:js';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../screens/home_screen.dart';

String phoneNo;
String smsCode;
String verificationId;

class phoneP extends StatefulWidget {
  @override
  _phoneLog createState() => _phoneLog();
}

class _phoneLog extends State<phoneP> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Center(
        child: Container(
          padding: EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                decoration:
                    InputDecoration(hintText: 'Enter your phone number'),
                onChanged: (value) {
                  phoneNo = value;
                },
              ),
              SizedBox(height: 10.0),
              RaisedButton(
                onPressed: verfiyPhone,
                child: Text('Verify'),
                textColor: Colors.black,
                elevation: 7.0,
                color: Color.fromRGBO(215, 204, 200, 1.0),
              )
            ],
          ),
        ),
      ),
    );
  }

  final PhoneCodeAutoRetrievalTimeout phoneCodeAutoRetrievalTimeout =
      (String verId) {
    verificationId = verId;
  };

  final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeRe]) {
    verificationId = verId;
    // smsCodeDialog(context).then((value) {
    //   print('sign in');
    // });
  };
  final PhoneVerificationCompleted verifiedSuccess = (u) {
    print('verified');
  };

  final PhoneVerificationFailed verifiedFailed = (e) {
    // FirebaseAuthException exception;
    print('not verified');
  };
  lSignIn() {
    FirebaseAuth.instance
        .signInWithPhoneNumber(
      verificationId, //: verificationId,
      //smsCode: smsCode
    )
        .then((value) {
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    }).catchError((e) {
      print(e);
    });
  }

  Future<void> verfiyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        codeSent: smsCodeSent,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verifiedSuccess,
        verificationFailed: verifiedFailed,
        codeAutoRetrievalTimeout: phoneCodeAutoRetrievalTimeout);
  }

  Future<void> /*<bool>*/ smsCodeDialog(BuildContext cont) {
    return showDialog(
        context: cont,
        barrierDismissible: false,
        builder: (BuildContext cont) {
          return new AlertDialog(
            title: Text('Enter the sms code'),
            content: TextField(
              onChanged: (value) {
                smsCode = value;
              },
            ),
            contentPadding: EdgeInsets.all(10.0),
            actions: <Widget>[
              new FlatButton(
                  child: Text('Done'),
                  onPressed: () {
                    var user = FirebaseAuth.instance.currentUser;
                    var uid;
                    if (user != null) {
                      uid = user.uid;
                      Navigator.of(cont).pop();
                      Navigator.of(cont)
                          .pushReplacementNamed(HomeScreen.routeName);
                    } else {
                      Navigator.of(cont).pop();
                      lSignIn();
                    }
                  }
                  // FirebaseAuth.instance.currentUser.reload().then((user) {
                  //   //if (user != null) {
                  //   if (FirebaseAuth.instance.currentUser != null) {
                  //     Navigator.of(cont).pop();
                  //     Navigator.of(cont).pushReplacementNamed('/HomePage');
                  //   } else {
                  //     Navigator.of(cont).pop();
                  //     lSignIn();
                  //   }
                  // });
                  // FirebaseAuth.instance.currentUser.then((u) {
                  //   if (u != null) {
                  //     Navigator.of(cont).pop();
                  //     Navigator.of(cont).pushReplacementNamed('/HomePage');
                  //   } else {
                  //     Navigator.of(cont).pop();
                  //     lSignIn();
                  //   }
                  // });
                  ),
            ],
          );
        });
  }
}
