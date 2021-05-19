import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:joud_app/screens/about_screen.dart';
import 'package:joud_app/screens/logo_screen.dart';
import 'package:joud_app/screens/statistics_screen.dart';
import 'package:joud_app/screens/update_profile_screen.dart';
import 'package:provider/provider.dart';
import 'lang/language_provider.dart';
import 'test/helper/authenticate.dart';
import 'test/helper/sharedPreferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider<LanguageProvider>(
      create: (ctx) => LanguageProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
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
          updateProfile.routeName: (context) => updateProfile(),
          StatisticsScreen.routeName: (context) => StatisticsScreen(),
          AboutScreen.routeName: (context) =>
              ChangeNotifierProvider<LanguageProvider>(
                create: (ctx) => LanguageProvider(),
                child: AboutScreen(),
              ),
        },
        home: isLoggedIn != null
            ? isLoggedIn
                ? LogoScreen()
                : Authenticate()
            : Container(
                child: Center(
                child: Authenticate(),
              )));
  }
}
