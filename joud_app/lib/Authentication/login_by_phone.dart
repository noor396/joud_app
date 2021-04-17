import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../screens/home_screen.dart';
import '_auth_serv.dart';

class phoneP extends StatefulWidget {
    static const routeName = '/phone';
  @override
  _phoneLog createState() => _phoneLog();
}

class _phoneLog extends State<phoneP> {
  final formKey = new GlobalKey<FormState>();
  var phoneNo, verificationId, smsCode;
  bool codeSent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(hintText: 'Enter phone number'),
                    onChanged: (val) {
                      setState(() {
                        this.phoneNo = val;
                      });
                    },
                  )),
              codeSent
                  ? Padding(
                      padding: EdgeInsets.only(left: 25.0, right: 25.0),
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(hintText: 'Enter OTP'),
                        onChanged: (val) {
                          setState(() {
                            this.smsCode = val;
                          });
                        },
                      ))
                  : Container(),
              Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: RaisedButton(
                      child: Center(
                          child: codeSent ? Text('Login') : Text('Verify')),
                      onPressed: () {
                        codeSent
                            ? AuthService()
                                .signInWithOTP(smsCode, verificationId)
                            : verifyPhone(phoneNo);
                      }))
            ],
          )),
    );
    // return Scaffold(
    //   body: new Center(
    //     child: Container(
    //       padding: EdgeInsets.all(25.0),
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: <Widget>[
    //           TextField(
    //             decoration:
    //                 InputDecoration(hintText: 'Enter your phone number'),
    //             onChanged: (value) {
    //               phoneNo = value;
    //             },
    //           ),
    //           SizedBox(height: 10.0),
    //           RaisedButton(
    //             onPressed: verfiyPhone,
    //             child: Text('Verify'),
    //             textColor: Colors.black,
    //             elevation: 7.0,
    //             color: Color.fromRGBO(215, 204, 200, 1.0),
    //           )
    //         ],
    //       ),
    //     ),
    //   ),
    // );

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

    Future<void> verfiyPhone() async {
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: phoneNo,
          codeSent: smsCodeSent,
          timeout: const Duration(seconds: 5),
          verificationCompleted: verifiedSuccess,
          verificationFailed: verifiedFailed,
          codeAutoRetrievalTimeout: phoneCodeAutoRetrievalTimeout);
    }
  }

  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      AuthService().signIn(authResult);
    };

    Future<void> smsCodeDialog(BuildContext cont) {
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
                new TextButton(
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

    final PhoneVerificationFailed verificationfailed = (e) {
      print('${e.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      setState(() {
        this.codeSent = true;
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }

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
}
