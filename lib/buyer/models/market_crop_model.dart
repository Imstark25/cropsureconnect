// File: lib/buyer/models/market_crop_model.dart

import '../../seller/models/farmer_profile_model.dart';
// ...existing code...

class MarketCropModel {
  final String imagePath;
  final String name;
  final String variety;
  final FarmerProfile farmer; // <-- UPDATED: Was String farmerInfo
  final List<String> certifications;
  final int availableVolumeTons;
  final double? pricePerTon;
  final bool isNegotiable;
  final bool isPreBook;
  final String? description;

  MarketCropModel({
    required this.imagePath,
    required this.name,
    required this.variety,
    required this.farmer, // <-- UPDATED
    required this.certifications,
    required this.availableVolumeTons,
    this.pricePerTon,
    this.isNegotiable = false,
    this.isPreBook = false,
    this.description,
  });
}