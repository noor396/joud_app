import 'package:flutter/material.dart';
import 'package:joud_app/test/helper/authenticate.dart';
import 'package:joud_app/test/services/auth.dart';

Widget appBarCustom(BuildContext context) {
  return AppBar(
    title: Text(
      'JOUD',
      style: TextStyle(color: Colors.black),
    ),
    backgroundColor: Color.fromRGBO(230, 238, 156, 1.0),
  );
}

Widget appBarCustomBackBtn(BuildContext context, String text) {
  return AppBar(
    leading: IconButton(
      icon: Icon(Icons.arrow_back_ios_rounded),
      iconSize: 25.0,
      color: Colors.black54,
      onPressed: () => Navigator.pop(context, false),
    ),
    backgroundColor: Color.fromRGBO(240, 244, 195, 1.0),
    title: Text(
      '$text',
      style: TextStyle(
        fontSize: 20.0,
        color: Colors.black54,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget appBarCustomBackBtnReceiverImage(
    BuildContext context, String text, String image) {
  return AppBar(
    leading: IconButton(
      icon: Icon(Icons.arrow_back_ios_rounded),
      iconSize: 25.0,
      color: Colors.black54,
      onPressed: () => Navigator.pop(context, false),
    ),
    backgroundColor: Color.fromRGBO(230, 238, 156, 1.0),
    titleSpacing: 0,
    title: Row(
      children: [
        Container(
          //height: 35,
          // width: 35,
          padding: EdgeInsets.only(right: 8),
          margin: EdgeInsets.only(right: 8),
          child: CircleAvatar(
            radius: 22.0,
            backgroundColor: Colors.grey,
            backgroundImage: NetworkImage(image),
          ),
          /*decoration: BoxDecoration(
              color: Colors.lightGreen,
              borderRadius: BorderRadius.circular(35)),*/
        ),
        Text(
          '$text',
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.black54,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

Widget appBarCustomBackLogoutBtn(BuildContext context) {
  AuthMethods authMethods = new AuthMethods();
  return AppBar(
    leading: IconButton(
      icon: Icon(Icons.arrow_back_ios_rounded),
      iconSize: 25.0,
      color: Colors.black54,
      onPressed: () => Navigator.pop(context, false),
    ),
    backgroundColor: Color.fromRGBO(230, 238, 156, 1.0),
    title: Text(
      'Chat',
      style: TextStyle(
        fontSize: 20.0,
        color: Colors.black54,
        fontWeight: FontWeight.bold,
      ),
    ),
    actions: [
      GestureDetector(
        onTap: () {
          authMethods.signOut();
          // when we sign out we don't want the user to be able to go back to the chat screen so we used pushReplacement
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Authenticate()));
        },
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(
              Icons.exit_to_app,
              color: Colors.black54,
            )),
      ),
    ],
  );
}

InputDecoration textFieldInputDecoration(String hintText) {
  return InputDecoration(
    labelText: hintText,
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black54),
    ),
  );
}
