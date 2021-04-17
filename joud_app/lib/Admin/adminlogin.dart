import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:joud_app/Authentication/authintication.dart';
import 'package:joud_app/lang/language_provider.dart';
import 'package:joud_app/widgets/customTextField.dart';
import 'package:joud_app/widgets/errorAlertDialog.dart';
import 'package:provider/provider.dart';

class AdminSignInPage extends StatefulWidget {
  @override
  _AdminSignInPageState createState() => _AdminSignInPageState();
}

class _AdminSignInPageState extends State<AdminSignInPage> {
  @override
  void initState() {
    Provider.of<LanguageProvider>(context, listen: false).getLan();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: new BoxDecoration(
                gradient: new LinearGradient(
              colors: [Colors.greenAccent, Colors.green],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            )),
          ),
          title: Text(
            lan.getTexts("Admin_Screen_AppBar_Text"),
            style: TextStyle(
                fontSize: 55.0,
                color: Colors.white,
                fontFamily: "Schyler-Regular"),
          ),
          centerTitle: true,
        ),
        body: AdminSingInScreen(),
      ),
    );
  }
}

class AdminSingInScreen extends StatefulWidget {
  @override
  AdminSingInScreenState createState() => AdminSingInScreenState();
}

class AdminSingInScreenState extends State<AdminSingInScreen> {
  final TextEditingController adminIDtextEditingController =
      TextEditingController();
  final TextEditingController pass_wordtextEditingController =
      TextEditingController();
  final GlobalKey<FormState> from_key = GlobalKey<FormState>();

  @override
  void initState() {
    Provider.of<LanguageProvider>(context, listen: false).getLan();
    super.initState();
  }

  // double _screenWidth = MediaQuery.of(context).size.width;
  //MediaQuery.of(context).size.width;
  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: SingleChildScrollView(
        child: Container(
          decoration: new BoxDecoration(
              gradient: new LinearGradient(
            colors: [Colors.greenAccent, Colors.green],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          )),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  "assets/app_jo.png",
                  height: 240.0,
                  width: 240.0,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  lan.getTexts('Admin_login_Text'),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Form(
                key: from_key,
                child: Column(
                  children: [
                    CustomTextFiled(
                      controllr: adminIDtextEditingController,
                      data: Icons.person,
                      hintText: lan.getTexts('Admin_hint_Text1'),
                      isObsecure: false,
                    ),
                    CustomTextFiled(
                      controllr: pass_wordtextEditingController,
                      data: Icons.person,
                      hintText: lan.getTexts('Admin_hint_Text2'),
                      isObsecure: true,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              RaisedButton(
                onPressed: () {
                  adminIDtextEditingController.text.isNotEmpty &&
                          pass_wordtextEditingController.text.isNotEmpty
                      ? loginAdmin()
                      : showDialog(
                          context: context,
                          builder: (c) {
                            return ErrorAlertDialog(
                              msg: lan.getTexts('Admin_ErrorAlertDialog_msg'),
                            );
                          });
                },
                color: Colors.green,
                child: Text(
                  lan.getTexts('Admin_login_Text2'),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              Container(
                height: 4.0,
                width: MediaQuery.of(context).size.width * 0.8,
                color: Colors.green,
              ),
              SizedBox(
                height: 20.0,
              ),
              FlatButton.icon(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AuthinticationScreen())),
                icon: Icon(
                  Icons.nature_people,
                  color: Colors.lime[400],
                ),
                label: Text(
                  lan.getTexts('Admin_Flat_button'),
                  style: TextStyle(
                      color: Colors.pink[100], fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  loginAdmin() {
    // FirebaseFirestore.instance.collection("admins").get().then((snapShot){
    //   snapShot.docs.forEach((result) {
    //     if(result.data["id"] != adminIDtextEditingController.text.trim()){
    //          Scaffold.of(context).showSnackBar(SnackBar(content: Text("your Id is not correct."),));
    //     }
    //    else if(result.data["password"] != pass_wordtextEditingController.text.trim()){
    //       Scaffold.of(context).showSnackBar(SnackBar(content: Text("your password is not correct."),));
    //     }
    //     else {
    //       Scaffold.of(context).showSnackBar(SnackBar(content: Text("Welcome Dear Admin,"+ result.data("name"),)));
    //       setState(() {
    //         adminIDtextEditingController.text = "";
    //         pass_wordtextEditingController.text="";

    //       });

    // Route route = MaterialPageRoute(builder: (c) => UploadPage());
    //   Navigator.pushReplacement(context, route);
    //}
    // });
    //});
    // }
  }
}
