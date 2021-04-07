import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:joud_app/Authentication/businessRegister.dart';
import 'package:joud_app/Authentication/privateRegister.dart';
import 'package:joud_app/lang/language_provider.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //double screenWidth = MediaQuery.of(context).size.width;
  @override
  void initState() {
    Provider.of<LanguageProvider>(context, listen: false).getLan();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            title: Text(lan.getTexts('register_AppBar_Txt')),
            //shadowColor: Colors.green,
            backgroundColor: Color.fromRGBO(230, 238, 156, 1.0),
          ),
          body: Stack(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                height: 50.0,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
                  onPressed: () {
                    Register_B();
                  },
                  padding: EdgeInsets.all(10.0),
                  color: Color.fromRGBO(0, 160, 227, 1),
                  textColor: Colors.white,
                  child: Text(lan.getTexts('register_Screen_Text1'),
                      style: TextStyle(fontSize: 15)),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                height: 50.0,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
                  onPressed: () {
                    //rama  Register_P();
                  },
                  padding: EdgeInsets.all(10.0),
                  color: Colors.white,
                  textColor: Color.fromRGBO(0, 160, 227, 1),
                  child: Text(lan.getTexts('register_Screen_Text2'),
                      style: TextStyle(fontSize: 15)),
                ),
              ),
            ],
          )),
    );
  }
}
