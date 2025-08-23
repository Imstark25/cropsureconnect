// import 'package:flutter/material.dart';
// import 'package:cropsureconnect/buyer/models/importer_profile_model.dart';

// class GreetingBar extends StatelessWidget {
//   final ImporterProfileModel profile;
//   const GreetingBar({super.key, required this.profile});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
//       child: Row(
//         children: [
//           CircleAvatar(
//             radius: 24,
//             // You can use an AssetImage if you have a local logo
//             // backgroundImage: AssetImage(profile.logoPath),
//             child: const Icon(Icons.business),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Flexible(
//                       child: Text(
//                         'Welcome, ${profile.companyName}',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 18,
//                           color: Colors.grey[800],
//                         ),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                     if (profile.isVerified) ...[
//                       const SizedBox(width: 4),
//                       const Icon(Icons.verified, color: Colors.blue, size: 18),
//                     ],
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           // The Spacer and IconButton for the cart have been removed.
//         ],
//       ),
//     );
//   }
// }
