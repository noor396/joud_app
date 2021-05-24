import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class Users {
  String userId;
  final String profileName;
  final String username;
  final String url;
  final String email;
  final String bio;
  static String userUId = Uuid().v4();
  Users(
      {this.userId,
      this.profileName,
      this.username,
      this.url,
      this.email,
      this.bio});

  Stream<DocumentSnapshot> provideDocumentFieldStream() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc('document')
        .snapshots();
  }

// StreamBuilder (
//   stream : 
// )
  // factory Users.fromDocument(DocumentSnapshot doc) {
  //   return Users(
  //     userId: doc.id,
  //     email: doc["email"],
  //     username: doc["username"],
  //     //url: doc["url"],
  //     profileName: doc["profileName"],
  //     bio: doc["bio"],
  //   );
  // }
}
