import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:joud_app/lang/language_provider.dart';
import 'package:joud_app/screens/postform.dart';
import 'package:provider/provider.dart';

class PostStream extends StatefulWidget {
  @override
  _PostStreamState createState() => _PostStreamState();
  static const routeName = '/poststream';
}

class _PostStreamState extends State<PostStream> {
/*  @override
  void initState() {
    Provider.of<LanguageProvider>(context, listen: true).getLan();
    super.initState();
  }*/

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .orderBy('timestamp', descending: true)
          .snapshots(), // after executing stream the below snapShot fetches the data
      builder: (ctx, snapShot) {
        if (/*snapShot.data == null*/ snapShot.connectionState ==
            ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        final docs = snapShot.data.docs;
        return PageView.builder(
          // reverse: true,
          itemCount: 1,
          itemBuilder: (ctx, index) => PostForm(
            docs[index]['id'],
            docs[index]['imageUrl'],
            docs[index]['password'],
            docs[index]['timestamp'].toDate(),
            docs[index]['userName'],
            key: ValueKey(snapShot.data.docs[index]),
          ),
        );
      },
    );
  }
}
