import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:joud_app/screens/profile_screen.dart';
import 'package:joud_app/test/modal/users.dart';

class ProfileStream extends StatefulWidget {
  @override
  _ProfileStreamState createState() => _ProfileStreamState();
}

class _ProfileStreamState extends State<ProfileStream> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .orderBy('timestamp', descending: true)
          .snapshots(), // after executing stream the below snapShot fetches the data
      builder: (ctx, snapShot) {
        if (snapShot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        final docs = snapShot.data.docs;

        return PageView.builder(
          itemCount: 1,
          itemBuilder: (ctx, index) => ProfileScreen(
            Users.userUId = docs[index]['id'],
            //docs[index]['id'],
            docs[index]['imageUrl'],
            docs[index]['username'],
            docs[index]['timestamp'],
            key: ValueKey(snapShot.data.docs[index]),
          ),
        );
      },
    );
  }
}
