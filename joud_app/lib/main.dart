import 'package:flutter/material.dart';
import 'package:joud_app/lang/language_provider.dart';
import 'package:joud_app/screens/about_screen.dart';
import 'package:joud_app/screens/delete_account_screen.dart';
import 'package:joud_app/screens/logo_screen.dart';
import 'package:joud_app/screens/map_screen.dart';
import 'package:joud_app/screens/sign_out_screen.dart';
import 'package:joud_app/screens/statistics_screen.dart';
import 'package:joud_app/screens/update_profile_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
        '/': (context) => LogoScreen(),
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
