import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider with ChangeNotifier {
  bool isEn = true;

  Map<String, Object> textsAr = {
    "tab_item1": "الصفحة الرئيسية",
    "tab_item2": "إضافة منشور",
    "tab_item3": "بحث",
    "tab_item4": "دردشة",
    "tab_item5": "الصفحة الشخصية",
    "tab_item6": "الخريطة",
    "drawer_item1": "الإعدادت",
    "drawer_item2": "تحديث الصفحة الشخصية ",
    "drawer_item3": "اللغة",
    "sub_drawer_item1": "العربية",
    "sub_drawer_item2": "الأنجليزية",
    "drawer_item5": "الإحصائيات",
    "drawer_item6": "حذف الحساب",
    "drawer_item7": "حول",
    "drawer_item8": "تسجيل الخروج",
    "Alert_dialog1":" اختر الصورة من:",
    "Alert_dialog2":"المعرض",
    "Alert_dialog3":"الكاميرا",
    "home_item1":"المتبرعون الذهبيون لهذا الشهر",
    "About_Screen":"""
  انطلقت فكرة تطوير هذا التطبيق ، جود ، في المقام الأول من منظور إنساني. يتم التخلص من المزيد من الطعام الزائد ، منذ زيادة عدد المطاعم ؛ لذلك ، الشراء والبيع غير المتوازنين وغير المتسقين للمنتجات الغذائية. 
  يسعى تطبيق جود للحفاظ على وجبات الطعام لمن هم في أمس الحاجة إليها.
  نتوقع أن يحل هذا المشروع مشكلة هدر الطعام من خلال إعطائه لمن هم في أمس الحاجة إليه ، على أمل أن يتم التعرف على تطبيق جود يومًا ما والنظر إليه على أنه تطبيق يخدم العالم ليصبح مكانًا أفضل.""",
    "logo_loading":"جاري التحميل",
    "intro1_word":"جود",
    "intro1_sentence":"نرتقي بدعم الآخرين",
    "intro2_sentence":"ابدأ تجربتك الآن...",
    "appBar_Map_screen1":"خرائط جوجل",
    "Map_screen_sentence":"أهلا بك في جود",
    "login_Text_screen1":"تسجيل الدخول",
    "Login_hintText1":"البريد الألكتروني",
    "Login_hintText2":"كلمة السر",
    "Login_AlertDialog_msg1":"الرجاء ادخال البريد الألكتروني و كلمة السر",
    "Login_Text_screen2":"تسجيل الدخول",
    "Login_Text_screen3":"الدخول باستخدام جوجل",
    "Login_Text_screen4":"أنا مسؤول",
    "Login_AlertDialog_msg2":"جاري المصادقة ، الرجاء الانتظار ...",
    "privateRegister_hintText1":"الأسم",
    "privateRegister_hintText2":"البريد الألكتروني",
    "privateRegister_hintText3":"كلمة السر",
    "privateRegister_hintText4":"تأكيد كلمة المرور",
    "privateRegister_Text1":"تسجيل",
    "privateRegister_AlertDialog_msg1":"الرجاء تحديد ملف صورة.",
    "privateRegister_AlertDialog_msg2":"يرجى ملء استمارة التسجيل كاملة ...",
    "privateRegister_AlertDialog_msg3":"كلمة السر غير مطابقة.",
    "privateRegister_LoadAlertDialog_msg1":"جاري التسجيل من فضلك انتظر .....",
    "register_AppBar_Txt":"نوع التسجيل",
    "register_Screen_Text1":"حساب تجاري",
    "register_Screen_Text2":"حساب خاص",
    "Auth_Screen_AppBar":"جود",
    "Auth_Screen_Tab1":"تسجيل الدخول",
    "Auth_Screen_Tab2":"تسجيل",
    "bussRegister_hintText1":"الأسم",
    "bussRegister_hintText2":"البريد الألكتروني",
    "bussRegister_hintText3":"كلمة السر",
    "bussRegister_hintText4":"تأكيد كلمة المرور",
    "buss_Screen_FlatButton_Text":"إضافة",
    "bussRegister_Text1":"تسجيل",
    "bussRegister_AlertDialog_msg1":"الرجاء تحديد ملف صورة.",
    "bussRegister_AlertDialog_msg2":"يرجى ملء استمارة التسجيل كاملة ...",
    "bussRegister_AlertDialog_msg3":"كلمة السر غير مطابقة.",
    "bussRegister_LoadAlertDialog_msg1":"جاري التسجيل من فضلك انتظر .....",
    "Admin_login_Text":"مسؤول",
    "Admin_hint_Text1":" رقم الهوية الشخصية",
    "Admin_hint_Text2":"كلمة السر",
    "Admin_ErrorAlertDialog_msg":"الرجاء ادخال البريد الألكتروني و كلمة السر",
    "Admin_login_Text2":"تسجيل الدخول",
    "Admin_Flat_button":"أنا لست مسؤول",
    "Admin_Screen_AppBar_Text":"جود",
    "error_Alert_Dialog_Text":"نعم"
  };

  Map<String, Object> textsEn = {
    "tab_item1": "Home",
    "tab_item2": "Post An Announcements",
    "tab_item3": "Search",
    "tab_item4": "Chat",
    "tab_item5": "Profile",
    "tab_item6": "GPS",
    "drawer_item1": "Settings",
    "drawer_item2": "Update Profile",
    "drawer_item3": "Language",
    "sub_drawer_item1": "Arabic",
    "sub_drawer_item2": "English",
    "drawer_item5": "Statistics",
    "drawer_item6": "Delete account",
    "drawer_item7": "About",
    "drawer_item8": "Sign out",
    "Alert_dialog1": "Choose Picture from:",
    "Alert_dialog2":"Gallery",
    "Alert_dialog3":"Camera",
    "home_item1":"Golden Donors This Month",
    "About_Screen":"""
     The spark of the idea for developing this App, Joud, primarily came from a humane perspective. More excess food is thrown away, since the increase in the number of restaurants; therefore, the unbalanced and inconsistent buying and selling of food products.
     The Joud App seeks to preserve the meals for those who need them most. 
     We expect this project to solve the food waste problem by giving it to those who need it most, hoping that the Joud App someday may be recognized and seen as an App that serves the world to become a better place.""",
    "logo_loading":"Loading",
    "intro1_word":"Joud",
    "intro1_sentence":"We rise by lifting others.",
    "intro2_sentence":"Start your Experience Now...",
    "appBar_Map_screen1":"Google Map",
    "Map_screen_sentence":"welcome To JOUD",
    "login_Text_screen1":"Login to your account",
    "Login_hintText1":"Email",
    "Login_hintText2":"Password",
    "Login_AlertDialog_msg1":"Please write email and password",
    "Login_Text_screen2":"Login",
    "Login_Text_screen3":"Sign in with Google",
    "Login_Text_screen4":"I'm Admin",
    "Login_AlertDialog_msg2":"Authenticating, Please wait...",
    "privateRegister_hintText1":"Name",
    "privateRegister_hintText2":"Email",
    "privateRegister_hintText3":"Password",
    "privateRegister_hintText4":"Confirm Password",
    "privateRegister_Text1":"Sign Up",
    "privateRegister_AlertDialog_msg1":"Please select an image file.",
    "privateRegister_AlertDialog_msg2": "Please fill up the registration complete form...",
    "privateRegister_AlertDialog_msg3":"Password do not match.",
    "privateRegister_LoadAlertDialog_msg1":"Registering, Please wait.....",
    "register_AppBar_Txt":"Registration Type",
    "register_Screen_Text1":"Business Account",
    "register_Screen_Text2":"Private Account",
    "Auth_Screen_AppBar":"Joud",
    "Auth_Screen_Tab1":"Login",
    "Auth_Screen_Tab2":"Register",
    "bussRegister_hintText1":"Name",
    "bussRegister_hintText2":"Email",
    "bussRegister_hintText3":"Password",
    "bussRegister_hintText4":"Confirm Password",
    "buss_Screen_FlatButton_Text":"Add",
    "bussRegister_Text1":"Sign Up",
    "bussRegister_AlertDialog_msg1":"Please select an image file.",
    "bussRegister_AlertDialog_msg2": "Please fill up the registration complete form...",
    "bussRegister_AlertDialog_msg3":"Password do not match.",
    "bussRegister_LoadAlertDialog_msg1":"Registering, Please wait.....",
    "Admin_login_Text":"Admin",
    "Admin_hint_Text1":"id",
    "Admin_hint_Text2":"Password",
    "Admin_ErrorAlertDialog_msg":"Please write email and password",
    "Admin_login_Text2":"Login",
    "Admin_Flat_button":"I'm not Admin",
    "Admin_Screen_AppBar_Text":"Joud",
    "error_Alert_Dialog_Text":"OK",

  };

  changeLan(bool lan) async {
    isEn = lan;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isEn",isEn);
  }
  getLan()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isEn =  prefs.getBool("isEn")?? true;
    notifyListeners();
  }
  Object getTexts(String txt) {
    if (isEn == true) return textsEn[txt];
    return textsAr[txt];
  }
}