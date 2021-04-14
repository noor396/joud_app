import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:joud_app/Authentication/login.dart';
import '../lang/language_provider.dart';
import 'package:provider/provider.dart';
import '../screens/sign_out_screen.dart';
import '../screens/update_profile_screen.dart';
import '../screens/about_screen.dart';
import '../screens/delete_account_screen.dart';
import '../screens/sign_out_screen.dart';
import '../screens/statistics_screen.dart';
import 'dart:io';

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
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        var ad = AlertDialog(
                          title: Text(lan.getTexts('Alert_dialog1'),
                              textDirection: lan.isEn
                                  ? TextDirection.ltr
                                  : TextDirection.rtl),
                          content: Container(
                            height: 150,
                            child: Column(
                              children: [
                                Divider(
                                  color: Colors.black,
                                ),
                                Container(
                                  width: 300,
                                  color: Color.fromRGBO(230, 238, 156, 1.0),
                                  child: ListTile(
                                    leading: Icon(Icons.image,
                                        textDirection: lan.isEn
                                            ? TextDirection.ltr
                                            : TextDirection.rtl),
                                    title: Text(lan.getTexts('Alert_dialog2'),
                                        textDirection: lan.isEn
                                            ? TextDirection.ltr
                                            : TextDirection.rtl),
                                    onTap: () {
                                      getImage(ImageSource.gallery);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: 300,
                                  color: Color.fromRGBO(230, 238, 156, 1.0),
                                  child: ListTile(
                                    leading: Icon(Icons.add_a_photo,
                                        textDirection: lan.isEn
                                            ? TextDirection.ltr
                                            : TextDirection.rtl),
                                    title: Text(lan.getTexts('Alert_dialog3'),
                                        textDirection: lan.isEn
                                            ? TextDirection.ltr
                                            : TextDirection.rtl),
                                    onTap: () {
                                      getImage(ImageSource.camera);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                        showDialog(
                          context: context,
                          builder: (BuildContext ctx) => ad,
                        );
                      },
                      child: _image == null
                          ? Container(
                              height: 90,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Color.fromRGBO(215, 204, 200, 1.0),
                                    width: 2.0),
                                //color: Color.fromRGBO(230, 238, 156, 1.0),
                                image: DecorationImage(
                                  alignment: Alignment.bottomCenter,
                                  image: AssetImage(
                                      'assets/update_profile_page.jpg'),
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            )
                          : Container(
                              height: 90,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Color.fromRGBO(215, 204, 200, 1.0),
                                    width: 2.0),
                                image: DecorationImage(
                                  alignment: Alignment.bottomCenter,
                                  image: FileImage(_image),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 70),
                        alignment: Alignment.center,
                        child: Text(
                          "Rama",
                          style: TextStyle(fontSize: 20),
                        )),
                  ],
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
                Navigator.of(context).pushNamed(UpdateProfileScreen.routeName);
              }),
              Divider(
                color: Colors.black12,
              ),
              /*  bulidListTile(lan.getTexts('drawer_item3'), Icons.history, () {
                Navigator.of(context).pushNamed(HistoryScreen.routeName);
              }),
              Divider(
                color: Colors.black12,
              ),*/
              bulidListTile(lan.getTexts('drawer_item3'), Icons.translate, () {
                /* Navigator.of(context).pushNamed(LanguageScreen.routeName);*/
              }),
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
                Navigator.of(context).pushNamed(StatisticsScreen.routeName);
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
                    FirebaseAuth.instance.currentUser.delete().then((value) {
                      Navigator.pop(context);
                      Route route =
                          MaterialPageRoute(builder: (c) => LoginSc());
                      Navigator.pushReplacement(context, route);
                    }).catchError((e) {
                      print(e);
                    });
                  },
                );

                // Navigator.of(context).pushNamed(DeleteAccountScreen.routeName);
              }),
              Divider(
                color: Colors.black12,
              ),
              bulidListTile(
                  lan.getTexts('drawer_item7'),
                  Icons
                      .question_answer /*IconData(0xf29c, fontFamily:'_kFontFam')*/,
                  () {
                Navigator.of(context).pushNamed(AboutScreen.routeName);
              }),
              Divider(
                color: Colors.black12,
              ),
              bulidListTile(lan.getTexts('drawer_item8'), Icons.logout, () {
                Navigator.of(context).pushNamed(SignOutScreen.routeName);
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
