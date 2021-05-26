import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:joud_app/widgets/post.dart';

class NotificationPostStream extends StatefulWidget {
  @override
  _NotificationPostStreamState createState() => _NotificationPostStreamState();
  static const routeName = '/profilepoststream';
  NotificationPostStream(
    this.userid,
    this.postid,
    /*this.userUsername*/
  );
  final String userid;
  final String postid;
/*final String userImageUrl;
  final String userUsername;*/
}

class _NotificationPostStreamState extends State<NotificationPostStream> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('posts')
          .where('ownerId', isEqualTo: widget.userid)
          .where('postId', isEqualTo: widget.postid)
          //.orderBy('timestamp', descending: true)
          .snapshots(), // after executing stream the below snapShot fetches the data
      builder: (ctx, snapShot) {
        if (snapShot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        final docs = snapShot.data.docs;
        return SingleChildScrollView(
          child: Container(
            height: 700,
            child: PageView.builder(
                itemCount: 1,
                //scrollDirection: Axis.vertical,
                // shrinkWrap: true,
                itemBuilder: (ctx, index) => Post(
                      docs[index]['postId'],
                      docs[index]['ownerId'],
                      docs[index]['imageUrl'],
                      docs[index]['username'],
                      docs[index]['mediaUrl'],
                      docs[index]['description'],
                      docs[index]['location'],
                      docs[index]['timestamp'],
                      /*widget.userid,
                      widget.userImageUrl,
                      widget.userUsername,*/
                      key: ValueKey(snapShot.data.docs[index]),
                    )),
          ),
        );
      },
    );
  }
}
