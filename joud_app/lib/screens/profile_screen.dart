import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:joud_app/lang/language_provider.dart';
import 'package:joud_app/screens/Other_Profile_post_stream.dart';
import 'package:joud_app/screens/Profile_post_stream.dart';
import 'package:joud_app/screens/update_profile_screen.dart';
import 'package:provider/provider.dart';

import '../test/helper/constants.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile';
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
  ProfileScreen(this.id, this.imageUrl, this.username, {this.key});

  final String id;
  final String imageUrl;
  final String username;
  final Key key;
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isFollowing = false;
  bool isLoading = false;
  int postCount = 0;
  List<Widget> posts = [];
  final user = FirebaseAuth.instance.currentUser;
  int followerCount = 0;
  int followingCount = 0;
  int otherPostCount = 0;
  int otherFollowerCount = 0;
  int otherFollowingCount = 0;

  @override
  void initState() {
    super.initState();
    getProfilePosts();
    getOtherProfilePosts();
    getFollowers();
    getFollowing();
    checkIfFollowing();
  }

  checkIfFollowing() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('followers')
        .doc(widget.id)
        .collection('userFollowers')
        .doc(user.uid)
        .get();
    setState(() {
      isFollowing = doc.exists;
    });
  }

  getFollowers() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('followers')
        .doc(user.uid)
        .collection('userFollowers')
        .get();
    setState(() {
      followerCount = snapshot.docs.length;
    });
  }

  getFollowing() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('following')
        .doc(user.uid)
        .collection('userFollowing')
        .get();
    setState(() {
      followingCount = snapshot.docs.length;
    });
  }

  getProfilePosts() async {
    setState(() {
      isLoading = true;
    });
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('posts')
        .where('ownerId', isEqualTo: widget.id)
        .orderBy('timestamp', descending: true)
        .get();

    setState(() {
      isLoading = false;
      postCount = snapshot.docs.length;
      // posts = snapshot.docs.map<Widget>((e) => PostHomeStream()).toList();
    });
  }

  getOtherProfilePosts() async {
    setState(() {
      isLoading = true;
    });
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('posts')
        .where('ownerId', isEqualTo: widget.id)
        .orderBy('timestamp', descending: true)
        .get();

    setState(() {
      isLoading = false;
      otherPostCount = snapshot.docs.length;
    });
  }

  Column buildCountColumn(String label, int count) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          count.toString(),
          style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
        ),
        Container(
          margin: EdgeInsets.only(top: 4.0),
          child: Text(
            label,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  Container buildButton({String text, Function function}) {
    return Container(
      padding: EdgeInsets.only(top: 2.0),
      child: TextButton(
        onPressed: function,
        child: Container(
          width: 200.0,
          height: 27.0,
          child: Text(
            text,
            style: TextStyle(
              color: isFollowing ? Colors.black : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color:
                isFollowing ? Colors.white : Color.fromRGBO(215, 204, 200, 1.0),
            border: Border.all(
              color: isFollowing
                  ? Colors.grey
                  : Color.fromRGBO(215, 204, 200, 1.0),
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }

  editProfile() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => updateProfile()));
  }

  buildProfileButton(lan) {
    bool isProfileOwner = Constants.myName == widget.username;
    if (isProfileOwner) {
      return buildButton(text: lan.getTexts('Profile4'), function: editProfile);
    } else if (isFollowing) {
      return buildButton(
        text: lan.getTexts('Profile5'),
        function: handleUnfollowUser,
      );
    } else if (!isFollowing) {
      return buildButton(
        text: lan.getTexts('Profile6'),
        function: handleFollowUser,
      );
    }
  }

  handleUnfollowUser() {
    setState(() {
      isFollowing = false;
    });
    // remove follower
    FirebaseFirestore.instance
        .collection('followers')
        .doc(widget.id)
        .collection('userFollowers')
        .doc(user.uid)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
    // remove following
    FirebaseFirestore.instance
        .collection('following')
        .doc(user.uid)
        .collection('userFollowing')
        .doc(widget.id)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
    // delete activity feed item for them
    /*  activityFeedRef
        .document(widget.profileId)
        .collection('feedItems')
        .document(currentUserId)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });*/
  }

  handleFollowUser() {
    setState(() {
      isFollowing = true;
    });
    // Make auth user follower of THAT user (update THEIR followers collection)
    FirebaseFirestore.instance
        .collection('followers')
        .doc(widget.id)
        .collection('userFollowers')
        .doc(user.uid)
        .set({});
    // Put THAT user on YOUR following collection (update your following collection)
    FirebaseFirestore.instance
        .collection('following')
        .doc(user.uid)
        .collection('userFollowing')
        .doc(widget.id)
        .set({});
    // add activity feed item for that user to notify about new follower (us)
    /* activityFeedRef
        .document(widget.profileId)
        .collection('feedItems')
        .document(currentUserId)
        .setData({
      "type": "follow",
      "ownerId": widget.profileId,
      "username": currentUser.username,
      "userId": currentUserId,
      "userProfileImg": currentUser.photoUrl,
      "timestamp": timestamp,
    });*/
  }

  buildProfileHeader(lan) {
    /* return FutureBuilder(
      future:FirebaseFirestore.instance.collection('users').doc(widget.id).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return circularProgress();
        }*/
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Directionality(
        textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 40.0,
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage(widget.imageUrl),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          // buildHeaderData()
                          buildCountColumn(lan.getTexts('Profile1'),
                              postCount), //lan.getTexts('PostForm11')
                          buildCountColumn(
                              lan.getTexts('Profile2'), followerCount),
                          buildCountColumn(
                              lan.getTexts('Profile3'), followingCount),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          buildProfileButton(lan),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              alignment:
                  lan.isEn ? Alignment.centerLeft : Alignment.centerRight,
              padding: EdgeInsets.only(top: 12.0),
              child: Text(
                widget.username,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
    // },
    //);
  }

  buildHeaderData() {
    bool isProfileOwner = Constants.myName == widget.username;
    if (isProfileOwner) {
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          buildCountColumn("posts  ", postCount),
          buildCountColumn("followers  ", followerCount),
          buildCountColumn("following  ", followingCount),
        ],
      );
    } else {
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          buildCountColumn("posts  ", 0 /*otherPostCount*/),
          buildCountColumn("followers  ", 0 /*otherFollowerCount*/),
          buildCountColumn("following  ", 0 /*otherFollowingCount*/),
        ],
      );
    }
  }

  buildProfilePosts(lan) {
    bool isProfileOwner = Constants.myName == widget.username;
    if (isProfileOwner) {
      return ProfilePostStream(widget.id);
    } else {
      return Directionality(
          textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
          child: OtherProfilePostStream(
              widget.id)); //Center(child: Text("No Posts")
      // ));
    }
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: [
          buildProfileHeader(lan),
          Divider(
            height: 0.0,
          ),
          buildProfilePosts(lan),
        ],
      ),
    );
  }
}
