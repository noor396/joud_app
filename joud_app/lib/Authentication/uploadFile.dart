// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart' as http;

// class UploadPage extends StatefulWidget {
//   // UploadPage({Key key, this.url}) : super(key: key);
//   @override
//   _UploadPageState createState() => _UploadPageState();
// }

// class _UploadPageState extends State<UploadPage> {
//   String url = "";

//   Future<String> uploadImage(filename, url) async {
//     var request = http.MultipartRequest('POST', Uri.parse(url));
//     request.files.add(await http.MultipartFile.fromPath('picture', filename));
//     var res = await request.send();
//     return res.reasonPhrase;
//   }

//   String state = "";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Upload File'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[Text(state)],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           var file = await ImagePicker.pickImage(source: ImageSource.gallery);
//           var res = await uploadImage(file.path, widget.url);
//           setState(() {
//             state = res;
//             print(res);
//           });
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }

//   @override
//   void debugFillProperties(DiagnosticPropertiesBuilder properties) {
//     super.debugFillProperties(properties);
//     properties.add(StringProperty('url', url));
//   }
// }
