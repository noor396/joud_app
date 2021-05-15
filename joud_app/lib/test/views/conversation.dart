import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:joud_app/test/helper/constants.dart';
import 'package:joud_app/test/services/database.dart';
import 'package:joud_app/widgets/widget.dart';

class ConversationScreen extends StatefulWidget {
  final String chatRoomId;
  final String msgReceiver;

  ConversationScreen(this.chatRoomId, this.msgReceiver);

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  //We will use stream for real-time chat
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController messageController = new TextEditingController();
  Stream messageStream;

  Widget chatMessageList() {
    return Container(
      //color: Colors.amberAccent,
      height: 460,
      child: StreamBuilder(
        stream: messageStream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  // to avoid returning null
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    return MessageTile(
                      message: snapshot.data.docs[index].data()["message"],
                      isSenderMe: Constants.myName ==
                          snapshot.data.docs[index].data()["sender"],
                    );
                  })
              : Container();
        },
      ),
    );
  }

  sendMessage() {
    FocusScope.of(context).unfocus();
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        'message': messageController.text,
        'sender': Constants.myName,
        'time': DateTime.now(),
        'receiver': widget.msgReceiver,
        //here add picture
      };
      databaseMethods.addConversationMessages(
          widget.chatRoomId, messageMap, widget.msgReceiver);
      messageController.text = "";
    }
    messageController.clear();
  }

  @override
  void initState() {
    databaseMethods.getConversationMessages(widget.chatRoomId).then((val) {
      setState(() {
        messageStream = val;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarCustomBackBtnReceiverImage(context, widget.msgReceiver),
      body: Container(
        child: Stack(
          children: [
            chatMessageList(),
            Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.photo),
                    iconSize: 25.0,
                    color: Color.fromRGBO(166, 155, 151, 1),
                    onPressed: () {},
                  ),
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(166, 155, 151, 1)),
                        ),
                        hintText: 'Send a message...',
                        hintStyle:
                            TextStyle(color: Color.fromRGBO(166, 155, 151, 1)),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      sendMessage();
                    },
                    child: IconButton(
                      color: Color.fromRGBO(189, 193, 146, 1),
                      disabledColor: Color.fromRGBO(166, 155, 151, 1),
                      iconSize: 25.0,
                      icon: Icon(Icons.send_rounded),
                      onPressed: null,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool isSenderMe;
  final String msgReceiver;

  MessageTile({this.message, this.isSenderMe, this.msgReceiver});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 10,
          bottom: 10,
          left: isSenderMe ? 0 : 15,
          right: isSenderMe ? 15 : 0),
      alignment: isSenderMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin:
            isSenderMe ? EdgeInsets.only(left: 30) : EdgeInsets.only(right: 30),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        decoration: BoxDecoration(
            borderRadius: isSenderMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(14),
                    topRight: Radius.circular(14),
                    bottomLeft: Radius.circular(23))
                : BorderRadius.only(
                    topLeft: Radius.circular(14),
                    topRight: Radius.circular(14),
                    bottomRight: Radius.circular(23)),
            gradient: LinearGradient(
              colors: isSenderMe
                  ? [
                      const Color.fromRGBO(240, 244, 195, 1),
                      const Color.fromRGBO(189, 193, 146, 0.8),
                    ]
                  : [
                      const Color.fromRGBO(215, 204, 200, 1),
                      const Color.fromRGBO(166, 155, 151, 0.7),
                    ],
            )),
        child: Column(
          children: [
            // Text(isSenderMe ? Constants.myName :''),
            Text(message,
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'OverpassRegular',
                    fontWeight: FontWeight.w400)),
          ],
        ),
      ),
    );
  }
}
