import 'package:cotter/cotter.dart';
import 'package:flutter/material.dart';

// void main() {
//   runApp(PhoneSignInPage());
// }

class PhoneSignInPage extends StatefulWidget {
  @override
  PhoneSignInPageState createState() => PhoneSignInPageState();
}

// Our Home Page
class PhoneSignInPageState extends State<PhoneSignInPage> {
  final inputController = TextEditingController();

  // 1️⃣ TODO: Initialize Cotter
  Cotter cotter =
      new Cotter(apiKeyID: '1:99724757209:android:07444ba1a3b53d2ffad6c8');
  // 2️⃣ TODO: Make Sign Up & Login Function

  void signUpOrLogin(BuildContext context) async {
    try {
      // 🚀 Verify phone number, then create new user or login
      var user = await cotter.signInWithPhoneOTP(
        redirectURL: "myexample://auth_callback",
        channels: [
          PhoneChannel.SMS,
          PhoneChannel.WHATSAPP
        ], // show SMS and WhatsApp options
      );

      // Show the response
      _showResponse(context, "Sign In Success",
          "User id: ${user.id}\nidentifier: ${user.identifier}");
      print(user);
    } catch (e) {
      _showResponse(context, "Error", e.toString());
    }
  }

  // This is a helper function that shows the response
  // from our Sign Up and Login functions.
  _showResponse(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Sign in with Phone Number.",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            Text("Open pre-built phone input form.",
                style: TextStyle(color: Colors.grey)),

            // Button to open a pre-built phone input form
            Container(
              margin: EdgeInsets.symmetric(vertical: 30),
              child: MaterialButton(
                onPressed: () {
                  signUpOrLogin(context);
                },
                color: Colors.deepPurpleAccent,
                textColor: Colors.white,
                child: Text("Sign In with Phone"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
