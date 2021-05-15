import 'dart:io';
import 'package:flutter/material.dart';
import 'package:joud_app/Widgets/tabs_screen.dart';
import 'package:joud_app/lang/language_provider.dart';
import 'package:joud_app/screens/update_profile_screen.dart';
import 'package:joud_app/test/helper/sharedPreferences.dart';
import 'package:joud_app/test/services/auth.dart';
import 'package:joud_app/test/services/database.dart';
import 'package:joud_app/Widgets/userImagePicker.dart';
import 'package:joud_app/Widgets/widget.dart';
import 'package:joud_app/test/views/rest.dart';
import 'package:provider/provider.dart';

class Signup extends StatefulWidget {
  final Function toggle;
  Signup(this.toggle);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool isLoading = false;

  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  File userImageFile;

  void addedImage(File pickedImage) {
    userImageFile = pickedImage;
  }

  final formKey = GlobalKey<FormState>();
  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController userNameTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();
  TextEditingController _firstName = new TextEditingController();
  TextEditingController _lastName = new TextEditingController();

  signUpBtn() {
    if (userImageFile == null) {
      final snackBar = SnackBar(
          content: Text("Please upload an image ! "), //  "signup_msg1"
          backgroundColor: Color.fromRGBO(127, 0, 0, 1));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
    //FirebaseAuth.instance.currentUser.displayName.
    if (formKey.currentState.validate()) {
      Map<String, String> userInfoMap = {
        'username': userNameTextEditingController.text,
        'email': emailTextEditingController.text,
        'firstname': _firstName.text,
        'lastname': _lastName.text,
      };

      SharedPreferencesFunctions.saveUserEmailSharedPreference(
          emailTextEditingController.text); // we save email locally
      SharedPreferencesFunctions.saveUserNameSharedPreference(
          userNameTextEditingController.text); // we save username locally

      setState(() {
        isLoading = true;
      });
      // 1 or2 just becuase 1=2
      //1
      authMethods
          .createUser(
              _firstName.text,
              _lastName.text,
              emailTextEditingController.text,
              passwordTextEditingController.text)
          .then((value) {
        databaseMethods.uploadUserInfo(userInfoMap);
        SharedPreferencesFunctions.saveUserLoggedInSharedPreference(
            true); // the user will be loggen in here so we have to save his state
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => updateProfile()));
      });

      //2
      // authMethods
      //     .signUpWithEmailAndPassword(emailTextEditingController.text,
      //         passwordTextEditingController.text)
      //     .then((val) {
      //   //print("${val.uid}");

      //   databaseMethods.uploadUserInfo(userInfoMap);
      //   SharedPreferencesFunctions.saveUserLoggedInSharedPreference(
      //       true); // the user will be loggen in here so we have to save his state
      //   Navigator.pushReplacement(
      //       context,
      //       MaterialPageRoute(
      //           builder: (context) =>
      //               updateProfile())); // we used pushReplacement to avoid going back to the sign in or signup screen
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
        textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
        child: Scaffold(
          appBar: appBarCustom(context),
          body: isLoading
              ? Center(child: Container(child: CircularProgressIndicator()))
              : Center(
                  child: Card(
                    margin: EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            UserImagePicker(addedImage),
                            SizedBox(
                              height: 20,
                            ),
                            Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                      decoration: InputDecoration(
                                          labelText: lan.getTexts(
                                              'signuplabel1') // 'First Name'
                                          ), //"signuplabel1"
                                      //onSaved: (value) => _firstName = value,
                                      controller: _firstName),
                                  TextFormField(
                                      decoration: InputDecoration(
                                          labelText: lan.getTexts(
                                              'signuplabel2') // 'LastName'
                                          ), //"signuplabel2"
                                      controller: _lastName
                                      // onSaved: (value) => _lastName = value,
                                      ),
                                  TextFormField(
                                    validator: (val) {
                                      return RegExp(
                                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                              .hasMatch(val)
                                          ? null
                                          : lan.getTexts(
                                              'signup_msg2'); //"Please enter a correct email address"; // "signup_msg2"
                                    },
                                    controller: emailTextEditingController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration:
                                        textFieldInputDecoration('email'),
                                  ),
                                  TextFormField(
                                    validator: (val) {
                                      // this validator validates the entered text in the field according to the condition we have set
                                      return val.isEmpty || val.length < 5
                                          ? lan.getTexts(
                                              'signup_msg3') // 'Username is too short' // "signup_msg3"
                                          : null;
                                    },
                                    controller: userNameTextEditingController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: textFieldInputDecoration(
                                        lan.getTexts(
                                            'signuplabel3') //'username'
                                        ), //"signuplabel3"
                                  ),
                                  TextFormField(
                                    validator: (val) {
                                      return val.length > 6
                                          ? null
                                          : lan.getTexts(
                                              'signup_msg4'); //'Please enter a password with at least 6 characters';// "signup_msg4"
                                    },
                                    controller: passwordTextEditingController,
                                    decoration: textFieldInputDecoration(
                                        lan.getTexts(
                                            'signuplabel4') //'password'
                                        ), //"signuplabel4"
                                    obscureText: true,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ResetPassword()));
                                  //  ResetPassword();
                                },
                                child: Container(
                                    alignment: Alignment(1.0, 0.0),
                                    padding:
                                        EdgeInsets.only(top: 15.0, left: 20.0),
                                    child: InkWell(
                                        child: Text(
                                            lan.getTexts(
                                                'signup_msg5'), //'Forgot Password', //  "signup_msg5"
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontFamily: 'Trueno',
                                                fontSize: 11.0,
                                                decoration: TextDecoration
                                                    .underline))))),
                            SizedBox(
                              height: 12,
                            ),
                            GestureDetector(
                              onTap: () {
                                signUpBtn();
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 45,
                                width: MediaQuery.of(context)
                                    .size
                                    .width, //makes container expand vertically
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    const Color.fromRGBO(215, 204, 200, 1),
                                    const Color.fromRGBO(166, 155, 151, 0.7),
                                    // const Color.fromRGBO(255,255,251,1),
                                  ]),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Text(
                                  lan.getTexts('signup_up'),
                                  //  'Sign Up', //"signup_up"
                                  style: TextStyle(fontSize: 17),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            // Container(
                            //   alignment: Alignment.center,
                            //   height: 45,
                            //   width: MediaQuery.of(context)
                            //       .size
                            //       .width, //makes container expand vertically
                            //   padding: EdgeInsets.symmetric(horizontal: 20),
                            //   decoration: BoxDecoration(
                            //     gradient: LinearGradient(colors: [
                            //       const Color.fromRGBO(240, 244, 195, 1),
                            //       const Color.fromRGBO(189, 193, 146, 0.8),
                            //     ]),
                            //     borderRadius: BorderRadius.circular(30),
                            //   ),
                            //   child: Text(
                            //     'Sign Up with Google',
                            //     style: TextStyle(fontSize: 17),
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: 12,
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  lan.getTexts('signup_text1'),
                                  //   "Already have an account?  ",//"signup_text1"
                                ),
                                SizedBox(height: 5.0),
                                GestureDetector(
                                    onTap: () {
                                      widget.toggle();
                                    },
                                    child: Container(
                                        alignment: Alignment(1.0, 0.0),
                                        padding: EdgeInsets.only(
                                            top: 15.0, left: 20.0),
                                        child: InkWell(
                                            child: Text(
                                                lan.getTexts(
                                                    'signup_text2'), //'Login',//"signup_text2"
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontFamily: 'Trueno',
                                                    fontSize: 11.0,
                                                    decoration: TextDecoration
                                                        .underline))))),
                              ],
                            ),
                            SizedBox(
                              height: 50,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
        ));
  }
}
