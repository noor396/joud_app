import 'package:flutter/material.dart';
import 'dart:io';

import 'package:joud_app/Authentication/userImg.dart';
class AuthForm extends StatefulWidget {

  final void Function (String email, String password, String userName,File image, bool loggedIn, BuildContext ctx) userAuth;

  AuthForm(this.userAuth);

  @override
  State<StatefulWidget> createState() {
    return AuthFormState();
  }

}

class AuthFormState extends State <AuthForm> {
  final formKey = GlobalKey <FormState>();
  bool loggedIn= true;
  String email = "" ;
  String userName = "" ;
  String password = "" ;

  File userImageFile;

  void pickedImageFun(File pickedImage){
    userImageFile = pickedImage;
  }


  void submit() {
    final isValid= formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    

    if (!loggedIn && userImageFile == null){
      // ignore: deprecated_member_use
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Please pick an image'),
        backgroundColor: Theme.of(context).errorColor,
      ));
      return;
    }

    if (isValid) {
      formKey.currentState.save();
      widget.userAuth(email.trim(), password.trim(),userName.trim(),userImageFile, loggedIn, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!loggedIn) UserImagePicker(pickedImageFun),
                TextFormField(
                  key: ValueKey('email'),
                  validator: (val) {
                    if (val.isEmpty || !val.contains('@')){
                      return 'Please enter a correct email address';
                    }
                    return null;
                  },
                  onSaved: (val) => email= val,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration (labelText: 'Email Address'),
                ),

                if (!loggedIn)
                  TextFormField(
                    key: ValueKey('userName'),
                    validator: (val) {
                      if (val.isEmpty || val.length < 5){
                        return 'Please enter a username with at least 5 characters';
                      }
                      return null;
                    },
                    onSaved: (val) => userName= val,
                    decoration: InputDecoration (labelText: 'Username'),
                  ),

                TextFormField(
                  key: ValueKey('password'),
                  validator: (val) {
                    if (val.isEmpty || val.length < 6){
                      return 'Please enter a correct password';
                    }
                    return null;
                  },
                  onSaved: (val) => password = val,
                  decoration: InputDecoration (labelText: 'Password'),
                  obscureText: true,
                ),
                
                SizedBox(height: 12),
                // ignore: deprecated_member_use
                RaisedButton(
                    child: Text(loggedIn ? 'Login' : 'Sign up'),
                    onPressed: submit
                ),
                // ignore: deprecated_member_use
                FlatButton(
                  textColor: Theme.of(context).primaryColor,
                  child: Text(loggedIn ? 'Create a new account' : 'Already have an account'),
                  onPressed: () {
                    setState(() {
                      loggedIn = !loggedIn;
                    });
                  },
                )

              ],
            ),
          ),
        ),
      ),
    );

  }
}