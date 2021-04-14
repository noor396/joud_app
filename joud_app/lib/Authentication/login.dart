import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:joud_app/Admin/adminlogin.dart';
import 'package:joud_app/Authentication/privateRegister.dart';
import 'package:joud_app/lang/language_provider.dart';
import 'package:joud_app/widgets/customTextField.dart';
import 'package:joud_app/widgets/errorAlertDialog.dart';
import 'package:provider/provider.dart';
import 'package:flutter/rendering.dart';
import '../screens/home_screen.dart';

final FirebaseAuth _fauth = FirebaseAuth.instance;
User usernew;
final TextEditingController emailtextEditingController =
    TextEditingController();
final TextEditingController pass_wordtextEditingController =
    TextEditingController();
final GlobalKey<FormState> from_key = GlobalKey<FormState>();
String phoneNo;
String smsCode;
String verificationId;

class LoginSc extends StatefulWidget {
  static const routeName = '/login';
  @override
  _LogInScreen createState() => _LogInScreen();
}

class _LogInScreen extends State<LoginSc> {
  // @override
  void initState() {
    Provider.of<LanguageProvider>(context, listen: false).getLan();
    super.initState();
  }

  final PhoneCodeAutoRetrievalTimeout phoneCodeAutoRetrievalTimeout =
      (String verId) {
    verificationId = verId;
  };

  final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeRe]) {
    verificationId = verId;
    // smsCodeDialog(context).then((value) {
    //   print('sign in');
    // });
  };
  final PhoneVerificationCompleted verifiedSuccess = (u) {
    print('verified');
  };

  final PhoneVerificationFailed verifiedFailed = (e) {
    // FirebaseAuthException exception;
    print('not verified');
  };
  lSignIn() {
    FirebaseAuth.instance
        .signInWithPhoneNumber(
      verificationId, //: verificationId,
      //smsCode: smsCode
    )
        .then((value) {
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    }).catchError((e) {
      print(e);
    });
  }

  Future<void> verfiyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        codeSent: smsCodeSent,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verifiedSuccess,
        verificationFailed: verifiedFailed,
        codeAutoRetrievalTimeout: phoneCodeAutoRetrievalTimeout);
  }

  Future<void> /*<bool>*/ smsCodeDialog(BuildContext cont) {
    return showDialog(
        context: cont,
        barrierDismissible: false,
        builder: (BuildContext cont) {
          return new AlertDialog(
            title: Text('Enter the sms code'),
            content: TextField(
              onChanged: (value) {
                smsCode = value;
              },
            ),
            contentPadding: EdgeInsets.all(10.0),
            actions: <Widget>[
              new FlatButton(
                  child: Text('Done'),
                  onPressed: () {
                    var user = FirebaseAuth.instance.currentUser;
                    var uid;
                    if (user != null) {
                      uid = user.uid;
                      Navigator.of(cont).pop();
                      Navigator.of(cont)
                          .pushReplacementNamed(HomeScreen.routeName);
                    } else {
                      Navigator.of(cont).pop();
                      lSignIn();
                    }
                  }
                  // FirebaseAuth.instance.currentUser.reload().then((user) {
                  //   //if (user != null) {
                  //   if (FirebaseAuth.instance.currentUser != null) {
                  //     Navigator.of(cont).pop();
                  //     Navigator.of(cont).pushReplacementNamed('/HomePage');
                  //   } else {
                  //     Navigator.of(cont).pop();
                  //     lSignIn();
                  //   }
                  // });
                  // FirebaseAuth.instance.currentUser.then((u) {
                  //   if (u != null) {
                  //     Navigator.of(cont).pop();
                  //     Navigator.of(cont).pushReplacementNamed('/HomePage');
                  //   } else {
                  //     Navigator.of(cont).pop();
                  //     lSignIn();
                  //   }
                  // });
                  ),
            ],
          );
        });
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
                      // data : pass_wordtextEditingController != null
                      //  ? Icons.visibility
                      //  : Icons.visibility_off, //color: Color(0xFFE6E6E6),
                      // ),
                      // onP: () {
                      //           model.passwordVisible =
                      //           !model
                      //               .passwordVisible;
                      //         }),
                      //),
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
                      ? (FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: emailtextEditingController.text,
                              password: pass_wordtextEditingController.text)
                          .then((value) {
                          Navigator.of(context)
                              .pushReplacementNamed(HomeScreen.routeName);
                        }).catchError((e) {
                          print(e);
                        })) //loginUser(lan)
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
              RaisedButton(
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
                            shape: BoxShape.circle,
                          ),
                        ),
                        Text(
                          'Do\'nt have an account',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                onPressed: () {
                  // test the 2 statments
                  //1
                  ////  Navigator.of(context).pushNamed('/Register');
                  //or
                  //2
                  Navigator.pop(context);
                  Route route = MaterialPageRoute(builder: (c) => Register_P());
                  Navigator.pushReplacement(context, route);
                },
              ),
              Container(
                height: 4.0,
                width: _screenWidth * 0.8,
                color: Colors.green,
              ),
              SizedBox(
                height: 10.0,
              ),
              FlatButton.icon(
                // i am add label here i will test the code if its not nesseccary i will clear it.
                label: widget,
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AdminSignInPage())),
                icon: Icon(
                  Icons.nature_people,
                  color: Colors.lime[400],
                ),
              ),
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
                      ? (FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: emailtextEditingController.text,
                              password: pass_wordtextEditingController.text)
                          .then((value) {
                          Navigator.of(context)
                              .pushReplacementNamed(HomeScreen.routeName);
                        }).catchError((e) {
                          print(e);
                        })) //loginUser(lan) //Rama I add lan here
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
}

// void loginUser(lan) async {
//   //Rama I add lan her
//   showDialog(
//       context: context,
//       builder: (c) {
//         return LoadAlertDialog(
//           message: lan.getTexts('Login_AlertDialog_msg2'),
//         );
//       });
//   User firebaseuser;
//   await User_obj.auth
//       .signInWithEmailAndPassword(
//     email: emailtextEditingController.text.trim(),
//     password: pass_wordtextEditingController.text.trim(),
//   )
//       .then((authuser) {
//     firebaseuser = authuser.user;
//     Navigator.of(context)
//         .pushReplacementNamed('/HomeScreen'); // the name of home page
//   }).catchError((error) {
//     //print(error);
//     showDialog(
//         context: context,
//         builder: (c) {
//           return ErrorAlertDialog(
//             msg: error.message.toString(),
//           );
//         });
//   });
//   // be sure this is true or no ???? and the next function
//   if (firebaseuser != null) {
//     readData(firebaseuser);
//     // to move to home page
//     Navigator.pop(context);
//     Route route = MaterialPageRoute(builder: (c) => HomeScreen());
//     Navigator.pushReplacement(context, route);
//   }
// }

// Future readData(User fuser) async {
//   // ignore: unnecessary_statements
//   FirebaseFirestore.instance
//       .collection("users")
//       .doc(fuser.uid)
//       .get()
//       .then((dataSnapShot) async {
//     await User_obj.sharedPreferences.setString(
//         "uid", dataSnapShot.data().update("uid", (value) => User_obj.userId));
//     await User_obj.sharedPreferences.setString(
//         User_obj.userEmail,
//         dataSnapShot
//             .data()
//             .update(User_obj.userEmail, (value) => User_obj.userEmail));
//     await User_obj.sharedPreferences.setString(
//         User_obj.userName,
//         dataSnapShot
//             .data()
//             .update(User_obj.userName, (value) => User_obj.userName));
//     await User_obj.sharedPreferences.setString(
//         User_obj.userAvaterUrl,
//         dataSnapShot
//             .data()
//             .update(User_obj.userAvaterUrl, (value) => User_obj.userAvaterUrl));
//     // await User_obj.sharedPreferences.setString("uid", dataSnapShot.data().update("uid", (value) =>User_obj.userId));
//     //     await User_obj.sharedPreferences.setString(User_obj.userEmail,dataSnapShot.data().update("userEmail", (value) => User_obj.userEmail));
//     //     await User_obj.sharedPreferences.setString(User_obj.userName, dataSnapShot.data().update("User_obj."userName", (value) => User_obj.userName));
//     //     await User_obj.sharedPreferences.setString(User_obj.userAvaterUrl, dataSnapShot.data().update("userAvaterUrl", (value) => User_obj.userAvaterUrl));
//   });
// }

// also we dont need it

// Future<User> signInWithGoogle() async {
//   GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

//   GoogleSignInAuthentication googleSignInAuthentication =
//       await googleSignInAccount.authentication;

//   AuthCredential credential = GoogleAuthProvider.credential(
//     accessToken: googleSignInAuthentication.accessToken,
//     idToken: googleSignInAuthentication.idToken,
//   );
//   UserCredential authResult = await _fauth.signInWithCredential(credential);

//   usernew = authResult.user;

//   assert(!usernew.isAnonymous);

//   assert(await usernew.getIdToken() != null);

//   User currentUser = await _fauth.currentUser;

//   assert(usernew.uid == currentUser.uid);
//   print("User Name: ${usernew.displayName}");
//   print("User Email ${usernew.email}");
// }
