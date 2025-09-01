import 'package:cloud_firestore/cloud_firestore.dart';

// This class represents the preview data for a top farmer on the home page.
class TopFarmer {
  final String farmerId;
  final String name;
  final String profileImageUrl;

  TopFarmer({
    required this.farmerId,
    required this.name,
    required this.profileImageUrl,
  });

  // You can also add a factory constructor for Firebase if needed
  factory TopFarmer.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return TopFarmer(
      farmerId: doc.id, // Use the document ID as the farmerId
      name: data['name'] ?? '',
      profileImageUrl: data['profileImageUrl'] ?? '',
    );
  }
}

// This class represents a product category.
class Category {
  final String name;
  final String icon;

  Category({required this.name, required this.icon});

  factory Category.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Category(
      name: data['name'] ?? '',
      icon: data['icon'] ?? '',
    );
  }
}

// This class represents a single product listing.
class Product {
  final String name;
  final String image;
  final String seller;
  final int quantity;
  final String location;
  final double price;

  Product({
    required this.name,
    required this.image,
    required this.seller,
    required this.quantity,
    required this.location,
    required this.price,
  });

  factory Product.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Product(
      name: data['name'] ?? '',
      image: data['image'] ?? '',
      seller: data['seller'] ?? '',
      quantity: (data['quantity'] ?? 0).toInt(),
      location: data['location'] ?? '',
      price: (data['price'] ?? 0.0).toDouble(),
    );
  }
}