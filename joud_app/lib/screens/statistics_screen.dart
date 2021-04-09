import 'package:flutter/material.dart';
class StatisticsScreen extends StatelessWidget {
  static const routeName ='/statistics';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("Statistics",style: TextStyle(color: Colors.black),),
          backgroundColor: Color.fromRGBO(230, 238, 156, 1.0),
    ),
    body: Center(
      child: Text("Statistics"),
    ),);
  }
}