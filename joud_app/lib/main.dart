import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:joud_app/Authentication/login.dart';
import 'package:joud_app/Authentication/login_by_phone.dart';
import 'package:joud_app/Authentication/userauth.dart';
import 'package:joud_app/lang/language_provider.dart';
import 'package:joud_app/screens/about_screen.dart';
import 'package:joud_app/screens/delete_account_screen.dart';
import 'package:joud_app/screens/statistics_screen.dart';
import 'package:joud_app/screens/update_profile_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Authentication/phone_login.dart';


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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => PhoneSignInPage(),//UserAuth() , // LogoScreen(),
        updateProfile.routeName: (context) => updateProfile(),
        //UpdateProfileScreen.routeName: (context) => UpdateProfileScreen(),
        StatisticsScreen.routeName: (context) => StatisticsScreen(),
        DeleteAccountScreen.routeName: (context) => DeleteAccountScreen(),
        AboutScreen.routeName: (context) =>
            ChangeNotifierProvider<LanguageProvider>(
              create: (ctx) => LanguageProvider(),
              child: AboutScreen(),
            ),
        // nefal
        //SignOutScreen.routeName: (context) => SignOutScreen(),
      },
    );
  }
}
