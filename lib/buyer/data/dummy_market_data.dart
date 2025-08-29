import '../models/market_crop_model.dart';


// This list contains only the data needed for the Market Screen.
final List<MarketCropModel> dummyMarketCrops = [
  MarketCropModel(
    imagePath: 'assets/images/rice.png',
    name: 'Basmati Rice',
    variety: 'Pusa 1121',
    originCountry: 'India',
    farmerInfo: 'Punjab Farmer Cooperative #12',
    certifications: ['ISO', 'HACCP'],
    availableVolumeTons: 5000,
    isNegotiable: true,
  ),
  MarketCropModel(
    imagePath: 'assets/images/apples.png',
    name: 'Organic Apples',
    variety: 'Gala',
    originCountry: 'Spain',
    farmerInfo: 'Barcelona Growers Union',
    certifications: ['GLOBALG.A.P.', 'Organic'],
    availableVolumeTons: 2000,
    pricePerTon: 750,
    isPreBook: true,
  ),
  MarketCropModel(
    imagePath: 'assets/images/wheat.png',
    name: 'Milling Wheat',
    variety: 'Hard Red Winter',
    originCountry: 'USA',
    farmerInfo: 'Kansas Agri Group',
    certifications: ['ISO'],
    availableVolumeTons: 10000,
    pricePerTon: 350,
  ),
];