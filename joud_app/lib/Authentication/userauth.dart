import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:joud_app/Authentication/login.dart';
import 'dart:io';

class UserAuth extends StatefulWidget {
  // static const routeName = '/loginSc';
  @override
  State<StatefulWidget> createState() {
    return UserAuthState();
  }
}

class UserAuthState extends State<UserAuth> {
  final auth = FirebaseAuth.instance;
  void submitAuthForm(String email, String password, String userName,
      File image, bool loggedIn, BuildContext ctx) async {
    UserCredential authResult;

    try {
      if (loggedIn) {
        authResult = await auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await auth.createUserWithEmailAndPassword(
            email: email, password: password);

        final imageRef = FirebaseStorage.instance
            .ref()
            .child('userImage')
            .child(authResult.user.uid +
                '.jpg'); // all camera pictures have this extension
        await imageRef.putFile(image);
        final imageUrl = await imageRef.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user.uid)
            .set({
          'userName': userName,
          'password': password,
          'imageUrl': imageUrl,
        });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('Password too weak');
      } else if (e.code == 'email-already-in-use') {
        print('The entered email already exists');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(189, 193, 146, 1),
      body: LoginSc(submitAuthForm),
    );
  }
}
