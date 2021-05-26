import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:joud_app/lang/language_provider.dart';
import 'package:joud_app/screens/map_using_google.dart';
import 'package:joud_app/screens/notification_stream.dart';
import 'package:joud_app/screens/notification_screen.dart';
import 'package:joud_app/test/modal/users.dart';
import '../screens/map_screen.dart';
import 'package:joud_app/screens/post_stream.dart';
import 'package:joud_app/screens/profile_stream.dart';
import 'package:provider/provider.dart';
import '../test/views/chatRooms.dart';
import '../test/views/search.dart';
import '../widgets/main_drawer.dart';
import '../screens/home_screen.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = '/tab';
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<Map<String, Object>> _pages = [];
  int _selectedPageIndex = 0;

  @override
  void initState() {
    Provider.of<LanguageProvider>(context, listen: false).getLan();
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);

    _pages = [
      {
        'page': HomeScreen(),
        'title': lan.getTexts('tab_item1'),
      },
      {
        'page': PostStream(),
        'title': lan.getTexts('tab_item2'),
      },
      {
        'page': Search(),
        'title': lan.getTexts('tab_item3'),
      },
      {
        'page': ChatRoom(),
        'title': lan.getTexts('tab_item4'),
      },
      {
        'page': ProfileStream(),
        'title': lan.getTexts('tab_item5'),
      },
      {
        'page': MapScreen(),
        'title': lan.getTexts('tab_item6'),
      },
    ];
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(
            _pages[_selectedPageIndex]['title'],
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Color.fromRGBO(230, 238, 156, 1.0),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.settings),
            color: Colors.black,
            onPressed: () => _scaffoldKey.currentState.openDrawer(),
          ),
          actions: [
            Padding(
                padding: EdgeInsets.only(right: 20.0, left: 20.0),
                child: GestureDetector(
                  onTap: () => Navigator.of(context)
                      .pushReplacementNamed(NotificationScreen.routeName),
                  child: Icon(
                    FontAwesomeIcons.bell,
                    size: 26.0,
                    color: Colors.black,
                  ),
                )),
          ],
        ),
        body: _pages[_selectedPageIndex]['page'],
        bottomNavigationBar: BottomNavigationBar(
          iconSize: 35,
          onTap: _selectPage,
          selectedItemColor: Color.fromRGBO(230, 238, 156, 1.0),
          unselectedItemColor: Colors.black,
          currentIndex: _selectedPageIndex,
          backgroundColor: Color.fromRGBO(215, 204, 200, 1.0),
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: lan.getTexts('HomeTab').toString(),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_box_outlined),
              label: lan.getTexts('AddPostTab').toString(),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: lan.getTexts('SearchTab').toString(),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: lan.getTexts('ChatTab').toString(),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: lan.getTexts('ProfileTab').toString(),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on),
              label: lan.getTexts('MapTab').toString(),
            ),
          ],
        ),
        drawer: MainDrawer(),
      ),
    );
  }
}
