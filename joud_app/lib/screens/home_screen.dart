import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:joud_app/lang/language_provider.dart';
import 'package:joud_app/screens/post_home_stream.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List resImageAndNameList = [
    {'pic': 'assets/pic1.jpg', 'text': 'Lara Lynn'},
    {'pic': 'assets/pic2.jpg', 'text': 'Michele Henderson'},
    {'pic': 'assets/pic3.jpg', 'text': 'Jessica Miles'},
    {'pic': 'assets/pic4.jpg', 'text': 'Natasha Gamble'},
    {'pic': 'assets/pic5.jpg', 'text': 'Kerry Herrera'},
    {'pic': 'assets/pic6.jpg', 'text': 'Martin Peck'},
    {'pic': 'assets/pic7.jpg', 'text': 'Tricia Yang'},
    {'pic': 'assets/pic8.jpg', 'text': 'Julia Petersen'},
    {'pic': 'assets/pic9.jpg', 'text': 'Erna Alexander'},
    {'pic': 'assets/pic10.jpg', 'text': 'Graciela Mitchell'},
  ];

  int _currentIndex;

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        body: buildCarousel(lan),
      ),
    );
  }

  ListView buildCarousel(lan) {
    return ListView(
      children: [
        //  colors: themeProvider.themeMode().gradient,
        SizedBox(
          height: 10,
        ),
        Card(
          child: ListTile(
            leading: Icon(
              FontAwesomeIcons.medal,
              color: Colors.yellowAccent,
              size: 50,
            ),
            title: Text(
              lan.getTexts('home_item1'),
              style: TextStyle(fontFamily: 'Quicksand'),
            ),
          ),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.white70, width: 1),
            borderRadius: BorderRadius.circular(40),
          ),
        ),
        //Stack(
        // children: [
        CarouselSlider(
          items: resImageAndNameList.map((resInfo) {
            return Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 186.0,
                  padding: EdgeInsets.only(top: 7),
                  child: Image.asset(
                    resInfo['pic'],
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 10,
                  child: Container(
                    width: 300,
                    color: Colors.black54,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 35),
                    child: Text(
                      resInfo["text"],
                      style: TextStyle(fontSize: 26, color: Colors.white),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
          options: CarouselOptions(
            onPageChanged: (int index, CarouselPageChangedReason reason) {
              setState(() {
                _currentIndex = index;
              });
            },
            height: 186,
            initialPage: 0,
            enlargeCenterPage: true,
            //autoPlay: true,
            //autoPlayInterval: Duration(seconds: 3),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildContainer(0),
            buildContainer(1),
            buildContainer(2),
            buildContainer(3),
            buildContainer(4),
            buildContainer(5),
            buildContainer(6),
            buildContainer(7),
            buildContainer(8),
            buildContainer(9),
          ],
        ),

        SizedBox(
          height: 20,
        ),
        Posthome(),
      ],
    );
  }

  Container buildContainer(index) {
    return Container(
      width: 10,
      height: 10,
      margin: EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentIndex == index
            ? Color.fromRGBO(230, 238, 156, 1.0)
            : Colors.blueGrey,
      ),
    );
  }
}

Posthome() {
  return ListView(
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    children: [
      SizedBox(
        height: 400,
        child: PostHomeStream(),
      ),
    ],
  );
}
