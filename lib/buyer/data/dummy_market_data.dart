// ...existing code...
import 'package:cropsureconnect/buyer/models/market_crop_model.dart';

import '../../seller/models/farmer_profile_model.dart';

// 1. Define the detailed Farmer Profiles first
final FarmerProfile punjabCooperative = FarmerProfile(
  farmerId: 'FARM123',
  name: 'Punjab Farmer Cooperative #12',
  phoneNumber: '1234567890',
  mainCrop: 'Wheat',
  currentPlantedCrop: 'Rice',
  previousCrops: ['Wheat', 'Barley'],
  acres: 100,
  capacityInTonnes: 500,
  farmingType: 'Organic',
  fertilizerUsed: 'Organic Compost',
  rating: 4.8,
  exportHistory: [],
  documents: [],
  cropProgressReports: [],
  profileImageUrl: null,
  localProfileImage: null,
);

final FarmerProfile barcelonaGrowers = FarmerProfile(
  farmerId: 'FARM456',
  name: 'Barcelona Growers Union',
  phoneNumber: '9876543210',
  mainCrop: 'Tomato',
  currentPlantedCrop: 'Pepper',
  previousCrops: ['Tomato', 'Lettuce'],
  acres: 50,
  capacityInTonnes: 200,
  farmingType: 'Organic',
  fertilizerUsed: 'Bio-Fertilizers',
  rating: 4.5,
  exportHistory: [],
  documents: [],
  cropProgressReports: [],
  profileImageUrl: null,
  localProfileImage: null,
);

final FarmerProfile kansasAgri = FarmerProfile(
  farmerId: 'FARM789',
  name: 'Kansas Agri Group',
  phoneNumber: '5551234567',
  mainCrop: 'Corn',
  currentPlantedCrop: 'Soybean',
  previousCrops: ['Corn', 'Wheat'],
  acres: 200,
  capacityInTonnes: 1000,
  farmingType: 'Conventional',
  fertilizerUsed: 'Synthetic (NPK)',
  rating: 3.9,
  exportHistory: [],
  documents: [],
  cropProgressReports: [],
  profileImageUrl: null,
  localProfileImage: null,
);

// 2. This is now the single source of truth for market crops
final List<MarketCropModel> dummyMarketCrops = [
  MarketCropModel(
    imagePath: 'assets/images/rice.jpeg',
    name: 'Basmati Rice',
    variety: 'Pusa 1121',
    farmer: punjabCooperative, // Correctly uses the farmer object
    certifications: ['ISO', 'HACCP'],
    availableVolumeTons: 5000,
    isNegotiable: true,
  ),
  MarketCropModel(
    imagePath: 'assets/images/apple.jpg',
    name: 'Organic Apples',
    variety: 'Gala',
    farmer: barcelonaGrowers, // Correctly uses the farmer object
    certifications: ['GLOBALG.A.P.', 'Organic'],
    availableVolumeTons: 2000,
    pricePerTon: 750,
    isPreBook: true,
  ),
  MarketCropModel(
    imagePath: 'assets/images/wheat.jpeg',
    name: 'Milling Wheat',
    variety: 'Hard Red Winter',
    farmer: kansasAgri, // Correctly uses the farmer object
    certifications: ['ISO'],
    availableVolumeTons: 10000,
    pricePerTon: 350,
  ),
];