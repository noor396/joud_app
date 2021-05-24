import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:joud_app/Authentication/login.dart';
import 'package:joud_app/Authentication/userauth.dart';
import 'package:joud_app/test/modal/users.dart';
import '../lang/language_provider.dart';
import 'package:provider/provider.dart';
import '../screens/update_profile_screen.dart';
import '../screens/about_screen.dart';
import '../screens/statistics_screen.dart';
import 'dart:io';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../test/helper/authenticate.dart';
import '../test/helper/authenticate.dart';
import '../test/services/auth.dart';

class MainDrawer extends StatefulWidget {
  //static const routeName = '/drawer';
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  File _image;
  final picker = ImagePicker();
  Future getImage(ImageSource src) async {
    final pickedFile = await picker.getImage(source: src);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected');
      }
    });
  }

  Widget bulidListTile(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 30,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 17,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    AuthMethods authMethods = new AuthMethods();
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 150,
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                alignment:
                    lan.isEn ? Alignment.centerLeft : Alignment.centerRight,
                color: Color.fromRGBO(230, 238, 156, 1.0),
                child: Container(
                  height: 90,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: Color.fromRGBO(215, 204, 200, 1.0), width: 2.0),
                    //color: Color.fromRGBO(230, 238, 156, 1.0),
                    image: DecorationImage(
                      alignment: Alignment.bottomCenter,
                      image: AssetImage('assets/Joud_Logo.png'),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),
              Container(
                height: 66,
                width: double.infinity,
                padding: EdgeInsets.only(left: 20),
                alignment:
                    lan.isEn ? Alignment.centerLeft : Alignment.centerRight,
                color: Color.fromRGBO(215, 204, 200, 1.0),
                child: Text(lan.getTexts('drawer_item1'),
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w900,
                    )),
              ),
              bulidListTile(lan.getTexts('drawer_item2'), Icons.sync, () {
                Navigator.of(context)
                    .pushReplacementNamed(updateProfile.routeName);
              }),
              Divider(
                color: Colors.black12,
              ),
              bulidListTile(
                  lan.getTexts('drawer_item3'), Icons.translate, () {}),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(lan.getTexts('sub_drawer_item1'),
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  Switch(
                    value: Provider.of<LanguageProvider>(context, listen: true)
                        .isEn,
                    onChanged: (newValue) {
                      Provider.of<LanguageProvider>(context, listen: false)
                          .changeLan(newValue);
                      Navigator.of(context).pop();
                    },
                    activeColor: Color.fromRGBO(230, 238, 156, 1.0),
                  ),
                  Text(lan.getTexts('sub_drawer_item2'),
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                ],
              ),
              Divider(
                color: Colors.black12,
              ),
              bulidListTile(
                  lan.getTexts('drawer_item5'), Icons.bar_chart_outlined, () {
                Navigator.of(context)
                    .pushReplacementNamed(StatisticsScreen.routeName);
              }),
              Divider(
                color: Colors.black12,
              ),
              bulidListTile(lan.getTexts('drawer_item6'), Icons.delete, () {
                RaisedButton(
                  child: Container(
                    // width: _screenWidth / 2,
                    //height: _screenHeight / 18,
                    margin: EdgeInsets.only(top: 25),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            height: 30.0,
                            width: 30.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onPressed: () {
                    // added by Nefal **
                    FirebaseFirestore.instance.doc('users').delete();
                    CollectionReference c =
                        FirebaseFirestore.instance.collection('users');
                    c
                        .doc(Users.userUId)
                        .delete()
                        .then((value) => {
                              //       //Navigator.pop(context)
                              // Route route =
                              //     MaterialPageRoute(builder: (c) => UserAuth());
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (c) => UserAuth()),
                              ),
                            })
                        .catchError((e) {
                      print(e);
                    });
                  },
                );
              }),

              // Uuid().v4()
              //FirebaseAuth.instance.currentUser.delete();
              //  FirebaseAuth.instance.currentUser.delete().then((value) {

              // FirebaseAuth.instance.currentUser.delete().then((value) {
              //   Navigator.pop(context);
              //   Route route =
              //       MaterialPageRoute(builder: (c) => UserAuth());
              //   Navigator.pushReplacement(context, route);
              Divider(
                color: Colors.black12,
              ),
              bulidListTile(
                  lan.getTexts('drawer_item7'), FontAwesomeIcons.questionCircle,
                  () {
                Navigator.of(context)
                    .pushReplacementNamed(AboutScreen.routeName);
              }),
              Divider(
                color: Colors.black12,
              ),
              bulidListTile(lan.getTexts('drawer_item8'), Icons.logout, () {
                // Navigator.of(context).pushNamed(SignOutScreen.routeName);
                authMethods.signOut();
                // when we sign out we don't want the user to be able to go back to the chat screen so we used pushReplacement
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Authenticate()));
                /* FirebaseAuth.instance.signOut().then((value) {
                  Navigator.of(context).pushReplacementNamed('/LoginSc');*/
                //Navigator.pop(context);
                /*Route route = MaterialPageRoute(builder: (c) => UserAuth());
                  Navigator.pushReplacement(context, route);
                }).catchError((e) {
                  print(e);
                });*/
              }),
              Divider(
                color: Colors.black12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
