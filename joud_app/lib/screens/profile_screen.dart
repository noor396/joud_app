// import 'package:flutter/material.dart';
// import 'package:image/image.dart';

// class ProfileScreen extends StatelessWidget {
//   static const routeName = '/profile';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: new Stack(
//       children: <Widget>[
//         ClipPath(
//           child: Container(
//             color: Colors.black.withOpacity(0.80),
//           ),
//           clipper: getClipper(),
//         ),
//         Positioned(
//           width: 350.0,
//           top: MediaQuery.of(context).size.height/5,
//           child: Column(children:<Widget> [
//             Container(
//               width: 150.0,
//               height: 150.0,
//               decoration: BoxDecoration(
//                 color: Colors.red,
//                 image: DecorationImage(
//                   image: NetworkImage('url'),
//                   fit : BoxFit.cover
//                 ),
//                 borderRadius: BorderRadius.all(Radius.circular(75.0)
//                 ),
//                 boxShadow: [
//                   BoxShadow(blurRadius: 7.0 , color: Colors.black)
//                 ],
//               ),
//               ),
//           ],
//           ),
//         )
//       ],
//     ));
//   }
// }

// class getClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     var path = new Path();
//     path.lineTo(0.0, size.height / 1.9);
//     path.lineTo(size.width + 125, 0.0);
//   }

//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
//     return true;
//   }
// }
