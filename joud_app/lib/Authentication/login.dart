import 'dart:developer';
import 'dart:html';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:joud_app/Admin/adminlogin.dart';
import 'package:joud_app/lang/language_provider.dart';
import 'package:joud_app/widgets/customTextField.dart';
import 'package:joud_app/widgets/errorAlertDialog.dart';
import 'package:joud_app/widgets/loadAlertDialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:joud_app/screens/joudApp.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:google_sign_in/google_sign_in.dart';

class LoginSc extends StatefulWidget {
  @override
  LogInScreen createState() => LogInScreen();
}

final GoogleSingIn googleSingIn = new GoogleSignIn();
final FirebaseAuth _fauth = FirebaseAuth.instance;
User usernew;

class LogInScreen extends State<LoginSc> {
  //StatefulWidget {
  final TextEditingController emailtextEditingController =
      TextEditingController();
  final TextEditingController pass_wordtextEditingController =
      TextEditingController();
  final GlobalKey<FormState> from_key = GlobalKey<FormState>();

  //GoogleAuthProvider googleAuthProvider = new GoogleAuthProvider();

  //GoogleAuthProvider googleAuthCredential = new GoogleAuthProvider();
  @override
  void initState() {
    Provider.of<LanguageProvider>(context, listen: false).getLan();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenHeight = MediaQuery.of(context).size.height;
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  "assets/app_jo.png",
                  height: 240.0,
                  width: 240.0,
                ),
              ),
<<<<<<< HEAD
            ),
            Form(
              key: from_key,
              child: Column(
                children: [
                  CustomTextFiled(
                    controllr: emailtextEditingController,
                    data: Icons.email,
                    hintText: "Email",
                    isObsecure: false,
                  ),
                  CustomTextFiled(
                    controllr: pass_wordtextEditingController,
                    data: Icons.lock,
                    hintText: "Password",
                    isObsecure: true,
                    // icon : Icon(pass_wordtextEditingController != null
                    //  ? Icons.visibility
                    //  : Icons.visibility_off, color: Color(0xFFE6E6E6),
                    // ),
                    // onPressed: () {
                    //           model.passwordVisible =
                    //           !model
                    //               .passwordVisible;
                    //         }),),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            RaisedButton(
              onPressed: () {
                emailtextEditingController.text.isNotEmpty &&
                        pass_wordtextEditingController.text.isNotEmpty
                    ? loginUser()
                    : showDialog(
                        context: context,
                        builder: (c) {
                          return ErrorAlertDialog(
                            msg: "Please write email and password",
                          );
                        });
              },
              color: Color.fromRGBO(215, 204, 200, 1.0),
              child: Text(
                "Login",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            InkWell(
              child: Container(
                width: _screenWidth / 2,
                height: _screenHeight / 18,
                margin: EdgeInsets.only(top: 25),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        height: 30.0,
                        width: 30.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/google.jpg'),
                              fit: BoxFit.cover),
                          shape: BoxShape.circle,
                        ),
                      ),
                      Text(
                        'Sign in with Google',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              onTap: googleSingIn.signIn().then((result) {
                result.authentication.then((googlekey) {
                  FirebaseAuth.instance
                      .signInWithGoogle(
                          //signInWithGoogle signInWithGoogle
                          IdToken: googlekey.idToken,
                          accessToken: googlekey.accessToken)
                      .then((signInUser) {
                    print('Signed in as ${signInUser.displayName}');
                    Navigator.of(context).pushReplacementNamed(
                        '/home'); //  the name of home page
                  }).catchError((e) {
                    print(e);
                  });
                }).catchError((e) {
                  print(e);
                });
              }).catchError((e) {
                print(e);
              }),
            ),

            // RaisedButton(
            //   color: Color.fromRGBO(215, 204, 200, 1.0),
            //   child: Text(
            //     "Sign in with Google",
            //     style: TextStyle(
            //       color: Colors.black,
            //     ),
            //   ),
            //   elevation: 7.0,
            // onPressed: () {
            //   googleSingIn.signIn().then((result) {
            //     result.authentication.then((googlekey) {
            //       FirebaseAuth.instance
            //           .signInWithGoogle(
            //               IdToken: googlekey.idToken,
            //               accessToken: googlekey.accessToken)
            //           .then((signInUser) {
            //         print('Signed in as ${signInUser.displayName}');
            //         Navigator.of(context).pushReplacementNamed(
            //             '/home'); //  the name of home page
            //       }).catchError((e) {
            //         print(e);
            //       });
            //       }).catchError((e) {
            //         print(e);
            //       });
            //     }).catchError((e) {
            //       print(e);
            //     });
            //   },
            // ),
            Container(
              height: 4.0,
              width: _screenWidth * 0.8,
              color: Colors.green,
            ),
            SizedBox(
              height: 10.0,
            ),
            FlatButton.icon(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AdminSignInPage())),
              icon: Icon(
                Icons.nature_people,
                color: Colors.lime[400],
=======
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  lan.getTexts('login_Text_screen1'),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Form(
                key: from_key,
                child: Column(
                  children: [
                    CustomTextFiled(
                      controllr: emailtextEditingController,
                      data: Icons.email,
                      hintText: lan.getTexts('Login_hintText1'),
                      isObsecure: false,
                    ),
                    CustomTextFiled(
                      controllr: pass_wordtextEditingController,
                      data: Icons.person,
                      hintText: lan.getTexts('Login_hintText2'),
                      isObsecure: true,
                    ),
                  ],
                ),
              ),
              RaisedButton(
                onPressed: () {
                  emailtextEditingController.text.isNotEmpty &&
                          pass_wordtextEditingController.text.isNotEmpty
                      ? loginUser(lan) //Rama I add lan here
                      : showDialog(
                          context: context,
                          builder: (c) {
                            return ErrorAlertDialog(
                              msg: lan.getTexts('Login_AlertDialog_msg1'),
                            );
                          });
                },
                color: Color.fromRGBO(215, 204, 200, 1.0),
                child: Text(
                  lan.getTexts('Login_Text_screen2'),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              RaisedButton(
                color: Color.fromRGBO(215, 204, 200, 1.0),
                child: Text(
                  lan.getTexts('Login_Text_screen3'),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                elevation: 7.0,
                onPressed: () {
                  googleSingIn.signIn().then((result) {
                    result.authentication.then((googlekey) {
                      FirebaseAuth.instance
                          .signInWithGoogle(
                              IdToken: googlekey.idToken,
                              accessToken: googlekey.accessToken)
                          .then((signInUser) {
                        print('Signed in as ${signInUser.displayName}');
                        Navigator.of(context).pushReplacementNamed(
                            '/home'); //  the name of home page
                      }).catchError((e) {
                        print(e);
                      });
                    }).catchError((e) {
                      print(e);
                    });
                  }).catchError((e) {
                    print(e);
                  });
                },
              ),
              Container(
                height: 4.0,
                width: _screenWidth * 0.8,
                color: Colors.green,
>>>>>>> d086244aedabed570bd20123d67a53d4a08abea9
              ),
              SizedBox(
                height: 10.0,
              ),
              FlatButton.icon(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AdminSignInPage())),
                icon: Icon(
                  Icons.nature_people,
                  color: Colors.lime[400],
                ),
                label: Text(
                  lan.getTexts('Login_Text_screen4'),
                  style: TextStyle(
                      color: Color.fromRGBO(215, 204, 200, 1.0),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void loginUser(lan) async {
    //Rama I add lan her
    showDialog(
        context: context,
        builder: (c) {
          return LoadAlertDialog(
            message: lan.getTexts('Login_AlertDialog_msg2'),
          );
        });
    User firebaseuser;
    await User_obj.auth
        .signInWithEmailAndPassword(
      email: emailtextEditingController.text.trim(),
      password: pass_wordtextEditingController.text.trim(),
    )
        .then((authuser) {
      firebaseuser = authuser.user;
      Navigator.of(context)
          .pushReplacementNamed('/home'); // the name of home page
    }).catchError((error) {
      //print(error);
      showDialog(
          context: context,
          builder: (c) {
            return ErrorAlertDialog(
              msg: error.message.toString(),
            );
          });
    });
    // be sure this is true or no ???? and the next function
    if (firebaseuser != null) {
      readData(firebaseuser);
      // to move to home page
      // Navigator.pop(context);
      // Route route = MaterialPageRoute(builder: (c) => homePage());
      //  Navigator.pushReplacement(context, route);
    }
  }

  Future readData(User fuser) async {
    // ignore: unnecessary_statements
    FirebaseFirestore.instance
        .collection("users")
        .doc(fuser.uid)
        .get()
        .then((dataSnapShot) async {
      await User_obj.sharedPreferences.setString(
          "uid", dataSnapShot.data().update("uid", (value) => User_obj.userId));
      await User_obj.sharedPreferences.setString(
          User_obj.userEmail,
          dataSnapShot
              .data()
              .update(User_obj.userEmail, (value) => User_obj.userEmail));
      await User_obj.sharedPreferences.setString(
          User_obj.userName,
          dataSnapShot
              .data()
              .update(User_obj.userName, (value) => User_obj.userName));
      await User_obj.sharedPreferences.setString(
          User_obj.userAvaterUrl,
          dataSnapShot.data().update(
              User_obj.userAvaterUrl, (value) => User_obj.userAvaterUrl));
      // await User_obj.sharedPreferences.setString("uid", dataSnapShot.data().update("uid", (value) =>User_obj.userId));
      //     await User_obj.sharedPreferences.setString(User_obj.userEmail,dataSnapShot.data().update("userEmail", (value) => User_obj.userEmail));
      //     await User_obj.sharedPreferences.setString(User_obj.userName, dataSnapShot.data().update("User_obj."userName", (value) => User_obj.userName));
      //     await User_obj.sharedPreferences.setString(User_obj.userAvaterUrl, dataSnapShot.data().update("userAvaterUrl", (value) => User_obj.userAvaterUrl));
    });
  }
}
// Future<User> signInWithGoogle() async {
//   final GoogleSignInAccount googleSignInAccount =
//       await googleSignInAccount.signIn();

//   final GoogleSignInAuthentication googleSign = await googleSign.authentication;
// }
Future<User> signInWithGoogle() async {
  GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

  GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );
  UserCredential authResult = await _fauth.signInWithCredential(credential);

  usernew = authResult.user;

  assert(!usernew.isAnonymous);

  assert(await usernew.getIdToken() != null);

  User currentUser = await _fauth.currentUser;

  assert(usernew.uid == currentUser.uid);
  print("User Name: ${usernew.displayName}");
  print("User Email ${usernew.email}");
}

///////////////////////////////////// sign out code .....
/*

void signOutGoogle() async{
  await _googleSignIn.signOut();
  print("User Sign Out");
}

 */
