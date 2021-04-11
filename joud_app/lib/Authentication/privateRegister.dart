import 'dart:developer'; //rama
import 'dart:html';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:joud_app/Authentication/login.dart';
import 'package:joud_app/lang/language_provider.dart';
import 'package:joud_app/screens/joudApp.dart';
import 'package:joud_app/widgets/customTextField.dart';
import 'package:joud_app/widgets/errorAlertDialog.dart';
import 'package:joud_app/widgets/loadAlertDialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: camel_case_types
class Register_P extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register_P> {
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

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width,
        screenHeight = MediaQuery.of(context).size.height;
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: SingleChildScrollView(
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
                child: Column(
                  children: [
                    CustomTextFiled(
                      controllr: nametextEditingController,
                      data: Icons.person,
                      hintText: lan.getTexts('privateRegister_hintText1'),
                      isObsecure: false,
                    ),
                    CustomTextFiled(
                      controllr: emailtextEditingController,
                      data: Icons.email,
                      hintText: lan.getTexts('privateRegister_hintText2'),
                      isObsecure: false,
                    ),
                    CustomTextFiled(
                      controllr: pass_wordtextEditingController,
                      data: Icons.person,
                      hintText: lan.getTexts('privateRegister_hintText3'),
                      isObsecure: true,
                    ),
                    CustomTextFiled(
                      controllr: conform_passwordtextEditingController,
                      data: Icons.person,
                      hintText: lan.getTexts('privateRegister_hintText4'),
                      isObsecure: true,
                    ),
                  ],
                ),
              ),
              RaisedButton(
                onPressed: () {
                  uploadAndSaveImg(lan);
                },
                color: Colors.green,
                child: Text(
                  lan.getTexts('privateRegister_Text1'),
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
              RaisedButton(onPressed: () {
                uploadToStorge(lan);
              }),
            ],
          ),
        ),
      ),
    );
  }

//1
  Future<void> _selectAndPickImg() async {
    imgFile =
        (await ImagePicker.pickImage(source: ImageSource.gallery)) as File;
  }

//2
  Future<void> uploadAndSaveImg(lan) async {
    if (imgFile == null) {
      showDialog(
          context: context,
          builder: (c) {
            return ErrorAlertDialog(
                msg: lan.getTexts('privateRegister_AlertDialog_msg1'));
          });
    } else {
      pass_wordtextEditingController.text ==
              conform_passwordtextEditingController.text
          ? emailtextEditingController.text.isNotEmpty &&
                  pass_wordtextEditingController.text.isNotEmpty &&
                  conform_passwordtextEditingController.text.isNotEmpty &&
                  nametextEditingController.text.isNotEmpty
              ? uploadToStorge(lan)
              : displayDialog(lan.getTexts('privateRegister_AlertDialog_msg2'))
          : displayDialog(lan.getTexts('privateRegister_AlertDialog_msg3'));
    }
  }

  displayDialog(msg1) {
    showDialog(
        context: context,
        builder: (c) {
          return ErrorAlertDialog(
            msg: msg1,
          );
        });
  }

  Future<void> uploadToStorge(lan) async {
    User_obj.counter++;
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: emailtextEditingController.text.trim(),
            password: pass_wordtextEditingController.text.trim())
        .then((signedInUser) {
      storeNewUser(user) {
        FirebaseFirestore.instance.collection('/users').add({
          'email': emailtextEditingController,
          //????? password where ???
          'uid': User_obj.userId,
        }).then((value) {
          // the user cant go back to log in page
          Navigator.of(context).pop();
          Navigator.of(context).pushReplacementNamed('/HomePage');
        }).catchError((e) {
          print(e);
        });
      }
    }).catchError((e) {
      print(e);
    });
    registerUser();
    // we dont need it
    //   showDialog(
    //       context: context,
    //       builder: (c) {
    //         return LoadAlertDialog(
    //           message: lan.getTexts('privateRegister_LoadAlertDialog_msg1'),
    //         );
    //       });
    //   String imageFileName = DateTime.now().microsecondsSinceEpoch.toString();

    //   Reference reference = FirebaseStorage.instance.ref().child(imageFileName);

    //   UploadTask uploadTask = FirebaseStorage.instanceFor()..putFile(imgFile);
    //   TaskSnapshot taskSnapshot; //= await uploadTask.
    //   await taskSnapshot.ref.getDownloadURL().then((userImgUrl) {
    //     //userImageUrl = userImgUrl;
    //
    //   });
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
      //  Navigator.pop(context);
      //   Navigator.of(context).pop();
      //  Navigator.of(context).pushReplacementNamed('/HomePage');
    }
  }

  Future saveUserInfoToFireStore(User fUser) async {
    FirebaseFirestore.instance.collection("users").doc(fUser.uid).set({
      "uid": fUser.uid,
      "email": fUser.email,
      "name": nametextEditingController.text.trim(),
      "photoUrl": userImgUrl,
    });

    // send it to your own class
    await User_obj.sharedPreferences.setString("uid", fUser.uid);
    await User_obj.sharedPreferences.setString(User_obj.userEmail, fUser.email);
    await User_obj.sharedPreferences
        .setString(User_obj.userName, nametextEditingController.text);
    await User_obj.sharedPreferences.setString(User_obj.userPhoto, userImgUrl);
    // await User_obj.sharedPreferences.setString(User_obj.userAvaterUrl, userImgUrl);
  }
}
