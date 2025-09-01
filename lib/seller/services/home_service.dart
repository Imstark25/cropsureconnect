// lib/seller/home_service.dart

import '../models/home_model.dart';

class HomeService {
  Future<Map<String, dynamic>> fetchMockData() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    final topFarmers = [
      TopFarmer(
        farmerId: 'FARM78654',
        name: 'Subash',
        profileImageUrl: 'https://i.pravatar.cc/150?u=subash',
      ),
      TopFarmer(
        farmerId: 'FARM12345',
        name: 'Kavitha',
        profileImageUrl: 'https://i.pravatar.cc/150?u=kavitha',
      ),
      TopFarmer(
        farmerId: 'FARM67890',
        name: 'Arun',
        profileImageUrl: 'https://i.pravatar.cc/150?u=arun',
      ),
      TopFarmer(
        farmerId: 'FARM11223',
        name: 'Priya',
        profileImageUrl: 'https://i.pravatar.cc/150?u=priya',
      ),
    ];

    // *** UPDATED CATEGORIES WITH LOCAL ASSET PATHS ***
    final categories = [
      Category(
          name: 'Grains',
          icon: 'assets/images/grains.jpeg'), // <-- Added this asset
      Category(
          name: 'Spices',
          icon: 'assets/images/spices.jpeg'), // <-- Added this asset
      Category(
          name: 'Vegetables',
          icon: 'assets/images/vegetable.jpeg'), // <-- Added this asset
      Category(
          name: 'Fruits',
          icon: 'assets/images/fruites.jpeg'), // <-- Added this asset
      // Example of other categories if you want to add them:
      // Category(name: 'Oil Seeds', icon: 'assets/images/oilseeds.jpeg'),
      // Category(name: 'Dairy', icon: 'assets/images/dairy.jpeg'),
    ];

    final products = [
      Product(
        name: 'Ponni Rice',
        image: 'assets/images/rice.jpeg', // Example product image
        seller: 'Salem Farmers Co.',
        quantity: 250,
        location: 'Salem',
        price: 55,
      ),
      Product(
        name: 'Black Pepper',
        image: 'assets/images/spices.jpeg', // Example product image
        seller: 'Yercaud Spice Inc.',
        quantity: 80,
        location: 'Yercaud',
        price: 400,
      ),
      Product(
        name: 'Turmeric Finger',
        image: 'assets/images/spices.jpeg', // Example product image
        seller: 'Erode Traders',
        quantity: 120,
        location: 'Erode',
        price: 120,
      ),
      Product(
        name: 'Salem Mangoes',
        image: 'assets/images/fruites.jpeg', // Example product image
        seller: 'Salem Farmers Co.',
        quantity: 500,
        location: 'Salem',
        price: 80,
      ),
      Product(
        name: 'Fresh Cabbage',
        image: 'assets/images/vegetable.jpeg', // Example product image
        seller: 'Ooty Greens',
        quantity: 300,
        location: 'Ooty',
        price: 30,
      ),
      Product(
        name: 'Wheat Grain',
        image: 'assets/images/wheat.jpeg', // Example product image
        seller: 'Punjab Fields',
        quantity: 1000,
        location: 'Ludhiana',
        price: 25,
      ),
    ];

    return {
      'topFarmers': topFarmers,
      'categories': categories,
      'products': products
    };
  }
}
