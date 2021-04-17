import 'package:flutter/material.dart';
import 'package:joud_app/Authentication/register.dart';
import 'package:joud_app/Authentication/rest.dart';

import '_auth_serv.dart';

class LoginSc extends StatefulWidget {
  static const routeName = '/loginSc';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginSc> {
  final formKey = new GlobalKey<FormState>();

  String email, password;

  Color greenColor = Color(0xFF00AF19);

  //To check fields during submit
  checkFields() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  //To Validate email
  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Form(key: formKey, child: _buildLoginForm())));
  }

  _buildLoginForm() {
    return Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: ListView(children: [
          SizedBox(height: 75.0),
          Container(
              height: 125.0,
              width: 200.0,
              child: Stack(
                children: [
                  logo(),
                  // Positioned(
                  //   top: 50.0,
                  //   // child: Image.asset(
                  //   //   "assets/Joud_Logo.png",
                  //   //   // height: 180.0,
                  //   //   // width: 180.0,
                  //   // ),
                  // ),
                ],
              )),
          SizedBox(height: 25.0),
          TextFormField(
              decoration: InputDecoration(
                  labelText: 'EMAIL',
                  labelStyle: TextStyle(
                      fontFamily: 'Trueno',
                      fontSize: 12.0,
                      color: Colors.grey.withOpacity(0.5)),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: greenColor),
                  )),
              onChanged: (value) {
                this.email = value;
              },
              validator: (value) =>
                  value.isEmpty ? 'Email is required' : validateEmail(value)),
          TextFormField(
              decoration: InputDecoration(
                  labelText: 'PASSWORD',
                  labelStyle: TextStyle(
                      fontFamily: 'Trueno',
                      fontSize: 12.0,
                      color: Colors.grey.withOpacity(0.5)),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: greenColor),
                  )),
              obscureText: true,
              onChanged: (value) {
                this.password = value;
              },
              validator: (value) =>
                  value.isEmpty ? 'Password is required' : null),
          SizedBox(height: 5.0),
          GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ResetPassword()));
              },
              child: Container(
                  alignment: Alignment(1.0, 0.0),
                  padding: EdgeInsets.only(top: 15.0, left: 20.0),
                  child: InkWell(
                      child: Text('Forgot Password',
                          style: TextStyle(
                              color: greenColor,
                              fontFamily: 'Trueno',
                              fontSize: 11.0,
                              decoration: TextDecoration.underline))))),
          SizedBox(height: 50.0),
          GestureDetector(
            onTap: () {
              if (checkFields())
               AuthService().signInV2(email, password , context);
            },
            child: Container(
                height: 50.0,
                child: Material(
                    borderRadius: BorderRadius.circular(25.0),
                    //shadowColor: Colors.greenAccent,
                    color: Color.fromRGBO(215, 204, 200, 1.0),
                    //elevation: 7.0,
                    child: Center(
                        child: Text('LOGIN',
                            style: TextStyle(
                                color: Colors.black, fontFamily: 'Trueno'))))),
          ),
          SizedBox(height: 20.0),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/phone');
            },
            child: Container(
                height: 50.0,
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.transparent,
                          style: BorderStyle.solid,
                          width: 1.0),                      
                      color: Color.fromRGBO(215, 204, 200, 1.0),
                      borderRadius: BorderRadius.circular(25.0),
                      ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text('Login with phone number',
                            style: TextStyle(fontFamily: 'Trueno')),
                      ),
                    ],
                  ),
                )),
          ),
          SizedBox(height: 25.0),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('New to Joud ?'),
            SizedBox(width: 5.0),
            InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Register()));
                },
                child: Text('Register',
                    style: TextStyle(
                        color: greenColor,
                        fontFamily: 'Trueno',
                        decoration: TextDecoration.underline)))
          ])
        ]));
  }

  Widget logo() {
    return Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 110.0,
        child: Image.asset('assets/Joud_Logo.png'),
      ),
    );
  }
}



//                     
//                     InkWell(
//                             onTap: () {
//                               if (checkFields()) {
//                                 AuthService().signInV2(email, password);
//                               }
//                             },
//                             child: Container(
//                                 height: 40.0,
//                                 width: 100.0,
//                                 decoration: BoxDecoration(
//                                   color: Colors.green.withOpacity(0.2),
//                                 ),
//                                 child: Center(child: Text('Sign in'))))
//                   ],
//                 ),
//               ),
//               RaisedButton(
//                 onPressed: () {
//                   email.isNotEmpty && password.isNotEmpty
//                       ? (FirebaseAuth.instance
//                           .createUserWithEmailAndPassword(
//                               email: email, password: password)
//                           .then((value) {
//                           Navigator.of(context)
//                               .pushReplacementNamed(HomeScreen.routeName);
//                         }).catchError((e) {
//                           print(e);
//                         })) //loginUser(lan)
//                       : showDialog(
//                           context: context,
//                           builder: (c) {
//                             return ErrorAlertDialog(
//                               msg: "Please write email and password",
//                             );
//                           });
//                
//               FlatButton.icon(
//                 onPressed: () => Navigator.push(
//                     context, MaterialPageRoute(builder: (context) => phoneP())),
//                 icon: Icon(
//                   Icons.nature_people,
//                   color: Colors.lime[400],
//                 ),
//                 label: Text(
//                   lan.getTexts('Login by Phone number'),
//                   style: TextStyle(
//                       color: Color.fromRGBO(215, 204, 200, 1.0),
//                       fontWeight: FontWeight.bold),
//                 ),
//               ),
//               RaisedButton(
//                 child: Container(
//                   width: _screenWidth / 2,
//                   height: _screenHeight / 18,
//                   margin: EdgeInsets.only(top: 25),
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       color: Colors.black),
//                   child: Center(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: <Widget>[
//                         Container(
//                           height: 30.0,
//                           width: 30.0,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                           ),
//                         ),
//                         Text(
//                           'Do\'nt have an account',
//                           style: TextStyle(
//                               fontSize: 16.0,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 onPressed: () {
//                   // test the 2 statments
//                   //1
//                   ////  Navigator.of(context).pushNamed('/Register');
//                   //or
//                   //2
//                   Navigator.pop(context);
//                   Route route = MaterialPageRoute(builder: (c) => Register_P());
//                   Navigator.pushReplacement(context, route);
//                 },
//               ),
//               // Container(
//               //   height: 4.0,
//               //   width: _screenWidth * 0.8,
//               //   color: Colors.green,
//               // ),
//               SizedBox(
//                 height: 10.0,
//               ),

//               FlatButton.icon(
//                 // i am add label here i will test the code if its not nesseccary i will clear it.
//                 label: widget,
//                 onPressed: () => Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => AdminSignInPage())),
//                 icon: Icon(
//                   Icons.nature_people,
//                   color: Colors.lime[400],
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Text(
//                   lan.getTexts('login_Text_screen1'),
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//               // Form(
//               //   key: formKey,
//               //   child: Column(
//               //     children: [
//               //       CustomTextFiled(
//               //         controllr: email,
//               //         data: Icons.email,
//               //         hintText: lan.getTexts('Login_hintText1'),
//               //         isObsecure: false,
//               //       ),
//               //       CustomTextFiled(
//               //         controllr: password,
//               //         data: Icons.person,
//               //         hintText: lan.getTexts('Login_hintText2'),
//               //         isObsecure: true,
//               //       ),
//               //     ],
//               //   ),
//               // ),
//               // RaisedButton(
//               //   onPressed: () {
//               //     emailtextEditingController.text.isNotEmpty &&
//               //             pass_wordtextEditingController.text.isNotEmpty
//               //         ? (FirebaseAuth.instance
//               //             .createUserWithEmailAndPassword(
//               //                 email: emailtextEditingController.text,
//               //                 password: pass_wordtextEditingController.text)
//               //             .then((value) {
//               //             Navigator.of(context)
//               //                 .pushReplacementNamed(HomeScreen.routeName);
//               //           }).catchError((e) {
//               //             print(e);
//               //           })) //loginUser(lan) //Rama I add lan here
//               //         : showDialog(
//               //             context: context,
//               //             builder: (c) {
//               //               return ErrorAlertDialog(
//               //                 msg: lan.getTexts('Login_AlertDialog_msg1'),
//               //               );
//               //             });
//               //  },
//               //  color: Color.fromRGBO(215, 204, 200, 1.0),
//               //   child: Text(
//               //     lan.getTexts('Login_Text_screen2'),
//               //     style: TextStyle(
//               //       color: Colors.black,
//               //     ),
//               //   ),
//               // ),
//               // SizedBox(
//               //   height: 50.0,
//               // ),
//               // FlatButton.icon(
//               //   onPressed: () => Navigator.push(context,
//               //       MaterialPageRoute(builder: (context) => AdminSignInPage())),
//               //   icon: Icon(
//               //     Icons.nature_people,
//               //     color: Colors.lime[400],
//               //   ),
//               //   label: Text(
//               //     lan.getTexts('Login_Text_screen4'),
//               //     style: TextStyle(
//               //         color: Color.fromRGBO(215, 204, 200, 1.0),
//               //         fontWeight: FontWeight.bold),
//               //   ),
//               // ),
//               // SizedBox(
//               //   height: 50.0,
//               // ),

//                Container(
//                         height: 30.0,
//                         width: 95.0,
//                         child: Material(
//                           borderRadius: BorderRadius.circular(20.0),
//                           shadowColor: Colors.yellowAccent,
//                           color: Colors.yellow,
//                           elevation: 7.0,
//                           child: GestureDetector(
//                             onTap: () {
//                               Navigator.of(context).pop();
//                               Navigator.of(context)
//                                   .pushReplacementNamed('/selectImg');
//                             },
//                             child: Center(
//                               child: Text(
//                                 'Edit Photo',
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontFamily: 'Quicksand'),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       //SizedBox(height: 25.0),
//                       Container(
//                         height: 30.0,
//                         width: 95.0,
//                         child: Material(
//                           borderRadius: BorderRadius.circular(20.0),
//                           shadowColor: Colors.yellowAccent,
//                           color: Colors.yellow,
//                           //color: Color.fromRgba(215, 204, 200, 1.0),
//                           elevation: 7.0,
//                           child: GestureDetector(
//                               onTap: () {
//                                 FirebaseAuth.instance.signOut().then((value) {
//                                   Navigator.of(context)
//                                       .pushReplacementNamed('/LoginSc');
//                                   Navigator.pop(context);
//                                   Route route = MaterialPageRoute(
//                                       builder: (c) => LoginSc());
//                                   Navigator.pushReplacement(context, route);
//                                 }).catchError((e) {
//                                   print(e);
//                                 });
//                               },
//                               child: Center(
//                                 child: Text(
//                                   'Log out',
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontFamily: 'Quicksand'),
//                                 ),
//                               )),
//                         ),
//                       ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // void loginUser(lan) async {
// //   //Rama I add lan her
// //   showDialog(
// //       context: context,
// //       builder: (c) {
// //         return LoadAlertDialog(
// //           message: lan.getTexts('Login_AlertDialog_msg2'),
// //         );
// //       });
// //   User firebaseuser;
// //   await User_obj.auth
// //       .signInWithEmailAndPassword(
// //     email: emailtextEditingController.text.trim(),
// //     password: pass_wordtextEditingController.text.trim(),
// //   )
// //       .then((authuser) {
// //     firebaseuser = authuser.user;
// //     Navigator.of(context)
// //         .pushReplacementNamed('/HomeScreen'); // the name of home page
// //   }).catchError((error) {
// //     //print(error);
// //     showDialog(
// //         context: context,
// //         builder: (c) {
// //           return ErrorAlertDialog(
// //             msg: error.message.toString(),
// //           );
// //         });
// //   });
// //   // be sure this is true or no ???? and the next function
// //   if (firebaseuser != null) {
// //     readData(firebaseuser);
// //     // to move to home page
// //     Navigator.pop(context);
// //     Route route = MaterialPageRoute(builder: (c) => HomeScreen());
// //     Navigator.pushReplacement(context, route);
// //   }
// // }

// // Future readData(User fuser) async {
// //   // ignore: unnecessary_statements
// //   FirebaseFirestore.instance
// //       .collection("users")
// //       .doc(fuser.uid)
// //       .get()
// //       .then((dataSnapShot) async {
// //     await User_obj.sharedPreferences.setString(
// //         "uid", dataSnapShot.data().update("uid", (value) => User_obj.userId));
// //     await User_obj.sharedPreferences.setString(
// //         User_obj.userEmail,
// //         dataSnapShot
// //             .data()
// //             .update(User_obj.userEmail, (value) => User_obj.userEmail));
// //     await User_obj.sharedPreferences.setString(
// //         User_obj.userName,
// //         dataSnapShot
// //             .data()
// //             .update(User_obj.userName, (value) => User_obj.userName));
// //     await User_obj.sharedPreferences.setString(
// //         User_obj.userAvaterUrl,
// //         dataSnapShot
// //             .data()
// //             .update(User_obj.userAvaterUrl, (value) => User_obj.userAvaterUrl));
// //     // await User_obj.sharedPreferences.setString("uid", dataSnapShot.data().update("uid", (value) =>User_obj.userId));
// //     //     await User_obj.sharedPreferences.setString(User_obj.userEmail,dataSnapShot.data().update("userEmail", (value) => User_obj.userEmail));
// //     //     await User_obj.sharedPreferences.setString(User_obj.userName, dataSnapShot.data().update("User_obj."userName", (value) => User_obj.userName));
// //     //     await User_obj.sharedPreferences.setString(User_obj.userAvaterUrl, dataSnapShot.data().update("userAvaterUrl", (value) => User_obj.userAvaterUrl));
// //   });
// // }

// // also we dont need it

// // Future<User> signInWithGoogle() async {
// //   GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

// //   GoogleSignInAuthentication googleSignInAuthentication =
// //       await googleSignInAccount.authentication;

// //   AuthCredential credential = GoogleAuthProvider.credential(
// //     accessToken: googleSignInAuthentication.accessToken,
// //     idToken: googleSignInAuthentication.idToken,
// //   );
// //   UserCredential authResult = await _fauth.signInWithCredential(credential);

// //   usernew = authResult.user;

// //   assert(!usernew.isAnonymous);

// //   assert(await usernew.getIdToken() != null);

// //   User currentUser = await _fauth.currentUser;

// //   assert(usernew.uid == currentUser.uid);
// //   print("User Name: ${usernew.displayName}");
// //   print("User Email ${usernew.email}");
// // }
