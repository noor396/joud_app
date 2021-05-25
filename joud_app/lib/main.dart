import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:joud_app/lang/language_provider.dart';
import 'package:joud_app/screens/map_screen.dart';
import 'package:joud_app/screens/map_using_google.dart';
import 'package:joud_app/screens/update_profile_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/home_screen.dart';
import 'test/helper/authenticate.dart';
import 'test/helper/sharedPreferences.dart';
//import 'package:upgrader/upgrader.dart';

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
    // Only call clearSavedSettings() during testing to reset internal values.
    //Upgrader().clearSavedSettings(); // REMOVE this for release builds
// final appcastURL =
//         'https://raw.githubusercontent.com/larryaasen/upgrader/master/test/testappcast.xml';
//     final cfg = AppcastConfiguration(url: appcastURL, supportedOS: ['android']);
    return MaterialApp(
      // UpgradeAlert(
      //       appcastConfig: cfg,
      //       debugLogging: true,
      //       child: Center(child: Text('Checking...')),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => //MapScreen() ,//SignOutScreen(), MapPage() ,//
         //   isLoggedIn != null
                //? isLoggedIn
                //    ? //SignOutScreen()                    :
                     updateProfile(),
      //           Container(
      //               child: Center(
      //                 child: HomeScreen(),
      //               ),
      //             ),
      },
    );
  }
}
