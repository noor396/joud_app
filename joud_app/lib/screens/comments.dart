import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:joud_app/Authentication/userAuth.dart';
import 'package:joud_app/lang/language_provider.dart';
import 'package:joud_app/screens/profile_screen.dart';
import 'package:joud_app/test/helper/constants.dart';
import 'package:joud_app/test/modal/users.dart';
import 'package:joud_app/widgets/progress.dart';
import 'package:joud_app/widgets/tabs_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:time_ago_provider/time_ago_provider.dart' as timeAgo;
import 'package:image/image.dart' as Im;

class Comments extends StatefulWidget {
  final String postId;
  final String postOwnerId;
  final String postMediaUrl;
  final String postUserName;
  final String postImageUrl;
  final String Id;
  final String UserName;
  final String ImageUrl;

  Comments({
    this.postId,
    this.postOwnerId,
    this.postMediaUrl,
    this.postUserName,
    this.postImageUrl,
    this.Id,
    this.UserName,
    this.ImageUrl,
  });

  @override
  CommentsState createState() => CommentsState(
        postId: this.postId,
        postOwnerId: this.postOwnerId,
        postMediaUrl: this.postMediaUrl,
        postUserName: this.postUserName,
        postImageUrl: this.postImageUrl,
        Id: this.Id,
        UserName: this.UserName,
        ImageUrl: this.ImageUrl,
      );
  static const routeName = '/comments';
}

class CommentsState extends State<Comments> {
  TextEditingController commentController = TextEditingController();

  final String postId;
  final String postOwnerId;
  final String postMediaUrl;
  final String postUserName;
  final String postImageUrl;
  final DateTime timestamp = DateTime.now();
  final String Id;
  final String UserName;
  final String ImageUrl;
  bool isUploading = false;
  File _image;
  final picker = ImagePicker();
  CommentsState({
    this.postId,
    this.postOwnerId,
    this.postMediaUrl,
    this.postUserName,
    this.postImageUrl,
    this.Id,
    this.UserName,
    this.ImageUrl,
  });

  buildComments() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('comments')
            .doc(postId)
            .collection('comments')
            .orderBy("timestamp", descending: false)
            .snapshots(),
        builder: (context, snapShot) {
          if (!snapShot.hasData) {
            return circularProgress();
          }
          final docs = snapShot.data.docs;
          return ListView.builder(
            //reverse: true,
            itemCount: docs.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (ctx, index) => Comment(
              docs[index]['username'],
              docs[index]['comment'],
              docs[index]['timestamp'],
              docs[index]['avatarUrl'],
              docs[index]['userId'],
              docs[index]['postId'],
              //docs[index]['commentImage'],
              key: ValueKey(snapShot.data.docs[index]),
            ),
          );
        });
  }

  addComment(/*commentsUrl*/) {
    FirebaseFirestore.instance
        .collection('comments')
        .doc(postId)
        .collection("comments")
        .add({
      "username": UserName,
      "comment": commentController.text,
      "timestamp": timestamp,
      "avatarUrl": ImageUrl,
      "userId": Id,
      "postId": postId,
      //"commentImage":commentsUrl
    });
    bool isNotPostOwner = Users.userUId != Id /*Constants.myName != UserName*/;
    if (isNotPostOwner) {
      FirebaseFirestore.instance
          .collection('feed')
          .doc(postOwnerId)
          .collection('feedItems')
          .add({
        "type": "comment",
        "commentData": commentController.text,
        "timestamp": timestamp,
        "postId": postId,
        "userId": Id,
        "username": UserName,
        "userProfileImg": ImageUrl,
        "mediaUrl": postMediaUrl,
      });
    }
    commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
            padding: EdgeInsets.only(left: 1),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => TabsScreen()));
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                ),
              ],
            )),
        title: Text(
          lan.getTexts('Comments1'),
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color.fromRGBO(230, 238, 156, 1.0),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: buildComments()),
          Divider(),
          Directionality(
            textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
            child: ListTile(
              title: TextFormField(
                controller: commentController,
                decoration:
                    InputDecoration(labelText: lan.getTexts('Comments2')),
              ),
              trailing: TextButton(
                onPressed: addComment /*handleSubmit(lan)*/,
                child: Text(
                  lan.getTexts('Comments3'),
                  style: TextStyle(color: Colors.black),
                ),
              ),
              /* subtitle: IconButton(
                icon: Icon(FontAwesomeIcons.image),
                onPressed: () => selectImage(context, lan)),*/
            ),
          ),
        ],
      ),
    );
  }
}

class Comment extends StatefulWidget {
  final String username;
  final String comment;
  final Timestamp timestamp;
  final String avatarUrl;
  final String userId;
  final String postId;
  //final String commentImage;
  final Key key;

  Comment(this.username, this.comment, this.timestamp, this.avatarUrl,
      this.userId, this.postId,
      /*this.commentImage*/
      {this.key});

  @override
  _CommentState createState() => _CommentState();
}

showProfile(BuildContext context,
    {String ownerId, String imageUrl, String username, Timestamp timestamp}) {
  //Navigator.of(context).pushNamed(ProfileScreen.routeName);
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) =>
          ProfileScreen(ownerId, imageUrl, username, timestamp),
    ),
  );
}

class _CommentState extends State<Comment> {
  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    timeAgo.setLocale('Ar', timeAgo.Arabic());
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Column(
        children: <Widget>[
          ListTile(
            title: RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: widget.username,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black)),
              TextSpan(
                  text: " \n " + widget.comment,
                  style: TextStyle(color: Colors.black)),
            ])),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(widget.avatarUrl),
            ),
            subtitle: lan.isEn
                ? Text(timeAgo.format(widget.timestamp.toDate()))
                : Text(timeAgo.format(widget.timestamp.toDate(), locale: 'Ar')),
            onTap: () => showProfile(
              context,
              ownerId: widget.userId,
              username: widget.username,
              imageUrl: widget.avatarUrl,
              timestamp: widget.timestamp,
            ),
          ),
          /* ListTile(
            leading:CircleAvatar(
              backgroundImage: NetworkImage(widget.commentImage),
            ) ,
          ),*/
          Divider(),
        ],
      ),
    );
  }
}
