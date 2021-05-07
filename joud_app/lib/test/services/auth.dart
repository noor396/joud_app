import 'package:firebase_auth/firebase_auth.dart';
import 'package:joud_app/Widgets/loadAlertDialog.dart';
import 'package:joud_app/test/modal/users.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Users _userFromFirebaseUser(User user) {
    return user != null
        ? Users(userId: user.uid)
        : null; //indicates if we are receiving some data from the firebase or not
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    // we use await till we get the data we can move forward with reading the code

    // we use try- catch so google tracks the errors and catches them
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password) ;
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      // final snackBar = SnackBar(content: Text('You are not register yet.'));
      // ScaffoldMessenger.of(context).showSnackBar(snackBar);

      LoadAlertDialog(message: 'You are not register yet.');
      print(e.toString());
      return null;
    }
  }

  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future resetPass(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
