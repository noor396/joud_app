import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:joud_app/Widgets/tabs_screen.dart';
import 'package:joud_app/lang/language_provider.dart';
import 'package:joud_app/test/helper/authenticate.dart';
import 'package:provider/provider.dart';

class SignOutScreen extends StatelessWidget {
  static const routeName = '/sign_out';
  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenHeight = MediaQuery.of(context).size.height;
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
        textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(
              leading: Padding(
                  padding: EdgeInsets.only(left: 1),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TabsScreen()));
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  )),
              title: Text(
                lan.getTexts('drawer_item8'), // 'Sign Out',
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Color.fromRGBO(230, 238, 156, 1.0),
              centerTitle: true,
            ),
            body: Container(
              width: _screenWidth,
              height: _screenHeight,
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                  ),
                  RaisedButton(
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 5, left: 50, right: 50),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        lan.getTexts('drawer_item8'), //  'Sign Out',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Authenticate()));
                    },
                  ),
                ],
              ),
            )));
  }
}
