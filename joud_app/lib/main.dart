import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:joud_app/lang/language_provider.dart';
import 'package:joud_app/screens/update_profile_screen.dart';
import 'package:joud_app/test/views/sign_out_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/home_screen.dart';
import 'test/helper/authenticate.dart';
import 'test/helper/sharedPreferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  // await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider<LanguageProvider>(
      create: (ctx) => LanguageProvider(),
      child: MyApp(),
    ),
  );
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  bool isLoggedIn = false;

  void initState() {
    getLoginState();
    super.initState();
  }
  getLoginState() async {
    await SharedPreferencesFunctions.getUserLoggedInSharedPreference()
        .then((val) {
      setState(() {
        isLoggedIn = val;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) =>isLoggedIn != null ?  
        isLoggedIn ? Authenticate() : updateProfile()
        : Container(
       child: Center(child: HomeScreen() ,       
       ),
            ),   
      },
    );
  }
}
