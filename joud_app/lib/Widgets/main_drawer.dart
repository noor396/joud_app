import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:joud_app/screens/nefal/nefal_test.dart';
import 'package:joud_app/test/modal/users.dart';
import '../lang/language_provider.dart';
import 'package:provider/provider.dart';
import '../screens/about_screen.dart';
import 'dart:io';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../test/helper/authenticate.dart';
import '../test/services/auth.dart';

class MainDrawer extends StatefulWidget {
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

  handleDeleteAccount(BuildContext parentContext, lan) {
    return showDialog(
        context: parentContext,
        builder: (context) {
          return Directionality(
            textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
            child: SimpleDialog(
              title: Text(lan.getTexts('delete_account')),
              children: <Widget>[
                SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context);
                      deleteAccount();
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

  deleteAccount() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(Users.userUId)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
        Route route = MaterialPageRoute(builder: (c) => Authenticate());
        Navigator.pushReplacement(context, route);
      }
    });
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
                    .pushReplacementNamed(EditProfileStream.routeName);
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
              /*bulidListTile(
                  lan.getTexts('drawer_item5'), Icons.bar_chart_outlined, () {
                Navigator.of(context).pushReplacementNamed(StatisticsScreen.routeName);
              }),
              Divider(
                color: Colors.black12,
              ),*/
              bulidListTile(lan.getTexts('drawer_item6'), Icons.delete, () {
                handleDeleteAccount(context, lan);
              }),
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
                authMethods.signOut();
                // when we sign out we don't want the user to be able to go back to the chat screen so we used pushReplacement
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Authenticate()));
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
