import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:joud_app/lang/language_provider.dart';
import 'package:joud_app/screens/intro1_screen.dart';
import 'package:provider/provider.dart';
class LogoScreen extends StatefulWidget {
  @override
  _LogoScreenState createState() => _LogoScreenState();
}

class _LogoScreenState extends State<LogoScreen> {
  void initState(){
    Provider.of<LanguageProvider>(context ,listen: false).getLan();
    super.initState();
    Timer(
      Duration(seconds: 4),(){
        Navigator.pushReplacement(context,MaterialPageRoute(
            builder: (context)=>IntroScreen(),
            ),
        );
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Scaffold(
      body:
          Stack(
            children:[
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Color.fromRGBO(230, 238, 156, 1.0),),
              Center(child: Image.asset('assets/Joud_Logo.png',  height: 200,)),
              Padding(
                padding: const EdgeInsets.only(top: 400),
                child: Center(child: Image.asset('assets/loading.gif', height: 50,)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 470),
                child: Center(child: Text(lan.getTexts('logo_loading'),style: TextStyle(fontFamily: 'Quicksand', fontSize: 12 ,fontWeight: FontWeight.bold),)),
              ),
            ],
          ),
    );
  }
}
