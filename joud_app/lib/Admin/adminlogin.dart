import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:joud_app/Authentication/userauth.dart';
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
              colors: [Colors.teal, Colors.teal],
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

  Widget logo() {
    return Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 110.0,
        child: Image.asset('assets/Joud_Logo.png'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: SingleChildScrollView(
        child: Container(
          decoration: new BoxDecoration(
              gradient: new LinearGradient(
            colors: [Colors.tealAccent, Colors.transparent],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          )),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: 15.0,
              ),
              Container(
                  alignment: Alignment.bottomCenter,
                  height: 125.0,
                  width: 200.0,
                  child: Stack(
                    children: [
                      logo(),
                    ],
                  )),
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
                color: Color.fromRGBO(215, 204, 200, 1.0),
                child: Text(
                  lan.getTexts('Admin_login_Text2'),
                  style: TextStyle(
                    color: Colors.teal,
                  ),
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              Container(
                height: 4.0,
                width: MediaQuery.of(context).size.width * 0.8,
                color: Colors.teal,
              ),
              SizedBox(
                height: 20.0,
              ),
              FlatButton.icon(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UserAuth())),
                icon: Icon(
                  Icons.person_outline,
                  color: Colors.white,
                ),
                label: Text(
                  lan.getTexts('Admin_Flat_button'),
                  style: TextStyle(
                      color: Colors.teal, fontWeight: FontWeight.bold),
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
    FirebaseFirestore.instance.collection("admins").get().then((snapShot) {
      snapShot.docs.forEach((result) {        
        if (result.id!= adminIDtextEditingController.text.trim()) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("your Id is not correct."),
          ));
        } else if (result.data().isEmpty)
           // pass_wordtextEditingController.text.trim())
            {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("your password is not correct."),
          ));
        } else {
          Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(
            "Welcome Dear Admin," + result.data().toString(),
          )));
          setState(() {
            adminIDtextEditingController.text = "";
            pass_wordtextEditingController.text = "";
          });

          //  Route route = MaterialPageRoute(builder: (c) => UploadPage());
          //    Navigator.pushReplacement(context, route);
        }
      });
    });
  }
}
