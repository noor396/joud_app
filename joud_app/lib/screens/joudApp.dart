import 'dart:core';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User_obj {
  static SharedPreferences sharedPreferences;
  static const String appName = 'JOUD';
  static User user;
  static FirebaseAuth auth;

  static final String userName = 'name';
  static final String userEmail = ' email';
  static String userPhoto = 'photoUrl';
  static final String userId = 'userId';

  static final String userAvaterUrl = 'url';
  static final String isSuccess = 'isSuccess';
  static final String addressId = 'addressId';
  static num counter = 0;

  storeNewUSer(user, context) {
    FirebaseFirestore.instance.collection('/users').add({
      'email': user.email,
      'uid': user.uid,
      'displayName': user.displayName,
      'photoUrl': user.photoUrl
    }).then((value) {
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed('/selectImg');
    }).catchError((e) {
      print(e);
    });
  }

  static updatePic(picUrl) {
    var userinfo = new UserInfo(picUrl);
    // userinfo.photoURL = picUrl;
    FirebaseAuth.instance.currentUser.updateProfile().then((value) {
      FirebaseFirestore.instance
          .collection('/users')
          .where('uid', isEqualTo: user.uid)
          .get()
          .then((d) {
        FirebaseFirestore.instance
            .doc('/users/${d.docs[0].id}')
            .update({'photoURL': picUrl}).then((value) {
          print('updated');
        }).catchError((e) {
          print(e);
        });
      });
    }).catchError((e) {
      print(e);
    });
  }
}
