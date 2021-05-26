// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:joud_app/lang/language_provider.dart';
import 'package:joud_app/screens/home_screen.dart';
import 'package:joud_app/screens/notification_screen.dart';
import 'package:joud_app/screens/postform.dart';
import 'package:joud_app/test/modal/users.dart';
import 'package:provider/provider.dart';

class NotificationStream extends StatefulWidget {
  @override
  _NotificationStreamState createState() => _NotificationStreamState();
  static const routeName = '/notificationstream';
}

class _NotificationStreamState extends State<NotificationStream> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .orderBy('timestamp', descending: true)
          .snapshots(), // after executing stream the below snapShot fetches the data
      builder: (ctx, snapShot) {
        if (/*snapShot.data == null*/ snapShot.connectionState ==
            ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        final docs = snapShot.data.docs;
        return PageView.builder(
          // reverse: true,
          itemCount: 1,
          itemBuilder: (ctx, index) => NotificationScreen(
            //Users.userUId = docs[index]['id'],
            docs[index]['id'],
            docs[index]['imageUrl'],
            docs[index]['username'],
          ),
        );
      },
    );
  }
}
