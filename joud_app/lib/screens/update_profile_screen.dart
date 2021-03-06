// import 'dart:async';
// import 'dart:core';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:joud_app/Authentication/userauth.dart';
// import 'package:joud_app/Widgets/tabs_screen.dart';
// import 'package:joud_app/lang/language_provider.dart';
// import 'package:provider/provider.dart';

// class updateProfile extends StatefulWidget {
//   static const routeName = '/update_profile';
//   @override
//   UpdateProfileScreen createState() => UpdateProfileScreen();
// }

// class UpdateProfileScreen extends State<updateProfile> {
//   //var profilePicUrl;

//   @override
//   void initState() {
//     super.initState();
//    // profilePicUrl = FirebaseAuth.instance.currentUser.photoURL;
//   }

//   @override
//   Widget build(BuildContext context) {
//     var lan = Provider.of<LanguageProvider>(context, listen: true);
//     return Directionality(
//         textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
//         child: Scaffold(
//             appBar: AppBar(
//               leading: Padding(
//                   padding: EdgeInsets.only(left: 1),
//                   child: Row(
//                     children: [
//                       IconButton(
//                         onPressed: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => TabsScreen()));
//                         },
//                         icon: Icon(
//                           Icons.arrow_back_ios,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ],
//                   )),
//               title: Text(
//                 lan.getTexts('Update_Prof_title'),
//                 //"Update Profile", //"Update_Prof_title
//                 style: TextStyle(color: Colors.black),
//               ),
//               //  backgroundColor: Colors.teal //.fromRGBO(230, 238, 156, 1.0),
//               backgroundColor: Color.fromRGBO(230, 238, 156, 1.0),
//               centerTitle: true,
//             ),
//             body: new Stack(
//               children: <Widget>[
//                 ClipPath(
//                   child: Container(
//                     // color: Colors.teal.withOpacity(0.80),
//                     color: Color.fromRGBO(230, 238, 156, 1.0),
//                   ),
//                   clipper: getClipper(),
//                 ),
//                 Positioned(
//                   width: 350.0,
//                   top: MediaQuery.of(context).size.height / 5,
//                   child: Column(
//                     children: <Widget>[
//                       Container(
//                         width: 150.0,
//                         height: 150.0,
//                         decoration: BoxDecoration(
//                           //color: Colors.red,
//                           // photo
//                           image: DecorationImage(
//                               image: NetworkImage(FirebaseAuth.instance.currentUser.photoURL),
//                               fit: BoxFit.cover),
//                           borderRadius: BorderRadius.all(Radius.circular(75.0)),
//                           boxShadow: [
//                             BoxShadow(blurRadius: 7.0, color: Colors.black)
//                           ],
//                         ),
//                       ),
//                       SizedBox(height: 90.0),
//                       Text(
//                         // name
//                         FirebaseAuth.instance.currentUser.displayName,
//                         style: TextStyle(
//                             fontSize: 30.0,
//                             fontWeight: FontWeight.bold,
//                             fontFamily: 'Quicksand'),
//                       ),
//                       SizedBox(height: 25.0),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: <Widget>[
//                           Container(
//                             height: 30.0,
//                             width: 95.0,
//                             child: Material(
//                               borderRadius: BorderRadius.circular(20.0),
//                               color: Colors.teal,
//                               elevation: 7.0,
//                               child: GestureDetector(
//                                 onTap: () {
//                                   TextEditingController
//                                       userNameTextEditingController =
//                                       new TextEditingController();
//                                   TextFormField(
//                                     controller: userNameTextEditingController,
//                                     keyboardType: TextInputType.name,
//                                   );
//                                   FirebaseAuth.instance.currentUser
//                                       .updateProfile(
//                                           displayName:
//                                               userNameTextEditingController.text
//                                                   .trim());
//                                 },
//                                 child: Center(
//                                   child: Text(
//                                     lan.getTexts('Update_Prof_edit_name'),
//                                     //'Edit Name', // "Update_Prof_edit_name"
//                                     style: TextStyle(
//                                         color: Colors.white,
//                                         fontFamily: 'Quicksand'),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           //SizedBox(height: 25.0),
//                           Container(
//                             height: 30.0,
//                             width: 95.0,
//                             child: Material(
//                               borderRadius: BorderRadius.circular(20.0),
//                               color: Colors.teal,
//                               elevation: 7.0,
//                               child: GestureDetector(
//                                 onTap: () {
//                                   Navigator.of(context).pop();
//                                   Navigator.of(context)
//                                       .pushReplacementNamed('/selectImg');
//                                   // FirebaseAuth.instance.currentUser.photoURL;
//                                 },
//                                 child: Center(
//                                   child: Text(
//                                     lan.getTexts(
//                                         'Update_Prof_edit_photo'), //""Edit Photo
//                                     style: TextStyle(
//                                         color: Colors.white,
//                                         fontFamily: 'Quicksand'),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 25.0),
//                           Container(
//                             height: 30.0,
//                             width: 95.0,
//                             child: Material(
//                               borderRadius: BorderRadius.circular(20.0),
//                               color: Colors.teal,
//                               //color: Color.fromRgba(215, 204, 200, 1.0),
//                               elevation: 7.0,
//                               child: GestureDetector(
//                                   onTap: () {
//                                     FirebaseAuth.instance
//                                         .signOut()
//                                         .then((value) {
//                                       Navigator.of(context)
//                                           .pushReplacementNamed('/LoginSc');
//                                       Navigator.pop(context);
//                                       Route route = MaterialPageRoute(
//                                           builder: (c) => UserAuth());
//                                       Navigator.pushReplacement(context, route);
//                                     }).catchError((e) {
//                                       print(e);
//                                     });
//                                   },
//                                   child: Center(
//                                     child: Text(
//                                       lan.getTexts('Update_Prof_logout'),
//                                       // 'Log out', //"Update_Prof_logout"
//                                       style: TextStyle(
//                                           color: Colors.white,
//                                           fontFamily: 'Quicksand'),
//                                     ),
//                                   )),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             )));
//   }
// }


