// import 'package:flutter/material.dart';

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: ListView(
//         //scrollDirection: Axis.vertical,
//         controller: ScrollController(),
//         shrinkWrap: true,
//         children: [
//           CarouselSlider(
//             items: [
//               //1st Image of Slider
//               Container(
//                 margin: EdgeInsets.only(bottom: 6, left: 6, right: 6),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(8.0),
//                   // border: Border.all(color: Colors.black26, width: 2),
//                   image: const DecorationImage(
//                     image: AssetImage('assets/images/proManagement.png'),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),

//               //2nd Image of Slider
//               Container(
//                 margin: EdgeInsets.only(bottom: 6, left: 6, right: 6),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(8.0),
//                   image: DecorationImage(
//                     image: AssetImage('assets/images/realTime.png'),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),

//               //3rd Image of Slider
//               Container(
//                 margin: EdgeInsets.only(bottom: 6, left: 6, right: 6),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(8.0),
//                   image: DecorationImage(
//                     image: AssetImage('assets/images/pirGraph.png'),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),

//               //4th Image of Slider
//               Container(
//                 margin: EdgeInsets.only(bottom: 6, left: 6, right: 6),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(8.0),
//                   image: DecorationImage(
//                     image: AssetImage('assets/images/proManagement.png'),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),

//               //5th Image of Slider
//               Container(
//                 margin: EdgeInsets.only(bottom: 6, left: 6, right: 6),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(8.0),
//                   image: DecorationImage(
//                     image: AssetImage('assets/images/proManagement.png'),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             ],

//             //Slider Container properties
//             options: CarouselOptions(
//               height: 200.0,
//               enlargeCenterPage: true,
//               autoPlay: true,
//               aspectRatio: 16 / 9,
//               autoPlayCurve: Curves.fastOutSlowIn,
//               enableInfiniteScroll: true,
//               autoPlayAnimationDuration: Duration(milliseconds: 150),
//               viewportFraction: 0.8,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
