import 'dart:io';
import 'package:flutter/material.dart';
import 'package:joud_app/screens/home_screen.dart';
import 'package:joud_app/test/helper/sharedPreferences.dart';
import 'package:joud_app/test/services/auth.dart';
import 'package:joud_app/test/services/database.dart';
import 'package:joud_app/test/widgets/userImagePicker.dart';
import 'package:joud_app/test/widgets/widget.dart';


class Signup extends StatefulWidget {

  final Function toggle;
  Signup(this.toggle);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  bool isLoading= false;
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  File userImageFile;

  void addedImage(File pickedImage ) {
    userImageFile = pickedImage;
  }


  final formKey = GlobalKey<FormState>();
  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController userNameTextEditingController = new TextEditingController();
  TextEditingController passwordTextEditingController = new TextEditingController();

  signUpBtn(){

    if(userImageFile == null){
      final snackBar = SnackBar(content: Text("Please upload an image ! "), backgroundColor: Color.fromRGBO(127,0,0,1));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    if (formKey.currentState.validate()){

      Map<String, String> userInfoMap = {
        'username' : userNameTextEditingController.text,
        'email' : emailTextEditingController.text
      };

      SharedPreferencesFunctions.saveUserEmailSharedPreference(emailTextEditingController.text);   // we save email locally
      SharedPreferencesFunctions.saveUserNameSharedPreference(userNameTextEditingController.text); // we save username locally

      setState(() {
        isLoading = true ;
      });

      authMethods.signUpWithEmailAndPassword(emailTextEditingController.text,passwordTextEditingController.text ).then((val){
        //print("${val.uid}");

        databaseMethods.uploadUserInfo(userInfoMap);
        SharedPreferencesFunctions.saveUserLoggedInSharedPreference(true);// the user will be loggen in here so we have to save his state
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => HomeScreen()

        )); // we used pushReplacement to avoid going back to the sign in or signup screen
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarCustom(context),
      body: isLoading
          ? Center(child: Container(child: CircularProgressIndicator()))
          :Center(
        child: Card(
          margin: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  UserImagePicker(addedImage),
                  SizedBox(height: 20,),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (val) {return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ? null : "Please enter a correct email address";},
                          controller: emailTextEditingController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: textFieldInputDecoration('email'),
                        ),
                        TextFormField(
                          validator: (val){
                              // this validator validates the entered text in the field according to the condition we have set
                              return val.isEmpty || val.length < 5 ? 'Username is too short' : null;
                              },
                          controller: userNameTextEditingController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: textFieldInputDecoration('username'),
                        ),
                        TextFormField(
                          validator: (val){return val.length > 6 ? null : 'Please enter a password with at least 6 characters';},
                          controller: passwordTextEditingController,
                          decoration: textFieldInputDecoration('password'),
                          obscureText: true,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12,),
                  Container(
                    alignment: Alignment.centerRight ,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text('Forgot password?'),
                    ),
                  ),
                  SizedBox(height: 12,),
                  GestureDetector(
                    onTap: () {
                      signUpBtn();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 45,
                      width:MediaQuery.of(context).size.width , //makes container expand vertically
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              const Color.fromRGBO(215,204,200,1),
                              const Color.fromRGBO(166,155,151,0.7),
                              // const Color.fromRGBO(255,255,251,1),
                            ]
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text('Sign Up', style: TextStyle(fontSize: 17),
                      ),
                    ),
                  ),
                  SizedBox(height: 12,),
                  Container(
                    alignment: Alignment.center,
                    height: 45,
                    width:MediaQuery.of(context).size.width , //makes container expand vertically
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            const Color.fromRGBO(240,244,195,1),
                            const Color.fromRGBO(189,193,146,0.8),
                          ]
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text('Sign Up with Google', style: TextStyle(fontSize: 17),
                    ),
                  ),
                  SizedBox(height: 12,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?  ",),
                      GestureDetector(
                        onTap: (){
                          widget.toggle();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text("Login",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

