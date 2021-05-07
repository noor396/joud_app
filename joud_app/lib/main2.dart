import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:joud_app/screens/home_screen.dart';
import 'package:joud_app/test/helper/sharedPreferences.dart';
import 'test/helper/authenticate.dart';

void main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn = false;

  void initState(){
    getLoginState();
    super.initState();
  }

  getLoginState() async {
    await SharedPreferencesFunctions.getUserLoggedInSharedPreference().then((val){

      setState(() {
        isLoggedIn = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromRGBO(255,255,246,1),
        primarySwatch: Colors.blue,
      ),

        home: isLoggedIn != null ?  isLoggedIn ? HomeScreen() : Authenticate()
            : Container(
        child: Center(
        child: Authenticate(),

        )));
  }
}
