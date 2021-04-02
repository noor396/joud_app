import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:joud_app/Authentication/businessRegister.dart';
import 'package:joud_app/Authentication/privateRegister.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //double screenWidth = MediaQuery.of(context).size.width;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Registration Type'),
          //shadowColor: Colors.green,
          backgroundColor: Color.fromRGBO(230, 238, 156, 1.0),
        ),
        body: Stack(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              height: 50.0,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
                onPressed: () {
                  Register_B();
                },
                padding: EdgeInsets.all(10.0),
                color: Color.fromRGBO(0, 160, 227, 1),
                textColor: Colors.white,
                child: Text("Business Account", style: TextStyle(fontSize: 15)),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              height: 50.0,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
                onPressed: () {
                  Register_P();
                },
                padding: EdgeInsets.all(10.0),
                color: Colors.white,
                textColor: Color.fromRGBO(0, 160, 227, 1),
                child: Text("Private Account", style: TextStyle(fontSize: 15)),
              ),
            ),
          ],
        ));
  }

  // Future<void> _selectAndPickImg() async {
  //   imgFile =
  //       (await ImagePicker.pickImage(source: ImageSource.gallery)) as File;
  // }

  // Future<void> uploadAndSaveImg() async {
  //   if (imgFile == null) {
  //     showDialog(
  //         context: context,
  //         builder: (c) {
  //           return ErrorAlertDialog(msg: "Please select an image file.");
  //         });
  //   } else {
  //     pass_wordtextEditingController.text ==
  //             conform_passwordtextEditingController.text
  //         ? emailtextEditingController.text.isNotEmpty &&
  //                 pass_wordtextEditingController.text.isNotEmpty &&
  //                 conform_passwordtextEditingController.text.isNotEmpty &&
  //                 nametextEditingController.text.isNotEmpty
  //             ? uploadToStorge()
  //             : displayDialog(
  //                 "Please fill up the registration complete form...")
  //         : displayDialog("Password do not match.");
  //   }
  // }

  // displayDialog(String msg1) {
  //   showDialog(
  //       context: context,
  //       builder: (c) {
  //         return ErrorAlertDialog(
  //           msg: msg1,
  //         );
  //       });
  // }

  // Future<void> uploadToStorge() async {
  //   showDialog(
  //       context: context,
  //       builder: (c) {
  //         return LoadAlertDialog(
  //           message: "Registring, Please wait.....",
  //         );
  //       });
  //   String imageFileName = DateTime.now().microsecondsSinceEpoch.toString();

  //   Reference reference = FirebaseStorage.instance.ref().child(imageFileName);

  //   // UploadTask uploadTask = FirebaseStorage.putFile(imgFile);
  //   TaskSnapshot taskSnapshot; //= await uploadTask.
  //   await taskSnapshot.ref.getDownloadURL().then((userImgUrl) {
  //     //userImageUrl = userImgUrl;
  //     registerUser();
  //   });
  // }

  // FirebaseAuth _auth = FirebaseAuth.instance;
  // void registerUser() async {
  //   User firebaseUser;
  //   // counter to compute the number of register people to the app
  //   User_obj.counter++;
  //   await _auth
  //       .createUserWithEmailAndPassword(
  //     email: emailtextEditingController.text.trim(),
  //     password: pass_wordtextEditingController.text.trim(),
  //   )
  //       .then((auth) {
  //     firebaseUser = auth.user;
  //   }).catchError((error) {
  //     Navigator.pop(context);
  //     showDialog(
  //         context: context,
  //         builder: (c) {
  //           return ErrorAlertDialog(
  //             msg: error.message.toString(),
  //           );
  //         });
  //   });
  //   if (firebaseUser != null) {
  //     saveUserInfoToFireStore(firebaseUser);
  //     Navigator.pop(context);
  //     // to move to home page
  //     // Navigator.pop(context);
  //     // Route route = MaterialPageRoute(builder: (c) => homePage());
  //     //  Navigator.pushReplacement(context, route);
  //   }
  // }

  // Future saveUserInfoToFireStore(User fUser) async {
  //   FirebaseFirestore.instance.collection("users").doc(fUser.uid).set({
  //     "uid": fUser.uid,
  //     "email": fUser.email,
  //     "name": nametextEditingController.text.trim(),
  //     "ulr": userImgUrl,
  //   });

  //   // send it to your own class
  //   await User_obj.sharedPreferences.setString("uid", fUser.uid);
  //   await User_obj.sharedPreferences.setString(User_obj.userEmail, fUser.email);
  //   await User_obj.sharedPreferences
  //       .setString(User_obj.userName, nametextEditingController.text);
  //   await User_obj.sharedPreferences
  //       .setString(User_obj.userAvaterUrl, userImgUrl);
  //   // await User_obj.sharedPreferences.setString(User_obj.userAvaterUrl, userImgUrl);
  // }
}
