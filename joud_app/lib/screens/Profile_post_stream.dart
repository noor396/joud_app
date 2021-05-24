import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:joud_app/widgets/post.dart';

class ProfilePostStream extends StatefulWidget {
  @override
  _ProfilePostStreamState createState() => _ProfilePostStreamState();
  static const routeName = '/profilepoststream';
  final String id;
  ProfilePostStream(this.id);
  
}

class _ProfilePostStreamState extends State<ProfilePostStream> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('posts')
          .where('ownerId', isEqualTo: widget.id)
          .orderBy('timestamp', descending: true)
          .snapshots(), // after executing stream the below snapShot fetches the data
      builder: (ctx, snapShot) {
        if (snapShot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        final docs = snapShot.data.docs;
        return Container(
          height: 400,
          child: ListView.builder(
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
                  )),
        );
      },
    );
  }
}
