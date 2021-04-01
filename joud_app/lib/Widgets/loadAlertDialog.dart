import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class LoadAlertDialog extends StatelessWidget {
  final String message;
  const LoadAlertDialog({Key key, this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CircularProgressIndicator(),
          // circularProgress(),
          SizedBox(
            height: 10,
          ),
          Text(message), //("Authenticating, Please wait....."),
        ],
      ),
    );
  }

  //buildCircularProgress() => circularProgress();
}
