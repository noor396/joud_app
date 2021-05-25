import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'edit_profile_page.dart';

class EditProfileStream extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
  static const routeName = '/edittream';
}

class _EditProfileState extends State<EditProfileStream> {
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
          itemBuilder: (ctx, index) => EditProfilePage(
            docs[index]['id'],
         //   docs[index]['imageUrl'],
           // docs[index]['timestamp'].toDate(),
            docs[index]['username'],
            key: ValueKey(snapShot.data.docs[index]),
          ),
        );
      },
    );
  }
}
