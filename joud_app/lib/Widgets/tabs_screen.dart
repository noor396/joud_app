import 'package:flutter/material.dart';
import 'package:joud_app/lang/language_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/main_drawer.dart';
import '../screens/home_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/search_screen.dart';
import '../screens/chat_screen.dart';
import '../main.dart';
import '../screens/map_screen.dart';
import 'package:joud_app/screens/Map2.dart';
import '../screens/post_screen.dart';

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
        'page': PostScreen(),
        'title': lan.getTexts('tab_item2'),
      },
      {
        'page': SearchScreen(),
        'title': lan.getTexts('tab_item3'),
      },
      {
        'page': ChatScreen(),
        'title': lan.getTexts('tab_item4'),
      },
      {
        'page': ProfileScreen(),
        'title': lan.getTexts('tab_item5'),
      },
      {
        'page': MyLocation(), //MapScreen(),
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
            BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("")),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_box_outlined), title: Text("")),
            BottomNavigationBarItem(icon: Icon(Icons.search), title: Text("")),
            BottomNavigationBarItem(icon: Icon(Icons.chat), title: Text("")),
            BottomNavigationBarItem(icon: Icon(Icons.person), title: Text("")),
            BottomNavigationBarItem(
                icon: Icon(Icons.location_on), title: Text("")),
          ],
        ),
        drawer: MainDrawer(),
      ),
    );
  }
}
