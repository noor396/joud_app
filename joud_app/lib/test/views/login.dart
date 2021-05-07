import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:joud_app/screens/home_screen.dart';
import 'package:joud_app/test/helper/sharedPreferences.dart';
import 'package:joud_app/test/services/auth.dart';
import 'package:joud_app/test/services/database.dart';
import 'package:joud_app/test/widgets/widget.dart';


class Login extends StatefulWidget {

  final Function toggle;
  Login(this.toggle);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final formKey = GlobalKey<FormState>();
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController passwordTextEditingController = new TextEditingController();
  bool isLoading = false;
  QuerySnapshot snapshotUserInfo;
  Login(){
    if(formKey.currentState.validate()){

      SharedPreferencesFunctions.saveUserEmailSharedPreference(emailTextEditingController.text);   // we save email locally
      databaseMethods.getUserByEmail(emailTextEditingController.text).then((val){
        snapshotUserInfo = val;
        SharedPreferencesFunctions.saveUserNameSharedPreference(snapshotUserInfo.docs[0].data()['username']);
      });

      setState(() {
        isLoading = true;
      });


      authMethods.signInWithEmailAndPassword(emailTextEditingController.text.trim(), passwordTextEditingController.text.trim()).then((val) {

        if(val!= null){
          SharedPreferencesFunctions.saveUserLoggedInSharedPreference(true);// the user will be loggen in here so we have to save his state
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => HomeScreen()
          )); // we used pushReplacement to avoid going back to the sign in or signup screen
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarCustom(context),
      body: Center(
        child: Card(
          margin: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
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
                          validator: (val){return val.length > 5 ? null : 'Please enter a password with at least 6 characters';},
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
                    onTap: (){
                      Login();
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
                          ]
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text('Login', style: TextStyle(fontSize: 17),
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
                    child: Text('Sign In with Google', style: TextStyle(fontSize: 17),
                    ),
                  ),
                  SizedBox(height: 12,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have account?  ",),
                      GestureDetector(
                        onTap: (){
                          widget.toggle();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text("Register now",
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