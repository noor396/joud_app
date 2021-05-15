import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:joud_app/lang/language_provider.dart';
import 'package:joud_app/screens/comments.dart';
import 'package:joud_app/screens/profile_screen.dart';
import 'package:joud_app/screens/profile_stream.dart';
import 'package:joud_app/widgets/custom_image.dart';
import 'package:provider/provider.dart';
import 'package:time_ago_provider/time_ago_provider.dart' as timeAgo;

class Post extends StatefulWidget {
  Post(this.postId, this.ownerId, this.imageUrl, this.username, this.mediaUrl,
      this.description, this.location, this.timestamp,
      {this.key});

  final String postId;
  final String ownerId;
  final String imageUrl;
  final String username;
  final String mediaUrl;
  final String description;
  final String location;
  final DateTime timestamp;
  final Key key;
  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  final user = FirebaseAuth.instance.currentUser;

  buildPostHeader(lan) {
    timeAgo.setLocale('Ar', timeAgo.Arabic());
    /* return FutureBuilder(
        future:FirebaseFirestore.instance.collection('users').doc(widget.ownerId).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return circularProgress();
          }*/
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(widget.imageUrl),
            backgroundColor: Colors.grey,
          ),
          title: GestureDetector(
            onTap: () => showProfile(
              context,
              ownerId: widget.ownerId,
              username: widget.username,
              imageUrl: widget.imageUrl,
            ),
            child: Text(
              widget.username,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          subtitle: lan.isEn
              ? Text(widget.location + "\n" + timeAgo.format(widget.timestamp))
              : Text(widget.location +
                  "\n" +
                  timeAgo.format(widget.timestamp, locale: 'Ar')),
          trailing: IconButton(
            onPressed: () => handleDeletePost(context, lan),
            icon: Icon(Icons.more_vert),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[Expanded(child: Text(widget.description))],
          ),
        ),
      ],
    );
    //},
  }
  // );
  // }
  //

  handleDeletePost(BuildContext parentContext, lan) {
    return showDialog(
        context: parentContext,
        builder: (context) {
          return Directionality(
            textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
            child: SimpleDialog(
              title: Text(lan.getTexts('Post1')),
              children: <Widget>[
                SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context);
                      deletePost();
                    },
                    child: Text(
                      lan.getTexts('Post2'),
                      style: TextStyle(color: Colors.red),
                    )),
                SimpleDialogOption(
                    onPressed: () => Navigator.pop(context),
                    child: Text(lan.getTexts('Post3'))),
              ],
            ),
          );
        });
  }

  deletePost() async {
    // delete post itself
    FirebaseFirestore.instance
        .collection('posts')
        .doc(widget.postId)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
    // delete uploaded image for thep ost
    FirebaseStorage.instance.ref().child("post_$widget.postId.jpg").delete();
    // then delete all comments
    QuerySnapshot commentsSnapshot = await FirebaseFirestore.instance
        .collection('comments')
        .doc(widget.postId)
        .collection("comments")
        .get();
    commentsSnapshot.docs.forEach((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
    FirebaseFirestore.instance
        .collection('posts')
        .doc(widget.postId)
        .collection('likes')
        .doc(widget.ownerId)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
  }

  addLike(bool liked) {
    liked = !liked;
    if (liked) {
      FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.postId)
          .collection('likes')
          .doc(widget.ownerId)
          .set({'like': true});
    } else {
      FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.postId)
          .collection('likes')
          .doc(widget.ownerId)
          .delete();
    }
  }

  buildPostImage() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        //Image.network(widget.mediaUrl),
        cachedNetworkImage(widget.mediaUrl),
      ],
    );
  }

  buildPostFooter() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 40.0)),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('posts')
                  .doc(widget.postId)
                  .collection('likes')
                  .doc(widget.ownerId)
                  .snapshots(),
              builder: (ctx, snapShot) {
                if (!snapShot.hasData) {
                  return Center(
                      child: Icon(
                    Icons.favorite_border,
                    size: 28.0,
                  ));
                }
                if (snapShot.data.exists) {
                  return IconButton(
                    icon: Icon(
                      Icons.favorite,
                      size: 28.0,
                    ),
                    onPressed: () {
                      addLike(true);
                    },
                    color: Colors.pink,
                  );
                } else {
                  return IconButton(
                    icon: Icon(
                      Icons.favorite_border,
                      size: 28.0,
                    ),
                    onPressed: () {
                      addLike(false);
                    },
                    color: Colors.grey,
                  );
                }
              },
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('posts')
                  .doc(widget.postId)
                  .collection('likes')
                  .snapshots(),
              builder: (ctx, snapShot) {
                if (snapShot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: Text(snapShot.data.docs.length.toString()),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: Text("0"),
                  );
                }
              },
            ),
            Padding(padding: EdgeInsets.only(right: 20.0, top: 40.0)),
            GestureDetector(
              onTap: () => showComments(
                context,
                postId: widget.postId,
                ownerId: widget.ownerId,
                mediaUrl: widget.mediaUrl,
                username: widget.username,
                imageUrl: widget.imageUrl,
              ),
              child: Icon(
                Icons.comment_outlined,
                size: 28.0,
                color: Colors.green[900],
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        buildPostHeader(lan),
        buildPostImage(),
        buildPostFooter()
      ],
    );
  }
}

showProfile(BuildContext context,
    {String ownerId, String imageUrl, String username}) {
  //Navigator.of(context).pushNamed(ProfileScreen.routeName);
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ProfileScreen(
        ownerId,
        imageUrl,
        username,
      ),
    ),
  );
}

showComments(BuildContext context,
    {String postId,
    String ownerId,
    String mediaUrl,
    String username,
    String imageUrl}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return Comments(
      postId: postId,
      postOwnerId: ownerId,
      postMediaUrl: mediaUrl,
      postUserName: username,
      postImageUrl: imageUrl,
    );
  }));
}
