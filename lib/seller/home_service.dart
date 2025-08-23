

import 'home_model.dart';

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

    // *** UPDATED CATEGORIES WITH LOCAL ASSET FOR GRAINS ***
    final categories = [
      Category(name: 'Grains', icon: 'assets/grain_category.jpg'), // Local asset path
      Category(name: 'Spices', icon: 'https://picsum.photos/seed/spices/200/200'),
      Category(name: 'Vegetables', icon: 'https://picsum.photos/seed/veg/200/200'),
      Category(name: 'Fruits', icon: 'https://picsum.photos/seed/fruits/200/200'),
    ];

    final products = [
      Product(
        name: 'Ponni Rice',
        image: '',
        seller: 'Salem Farmers Co.',
        quantity: 250,
        location: 'Salem',
        price: 55,
      ),
      Product(
        name: 'Black Pepper',
        image: '',
        seller: 'Yercaud Spice Inc.',
        quantity: 80,
        location: 'Yercaud',
        price: 400,
      ),
      Product(
        name: 'Turmeric Finger',
        image: 'https://picsum.photos/seed/turmeric/200/200',
        seller: 'Erode Traders',
        quantity: 150,
        location: 'Erode',
        price: 120,
      ),
      Product(
        name: 'Salem Mangoes',
        image: 'https://picsum.photos/seed/mangoes/200/200',
        seller: 'Salem Farmers Co.',
        quantity: 500,
        location: 'Salem',
        price: 80,
      ),
    ];

    return {
      'topFarmers': topFarmers,
      'categories': categories,
      'products': products
    };
  }
}