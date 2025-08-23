// import 'package:flutter/material.dart';

// class SpecialOfferBanner extends StatelessWidget {
//   const SpecialOfferBanner({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.all(16.0),
//       padding: const EdgeInsets.all(20.0),
//       decoration: BoxDecoration(
//         color: Colors.teal[50],
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Enjoy The Special Offer',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.teal[800],
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   'Up To 30%',
//                   style: TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.w900,
//                     color: Colors.teal,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   'From 14th June, 2025',
//                   style: TextStyle(
//                     color: Colors.grey[600],
//                     fontSize: 12,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           // Image.asset('assets/images/offer_fruits.png', height: 80), // Optional image
//         ],
//       ),
//     );
//   }
// }