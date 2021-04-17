import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:joud_app/Widgets/errorAlertDialog.dart';
import 'package:joud_app/screens/home_screen.dart';

class AuthService{
  //Handles Auth
  handleAuth() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return HomeScreen();
          } else {
            //return LoginSc();
          }
        });
  }

  //Sign out
  signOut() {
    FirebaseAuth.instance.signOut();
  }

  //SignIn
  signIn(AuthCredential authCreds) {
    FirebaseAuth.instance.signInWithCredential(authCreds);
  }

  signInWithOTP(smsCode, verId) {
    AuthCredential authCreds = PhoneAuthProvider.credential(
        //.getCredential(
        verificationId: verId,
        smsCode: smsCode);
    signIn(authCreds);
  }

  //Sign in
  signInV2(email, password , context) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((user) {
      print('Signed in');
    }).catchError((e) {
      print(e);
          showDialog(
                          context: context,
                          builder: (c) {
                            return ErrorAlertDialog(
                              msg:('you don\'t have an account'),
                            );
                          });
    });
  }

//signUp
  signUp(String email, String password) {
    return FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }

  //Reset Password
  resetPasswordLink(String email) {
    FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

 
}
