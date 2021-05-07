import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {

  getUserByUsername(String username) async {
   return await FirebaseFirestore.instance.collection("users")
        .where("username", isEqualTo: username).get()
        .catchError((e) {
      print(e.toString());
    });
  }

  getUserByEmail(String email) async {
    return await FirebaseFirestore.instance.collection("users")
        .where("email", isEqualTo: email).get()
        .catchError((e) {
      print(e.toString());
    });
  }

  uploadUserInfo(userMap)  {
    FirebaseFirestore.instance.collection("users")
        .add(userMap).catchError((e) {
      print(e.toString());
    });
  }

  createChatRoom(String chatRoomId, chatRoomMap) {
  FirebaseFirestore.instance.collection("chatRoom")
      .doc(chatRoomId)
      .set(chatRoomMap)
      .catchError((e) {
    print(e);
  });
}

  addConversationMessages (String chatRoomId, messageMap, receiver) {
    FirebaseFirestore.instance.collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .add(messageMap)
        .catchError((e){print(e.toString());});

  }

  getConversationMessages (String chatRoomId) async {
    return await FirebaseFirestore.instance.collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("time", descending: false)
        .snapshots(); // provides stream of queries snapshot
  }

  getAllChatRooms(String userName) async {
    return await FirebaseFirestore.instance
        .collection("chatRoom")
        .where('users', arrayContains: userName)
        .snapshots();
  }

}
