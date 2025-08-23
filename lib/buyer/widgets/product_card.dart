// import 'package:cropsureconnect/buyer/models/product_model.dart';
// import 'package:flutter/material.dart';


// class ProductCard extends StatelessWidget {
//   final ProductModel product;

//   const ProductCard({super.key, required this.product});

//   @override
//   Widget build(BuildContext context) {
//     // Using MediaQuery for responsive width
//     final screenWidth = MediaQuery.of(context).size.width;

//     return Container(
//       width: screenWidth * 0.4, // Card will take up 40% of screen width
//       margin: const EdgeInsets.symmetric(horizontal: 8.0),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: Colors.grey[200]!),
//       ),
//       child: Stack(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   child: Center(
//                     // Replace with your actual image asset
//                     child: Icon(Icons.image, size: 60, color: Colors.grey[300]),
//                     // child: Image.asset(product.imagePath),
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   product.name,
//                   style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 const SizedBox(height: 4),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       '\$${product.price.toStringAsFixed(2)} ${product.unit}',
//                       style: TextStyle(color: Colors.grey[600]),
//                     ),
//                     Container(
//                       decoration: const BoxDecoration(
//                         color: Colors.green,
//                         shape: BoxShape.circle,
//                       ),
//                       child: const Icon(Icons.add, color: Colors.white),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           if (product.discountPercent != null)
//             Positioned(
//               top: 8,
//               left: 8,
//               child: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                 decoration: BoxDecoration(
//                   color: Colors.red,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Text(
//                   '${product.discountPercent}%',
//                   style: const TextStyle(color: Colors.white, fontSize: 12),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }