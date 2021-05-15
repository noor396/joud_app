import 'package:flutter/material.dart';
import 'package:joud_app/Authentication/_auth_serv.dart';
import 'package:joud_app/Widgets/tabs_screen.dart';
import 'package:joud_app/lang/language_provider.dart';
import 'package:provider/provider.dart';


class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final formKey = new GlobalKey<FormState>();

  String email;

  Color greenColor = Color(0xFF00AF19);

  //To check fields during submit
  checkFields() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  //To Validate email
  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: EdgeInsets.only(left: 1),
            child:Row(
              children: [
                IconButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => TabsScreen()));
                  },
                  icon:Icon(Icons.arrow_back_ios,color: Colors.black,),
          ),

              ],
            )
          ),
          title: Text(
            lan.getTexts('rest_text1'), //'Rest Password',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Color.fromRGBO(230, 238, 156, 1.0),
          centerTitle: true,
        ),
         
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Form(key: formKey, child: _buildResetForm())
            
      )
    )
    );
  }

  _buildResetForm() {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: ListView(children: [
          SizedBox(height: 75.0),
          Container(
             alignment: Alignment.bottomCenter,
              height: 125.0,
              width: 200.0,
              child: Stack(
                children: [
                  logo(),
                ],
              )),
          SizedBox(height: 25.0),
          TextFormField(
              decoration: InputDecoration(
                  labelText: lan.getTexts('rest_text2'),//'EMAIL',
                  labelStyle: TextStyle(
                      fontFamily: 'Trueno',
                      fontSize: 12.0,
                      color: Colors.grey.withOpacity(0.5)),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: greenColor),
                  )),
              onChanged: (value) {
                this.email = value;
              },
              validator: (value) =>
                  value.isEmpty ?  lan.getTexts('rest_text3') //'Email is required' 
                  : validateEmail(value)),
          SizedBox(height: 50.0),
          GestureDetector(
            onTap: () {
              if (checkFields()) AuthService().resetPasswordLink(email);
              final snackBar = SnackBar(content: Text(lan.getTexts('rest_test4')
                //'تم ارسال بريد الكتروني لإعادة ادخال كلمة سر جديده .... ما عرفت ايش اكتب ف كتبت هيك و بعدين بنعدل ^^'
                ));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              Navigator.of(context).pop();
            },
            child: Container(
                height: 50.0,
                child: Material(
                    borderRadius: BorderRadius.circular(25.0),
                  //  shadowColor: Colors.greenAccent,
                    color: Color.fromRGBO(215, 204, 200, 1.0),
                    elevation: 7.0,
                    child: Center(
                        child: Text( lan.getTexts('rest_text5'),//'RESET',
                            style: TextStyle(
                                color: Colors.black, fontFamily: 'Trueno'))))),
          ),
          SizedBox(height: 20.0),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Text( lan.getTexts('rest_text6'),//'Go back',
                    style: TextStyle(
                       color: Colors.teal,
                        fontFamily: 'Trueno',
                        decoration: TextDecoration.underline)))
          ])
        ]));
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
}
