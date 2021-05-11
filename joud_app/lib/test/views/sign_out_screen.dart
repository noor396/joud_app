import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:joud_app/test/helper/authenticate.dart';
import 'package:joud_app/test/services/auth.dart';

class SignOutScreen extends StatelessWidget {
  static const routeName = '/sign_out';
  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sign Out", //
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color.fromRGBO(230, 238, 156, 1.0),
      ),
      body:
          Column(
        children: [
          SizedBox(
            height: 200,
          ),
         
                     GestureDetector(
                          onTap: () {
                            FirebaseAuth.instance.signOut();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Authenticate()));
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 45,
                            width: MediaQuery.of(context)
                                .size
                                .width/1.2, 
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                              //  const Color.fromRGBO(215, 204, 200, 1),
                                const Color.fromRGBO(166, 155, 151, 0.7),
                              const Color.fromRGBO(230, 238, 156, 1.0),
                              ]),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              'Sign Out', //"signup_up"
                              style: TextStyle(fontSize: 19,
                              fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
          Container(
               
              ),
        ],
      ),
      //)
    );
  }
}
