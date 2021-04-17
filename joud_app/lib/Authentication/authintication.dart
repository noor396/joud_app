import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:joud_app/lang/language_provider.dart';
import 'package:provider/provider.dart';

class AuthinticationScreen extends StatefulWidget {
  @override
  _AuthinticationScreenState createState() => _AuthinticationScreenState();
}

class _AuthinticationScreenState extends State<AuthinticationScreen> {
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
              lan.getTexts('Auth_Screen_AppBar'),
              style: TextStyle(
                  fontSize: 55.0,
                  color: Colors.black,
                  fontFamily: "Schyler-Regular"),
            ),
            centerTitle: true,
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.lock,
                    color: Color.fromRGBO(215, 204, 200, 1.0),
                  ),
                  text: lan.getTexts('Auth_Screen_Tab1'),
                ),
                Tab(
                  icon: Icon(
                    Icons.perm_contact_calendar,
                    color: Color.fromRGBO(215, 204, 200, 1.0),
                  ),
                  text: lan.getTexts('Auth_Screen_Tab2'),
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
           //     LoginSc(),
              //  Register_P(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
