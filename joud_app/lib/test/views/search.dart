import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:joud_app/screens/home_screen.dart';
import 'package:joud_app/test/helper/constants.dart';
import 'package:joud_app/test/services/database.dart';
import 'package:joud_app/test/widgets/widget.dart';


class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  TextEditingController searchTextEditingController = new TextEditingController();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  QuerySnapshot searchSnapshot;

  Widget searchList() {
    return searchSnapshot != null ?  ListView.builder(
      itemCount: searchSnapshot.docs.length ,
      shrinkWrap: true,
      itemBuilder: (context, index){
        return SearchTile(
          username: searchSnapshot.docs[index].data()["username"],
          email: searchSnapshot.docs[index].data()["email"],
        );
      }) :   Container();
  }


  initiateSearch() {
    databaseMethods.getUserByUsername(searchTextEditingController.text.trim()).then((snapshot){
      setState(() {
        searchSnapshot = snapshot;   //update the value, avoids showing the same content again
        print("$searchSnapshot");
      });
    });
  }

  createChatRoomStartConversation({String userName }){

    if (userName != Constants.myName)
      {
        String chatRoomId = getChatRoomId(userName, Constants.myName);
        List <String> users = [userName, Constants.myName]; // to store the data locally we used the share preference method
        Map<String, dynamic>chatRoomMap = {"users": users, "chatRoomId":chatRoomId };

        DatabaseMethods().createChatRoom(chatRoomId, chatRoomMap);
        Navigator.push(context, MaterialPageRoute(
            builder: (context)=> HomeScreen()
        ));
      }
    else{
      final snackBar = SnackBar(content: Text("you can't send a messages to yourself ! "), backgroundColor: Color.fromRGBO(127,0,0,1));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print ('you cannot send messages to yourself');
    }

  }

  Widget SearchTile({String username, String email} ){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(username, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),),
              Text(email, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: (){
              createChatRoomStartConversation(userName: username);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Color.fromRGBO(215,204,200,1 ),
                  borderRadius: BorderRadius.circular(30)
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text('Send Message'),
            ),
          ),
        ],
      ),
    );
  }

  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarCustomBackBtn(context, 'Search'),
      body: Container(
        padding: EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Center(
              child: Container(
                width: 340,
                height: 50,
                decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.circular(30.0),
                  gradient: LinearGradient(
                      colors: [
                        //Green Fading
                        //const Color.fromRGBO( 240,244,195,0.4),
                        //const Color.fromRGBO( 255,255,246,1),
                        // const Color.fromRGBO( 189,193,146,1),

                        //Brownish Fading
                        const Color.fromRGBO( 215,204,200,1.5),
                        const Color.fromRGBO( 255,255,251,1),
                      ]
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchTextEditingController, // gets the text written in the search bar
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        initiateSearch();
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
            searchList(),
          ],
        ),
      ),
    );
  }
}


getChatRoomId(String a, String b) { // helps us generate a unique chatRoomId
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}