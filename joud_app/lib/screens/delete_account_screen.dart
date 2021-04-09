import 'package:flutter/material.dart';

class DeleteAccountScreen extends StatelessWidget {
  static const routeName = '/delete_account';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Delete Account",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color.fromRGBO(230, 238, 156, 1.0),
      ),
      body: Center(
        child: Text("Delete Account"),
      ),
    );
  }
}
