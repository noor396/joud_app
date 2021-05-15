import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:joud_app/widgets/post.dart';

class PostHomeStream extends StatefulWidget {
  @override
  _PostHomeStreamState createState() => _PostHomeStreamState();
  static const routeName = '/poststream';
}

class _PostHomeStreamState extends State<PostHomeStream> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('posts')
          .orderBy('timestamp', descending: true)
          .snapshots(), // after executing stream the below snapShot fetches the data
      builder: (ctx, snapShot) {
        if (snapShot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        final docs = snapShot.data.docs;
        return ListView.builder(
          //reverse: true,
          itemCount: docs.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (ctx, index) => Post(
            docs[index]['postId'],
            docs[index]['ownerId'],
            docs[index]['imageUrl'],
            docs[index]['username'],
            docs[index]['mediaUrl'],
            docs[index]['description'],
            docs[index]['location'],
            docs[index]['timestamp'].toDate(),
            key: ValueKey(snapShot.data.docs[index]),
          ),
        );
      },
    );
  }
}
