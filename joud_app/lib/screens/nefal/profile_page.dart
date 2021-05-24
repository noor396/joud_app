// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:joud_app/Widgets/progress.dart';
// import 'package:joud_app/test/modal/users.dart';
// import 'edit_profile_page.dart';

// final usersReference = FirebaseFirestore.instance.collection('users');

// class ProfilePage extends StatefulWidget {
//   @override
//   _ProfilePageState createState() => _ProfilePageState();
//   //final String userProfileID;
//   // ProfilePage(this.userProfileID);
// }

// class _ProfilePageState extends State<ProfilePage> {
//   final String currentOnLinrUserId = Users.userUId;
//   // final usersReference = FirebaseFirestore.instance.collection('users');

//   createProfileFileTopView() {
//     // future:
//     // usersReference.doc(Users.userUId).get(); //widget.userProfileID
//           FirebaseFirestore database = FirebaseFirestore.instance;
//       //Reference ref = database.collection('users').get();
//     return FutureBuilder(builder: (context, dataSnapshot) {
//       // if (!dataSnapshot.hasData) {
//       //   return circularProgress();
//       // }

//       Users user ;//= Users.fromDocument(dataSnapshot.data);
//       return Padding(
//         padding: EdgeInsets.all(17.0),
//         child: Column(
//           children: <Widget>[
//             Row(
//               children: <Widget>[
//                 CircleAvatar(
//                   radius: 45.0,
//                   backgroundColor: Colors.grey,
//                   backgroundImage: CachedNetworkImageProvider(user.url),
//                 ),
//                 Expanded(
//                   child: Column(children: <Widget>[
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       mainAxisSize: MainAxisSize.max,
//                       children: <Widget>[
//                         createColumns('posts', 0),
//                         createColumns('follwers', 0),
//                         createColumns('follwing', 0),
//                       ],
//                     ),
//                   ]),
//                   flex: 1,
//                 )
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: <Widget>[
//                 createButton(),
//               ],
//             ),
//             Container(
//               alignment: Alignment.centerLeft,
//               padding: EdgeInsets.only(top: 13.0),
//               child: Text(
//                 user.username,
//                 style: TextStyle(fontSize: 14.0, color: Colors.white),
//               ),
//             ),
//             Container(
//               alignment: Alignment.centerLeft,
//               padding: EdgeInsets.only(top: 5.0),
//               child: Text(
//                 user.profileName,
//                 style: TextStyle(fontSize: 14.0, color: Colors.white),
//               ),
//             ),
//             Container(
//               alignment: Alignment.centerLeft,
//               padding: EdgeInsets.only(top: 3.0),
//               child: Text(
//                 user.bio,
//                 style: TextStyle(fontSize: 14.0, color: Colors.white70),
//               ),
//             ),
//           ],
//         ),
//       );
//     });
//   }

//   createButton() {
//     bool ownprofile =
//         currentOnLinrUserId == Users.userUId; // widget.userProfileID;
//     if (ownprofile) {
//       return createButtonTitleandFunction(
//           title: "Edir Profile", performFunction: editUserProfile);
//     }
//   }

//   createButtonTitleandFunction({String title, Function performFunction}) {
//     return Container(
//       padding: EdgeInsets.only(top: 3.0),
//       child: FlatButton(
//         onPressed: performFunction,
//         child: Container(
//           width: 245.0,
//           height: 26.0,
//           child: Text(
//             title,
//             style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
//           ),
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             color: Colors.grey,
//             border: Border.all(color: Colors.grey),
//             borderRadius: BorderRadius.circular(6.0),
//           ),
//         ),
//       ),
//     );
//   }

//   editUserProfile() {
//     Navigator.push(
//         context,
//         MaterialPageRoute(
//             builder: (context) => EditProfilePage(
//                 //  currentProfileUID: currentOnLinrUserId,
//                 )));
//   }

//   Column createColumns(String title, int count) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       mainAxisSize: MainAxisSize.min,
//       children: <Widget>[
//         Text(
//           count.toString(),
//           style: TextStyle(
//               fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//         Container(
//           margin: EdgeInsets.only(top: 5.0),
//           child: Text(
//             title,
//             style: TextStyle(
//                 fontSize: 16.0,
//                 color: Colors.grey,
//                 fontWeight: FontWeight.w400),
//           ),
//         ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       //   appBar: AppBar(
//       //     leading: Padding(
//       //         padding: EdgeInsets.only(left: 1),
//       //         child: Row(
//       //           children: [
//       //             IconButton(
//       //               onPressed: () {
//       //                 Navigator.push(context,
//       //                     MaterialPageRoute(builder: (context) => TabsScreen()));
//       //               },
//       //               icon: Icon(
//       //                 Icons.arrow_back_ios,
//       //                 color: Colors.black,
//       //               ),
//       //             ),
//       //           ],
//       //         )),
//       //    // title: Text(
//       //    //   'Profile Page',
//       //       //  lan.getTexts('Update_Prof_title'),
//       //       //"Update Profile", //"Update_Prof_title
//       //     // style: TextStyle(color: Colors.black),
//       //     //),
//       //   backgroundColor: Color.fromRGBO(230, 238, 156, 1.0),
//       //  //   centerTitle: true,
//       //  ),
//       body: ListView(
//         children: <Widget>[
//           createProfileFileTopView(),
//         ],
//       ),
//     );
//   }
// }
