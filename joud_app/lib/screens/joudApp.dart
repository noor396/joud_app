import 'dart:core';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User_obj {
  static SharedPreferences sharedPreferences;
  static const String appName = 'JOUD';
  static User user;
  static FirebaseAuth auth;

  static final String userName = 'name';
  static final String userEmail = ' email';
  static final String userPhoto = 'photoUrl';
  static final String userId = 'userId';

  static final String userAvaterUrl = 'url';
  static final String isSuccess = 'isSuccess';
  static final String addressId = 'addressId';
  static num counter = 0;
}
