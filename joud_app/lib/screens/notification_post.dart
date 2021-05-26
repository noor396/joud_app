import 'package:flutter/material.dart';
import 'package:joud_app/Widgets/tabs_screen.dart';
import 'package:joud_app/lang/language_provider.dart';
import 'package:joud_app/screens/Profile_post_stream.dart';
import 'package:joud_app/screens/notification_post_stream.dart';
import 'package:provider/provider.dart';

class NotificationPost extends StatefulWidget {
  @override
  _NotificationPostState createState() => _NotificationPostState();
  NotificationPost(this.userId, this.postId);
  final String userId;
  final String postId;
}

class _NotificationPostState extends State<NotificationPost> {
  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            leading: Padding(
                padding: EdgeInsets.only(left: 1),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TabsScreen()));
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                      ),
                    ),
                  ],
                )),
            title: Text(
              lan.getTexts('Notification'),
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Color.fromRGBO(230, 238, 156, 1.0),
            centerTitle: true,
          ),
          body: NotificationPostStream(widget.userId, widget.postId)),
    );
  }
}
