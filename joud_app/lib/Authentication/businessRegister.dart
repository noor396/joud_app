import 'dart:developer';
import 'dart:html';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:joud_app/Widgets/customTextField.dart';
import 'package:joud_app/Widgets/errorAlertDialog.dart';
import 'package:joud_app/Widgets/loadAlertDialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:joud_app/pages/joudApp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: camel_case_types
class Register_B extends StatefulWidget {
  @override
  _RegisterState_B createState() => _RegisterState_B();
}

class _RegisterState_B extends State<Register_B> {
  final TextEditingController nametextEditingController =
      TextEditingController();
  final TextEditingController emailtextEditingController =
      TextEditingController();
  final TextEditingController pass_wordtextEditingController =
      TextEditingController();
  final TextEditingController conform_passwordtextEditingController =
      TextEditingController();
  final GlobalKey<FormState> from_key = GlobalKey<FormState>();
  String userImgUrl = "";
  File imgFile;
  File file1;
  bool uploading = true;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width,
        screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 10.0,
            ),
            InkWell(
              onTap: _selectAndPickImg,
              child: CircleAvatar(
                radius: screenWidth * 0.15,
                backgroundColor: Color.fromRGBO(230, 238, 156, 1.0),
                //  backgroundImage: imgFile == null ? null : FileImage(imgFile),
                child: imgFile == null
                    ? Icon(
                        Icons.add_photo_alternate,
                        size: screenWidth * 0.15,
                        color: Colors.grey,
                      )
                    : null,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Form(
              key: from_key,
              child: Column(children: [
                CustomTextFiled(
                  controllr: nametextEditingController,
                  data: Icons.person,
                  hintText: "Name",
                  isObsecure: false,
                ),
                CustomTextFiled(
                  controllr: emailtextEditingController,
                  data: Icons.email,
                  hintText: "Email",
                  isObsecure: false,
                ),
                CustomTextFiled(
                  controllr: pass_wordtextEditingController,
                  data: Icons.person,
                  hintText: "Password",
                  isObsecure: true,
                ),
                CustomTextFiled(
                  controllr: conform_passwordtextEditingController,
                  data: Icons.person,
                  hintText: "Confirm Password",
                  isObsecure: true,
                ),
                FlatButton(
                    onPressed: uploading ? null : () => UploadandSaveFile(),
                    child: Text("Add", style: TextStyle())),
              ]),
            ),
            RaisedButton(
              onPressed: () {
                uploadAndSaveImg();
              },
              color: Colors.green,
              child: Text(
                "sign up",
                style: TextStyle(
                  color: Color.fromRGBO(215, 204, 200, 1.0),
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              height: 4.0,
              width: screenWidth * 0.8,
              color: Colors.green,
            ),
            SizedBox(
              height: 15.0,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectAndPickImg() async {
    imgFile =
        (await ImagePicker.pickImage(source: ImageSource.gallery)) as File;
  }

  Future<void> uploadAndSaveImg() async {
    if (imgFile == null) {
      showDialog(
          context: context,
          builder: (c) {
            return ErrorAlertDialog(msg: "Please select an image file.");
          });
    } else {
      pass_wordtextEditingController.text ==
              conform_passwordtextEditingController.text
          ? emailtextEditingController.text.isNotEmpty &&
                  pass_wordtextEditingController.text.isNotEmpty &&
                  conform_passwordtextEditingController.text.isNotEmpty &&
                  nametextEditingController.text.isNotEmpty
              ? uploadToStorge()
              : displayDialog(
                  "Please fill up the registration complete form...")
          : displayDialog("Password do not match.");
    }
  }

  displayDialog(String msg1) {
    showDialog(
        context: context,
        builder: (c) {
          return ErrorAlertDialog(
            msg: msg1,
          );
        });
  }

  Future<void> uploadToStorge() async {
    showDialog(
        context: context,
        builder: (c) {
          return LoadAlertDialog(
            message: "Registring, Please wait.....",
          );
        });
    String imageFileName = DateTime.now().microsecondsSinceEpoch.toString();

    Reference reference = FirebaseStorage.instance.ref().child(imageFileName);

    // UploadTask uploadTask = FirebaseStorage.putFile(imgFile);
    TaskSnapshot taskSnapshot; //= await uploadTask.
    await taskSnapshot.ref.getDownloadURL().then((userImgUrl) {
      //userImageUrl = userImgUrl;
      registerUser();
    });
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  void registerUser() async {
    User firebaseUser;
    // counter to compute the number of register people to the app
    User_obj.counter++;
    await _auth
        .createUserWithEmailAndPassword(
      email: emailtextEditingController.text.trim(),
      password: pass_wordtextEditingController.text.trim(),
    )
        .then((auth) {
      firebaseUser = auth.user;
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c) {
            return ErrorAlertDialog(
              msg: error.message.toString(),
            );
          });
    });
    if (firebaseUser != null) {
      saveUserInfoToFireStore(firebaseUser);
      Navigator.pop(context);
      // to move to home page
      // Navigator.pop(context);
      // Route route = MaterialPageRoute(builder: (c) => homePage());
      //  Navigator.pushReplacement(context, route);
    }
  }

  Future saveUserInfoToFireStore(User fUser) async {
    FirebaseFirestore.instance.collection("users").doc(fUser.uid).set({
      "uid": fUser.uid,
      "email": fUser.email,
      "name": nametextEditingController.text.trim(),
      "photoUrl": userImgUrl,
      "userfile": file1
    });

    // send it to your own class
    await User_obj.sharedPreferences.setString("uid", fUser.uid);
    await User_obj.sharedPreferences.setString(User_obj.userEmail, fUser.email);
    await User_obj.sharedPreferences
        .setString(User_obj.userName, nametextEditingController.text);
    await User_obj.sharedPreferences.setString(User_obj.userPhoto, userImgUrl);
    // await User_obj.sharedPreferences.setString(User_obj.userFile, file1);
  }

  Future UploadandSaveFile() async {
    setState(() {
      uploading = true;
    });
    String filedownloadurl = await uploasItem(file1);
  }

  Future<String> uploasItem(File f) async {
    final Reference reference = FirebaseStorage.instance.ref().child("files");
    //UploadTask uploadTask = reference.child("File_$file1.jpg").putFile(f); thats true but because the error i comment it to solve the problem and again solve it
    UploadTask uploadTask = reference.child("File_$file1.jpg") as UploadTask;
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => "complete");
    String download = await taskSnapshot.ref.getDownloadURL();
    return download;
  }
}
