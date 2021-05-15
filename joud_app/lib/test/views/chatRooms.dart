import 'package:chat_search/helper/constants.dart';
import 'package:chat_search/helper/sharedPreferences.dart';
import 'package:chat_search/services/database.dart';
import 'package:chat_search/views/conversation.dart';
import 'package:chat_search/views/search.dart';
import 'package:chat_search/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();


  // ChatRoom(this.message, this.sender, this.receiver, this.time,
  //     {this.key});
  // final String message;
  // final String sender;
  // final String receiver;
  // final DateTime time;
  // final Key key;
    }

class _ChatRoomState extends State<ChatRoom> {

  DatabaseMethods databaseMethods = new DatabaseMethods();
 Stream chatRoomsStream;

 Widget chatRoomList (){
   return StreamBuilder(
     stream: chatRoomsStream,
     builder: (context, snapshot) {
       return snapshot.hasData
           ? ListView.builder(
          reverse: true, // reverses the  list of chats with contacts (last chat first)
           itemCount: snapshot.data.docs.length,
           shrinkWrap: true,
           itemBuilder: (context, index) {
             return chatRoomTile(
               userName: snapshot.data.docs[index].data()['chatRoomId']
                   .toString()
                   .replaceAll("_", "")
                   .replaceAll(Constants.myName, ""),
               chatRoomId: snapshot.data.docs[index].data()["chatRoomId"],
             //  message: snapshot.data.docs[index].data()["chats"[0]],
             );
           })
           : Container();
     },
   );
 }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo()async{
    Constants.myName = await SharedPreferencesFunctions.getUserNameSharedPreference() ;
    databaseMethods.getAllChatRooms(Constants.myName).then((val){
      setState(() {
        chatRoomsStream = val;
      });
    });
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarCustomBackLogoutBtn(context),
      body: Column(children: [
        Container(
            padding: EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Center(
                  child: GestureDetector(
                    onTap:(){ Navigator.push(context, MaterialPageRoute(builder: (context) => Search())); } ,
                    child: Container(
                      width: 340,
                      height: 50,
                      decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.circular(30.0),
                        gradient: LinearGradient(
                            colors: [
                              //Brownish Fading
                              const Color.fromRGBO( 215,204,200,1.5),
                              const Color.fromRGBO( 215,204,200,1.5),
                            ]
                        ),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child:
                            Text(
                              'Search...',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                             // initiateSearch();
                            },
                            child: IconButton(
                              icon: Icon(Icons.search),
                              iconSize: 28.0,
                              color: Colors.black54,
                              onPressed: null ,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              //  searchList(),
              ],
            ),
          ),

        Container(color: Colors.blue,child: chatRoomList()),
      ],
      ),




      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.search),
      //   onPressed:(){
      //     Navigator.push(context, MaterialPageRoute(
      //         builder: (context) => Search()
      //     ));
      //   } ,
      // ),

    );
  }
}



class chatRoomTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;
  final String message; // not final



  chatRoomTile({this.userName, this.chatRoomId, this.message});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => ConversationScreen(chatRoomId, userName)
          ));
      },
      child: SingleChildScrollView(
        child: Container(
          color: Color.fromRGBO(255,255,246,1),
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 15),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 35,
                    width: 35,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.lightGreen,
                        borderRadius: BorderRadius.circular(35)),
                    child: Text(userName.substring(0, 1),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'OverpassRegular',
                            fontWeight: FontWeight.w300)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(userName,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                              fontWeight: FontWeight.w600)
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Row(
                        children: [
                          Text("hello",
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(
                            width: 190,
                          ),
                          Text('15:30',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}





