import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:joud_app/Authentication/privateRegister.dart';
import 'package:joud_app/lang/language_provider.dart';
import 'package:provider/provider.dart';
import 'login.dart';

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
          
  return Directionality(
      textDirection:  TextDirection.ltr ,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(230, 238, 156, 1.0),
            flexibleSpace: Container(
              decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                //colors: [Colors.greenAccent , Colors.green],
                colors: [Colors.black],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              )),
            ),
            title: Text(
              'Registration Type',
             // lan.getTexts('Auth_Screen_AppBar'),
              style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                  fontFamily: "Schyler-Regular"),
            ),
            centerTitle: true,
            bottom: TabBar(
              tabs: [
                Tab(
                  
                  text:'Log in' //lan.getTexts('Auth_Screen_Tab1'),
                ),
                Tab(
                  text:'Sign up' //lan.getTexts('Auth_Screen_Tab2'),
                ),
              ],
              indicatorColor: Colors.white38,
              indicatorWeight: 5.0,
            ),
          ),
          body: Container(
            decoration: BoxDecoration(
                gradient: new LinearGradient(
              colors: [Colors.greenAccent, Colors.green],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            )),
            child: TabBarView(
              children: [
                //LoginSc(),
                Register_P(),
              ],
            ),
          ),
        ),
      ),
       
    );
  }
}
