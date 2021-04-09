import 'dart:async';

import 'package:flutter/material.dart';
import 'package:joud_app/lang/language_provider.dart';
import 'package:joud_app/widgets/tabs_screen.dart';
import 'package:provider/provider.dart';

class Intro2Screen extends StatefulWidget {
  @override
  _Intro2ScreenState createState() => _Intro2ScreenState();
}

class _Intro2ScreenState extends State<Intro2Screen> {
  void initState() {
    Provider.of<LanguageProvider>(context, listen: false).getLan();
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (ctx) => ChangeNotifierProvider<LanguageProvider>(
              create: (ctx) => LanguageProvider(),
              child: TabsScreen(),
            ),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/Intro2_background.png',
                      ),
                      fit: BoxFit.cover)),
            ),
            Center(
              child: Card(
                child: Text(
                  lan.getTexts('intro2_sentence'),
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                color: Colors.black12,
                elevation: 10,
              ),
            )
          ],
        ),
      ),
    );
  }
}
