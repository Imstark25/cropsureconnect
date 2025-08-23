import 'package:cropsureconnect/buyer/models/importer_profile_model.dart';
import 'package:cropsureconnect/buyer/models/market_crop_model.dart';
import 'package:cropsureconnect/buyer/models/order_model.dart';
import 'package:cropsureconnect/buyer/models/required_document_model.dart';

// Sample document list to be used in the profile below
final List<RequiredDocumentModel> dummyRequiredDocs = [
  RequiredDocumentModel(
    name: 'Business License / Registration',
    status: DocumentUploadStatus.verified,
    expiryDate: DateTime(2025, 12, 31),
  ),
  RequiredDocumentModel(
    name: 'VAT Certificate',
    status: DocumentUploadStatus.notUploaded,
  ),
];

// This object now provides ALL required fields, fixing the error.
final ImporterProfileModel alDahraProfile = ImporterProfileModel(
  companyName: 'Al Dahra Agricultural Company',
  logoPath: 'assets/images/al_dahra_logo.png',
  isVerified: true,
  memberSinceYear: 2024,
  trustLevel: TrustLevel.high,
  activeContractsCount: 12,
  pendingOrdersCount: 3,
  pastImportsCount: 250,
  repeatPurchaseRate: 92.0,
  seasonalDemand: 'Looking for Rice & Wheat suppliers – August 2025',
  cropsInterestedIn: ['Rice', 'Flour', 'Fruits', 'Vegetables', 'Fodder'],
  recentActivity: [
    {'title': 'Order #1234 confirmed', 'icon': 'check'},
    {'title': 'Document verification pending', 'icon': 'pending'},
  ],
  contactPerson: 'Hannah',
  mobile: '+971 50 123 4567',
  isMobileVerified: true,
  email: 'hannah@aldahra.com',
  isEmailVerified: true,
  country: 'United Arab Emirates',
  city: 'Abu Dhabi',
  businessAddress: '123 Business Bay, Dubai, UAE',
  tradeLicenseNumber: 'TRD-12345',
  vatNumber: 'VAT-98765',
  preferredQualityStandards: ['GLOBALG.A.P.', 'ISO'],
  prefersOrganic: true,
  seasonalDemandCalendar: 'Q3 - Q4',
  annualPurchaseVolume: '>10M tons',
  preferredPaymentMethods: ['Bank Transfer', 'SWIFT'],
  currencyPreference: ['USD', 'AED'],
  farmerRating: 4.8,
  transactionHistorySummary: '250+ successful imports',
  averageOrderValue: '\$2M per order',
  repeatPurchaseRateSummary: 'High',
  overallVerificationStatus: OverallVerificationStatus.pending,
  requiredDocuments: dummyRequiredDocs,
);
final List<MarketCropModel> dummyMarketCrops = [
  MarketCropModel(
    imagePath: 'assets/images/rice.png', // Add your asset
    name: 'Basmati Rice',
    variety: 'Pusa 1121',
    originCountry: 'India',
    farmerInfo: 'Punjab Farmer Cooperative #12',
    certifications: ['ISO', 'HACCP'],
    availableVolumeTons: 5000,
    isNegotiable: true,
  ),
  MarketCropModel(
    imagePath: 'assets/images/apples.png', // Add your asset
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
    imagePath: 'assets/images/wheat.png', // Add your asset
    name: 'Milling Wheat',
    variety: 'Hard Red Winter',
    originCountry: 'USA',
    farmerInfo: 'Kansas Agri Group',
    certifications: ['ISO'],
    availableVolumeTons: 10000,
    pricePerTon: 350,
  ),
];

final List<OrderModel> dummyOrders = [
  OrderModel(
    id: '#ORD-2025-0012',
    cropName: 'Basmati Rice',
    quantityTons: 2000,
    originCountry: 'India',
    supplier: 'Farmer Cooperative #7',
    status: OrderStatus.inTransit,
    deliveryDate: DateTime(2025, 8, 28),
  ),
  OrderModel(
    id: '#ORD-2025-0011',
    cropName: 'Organic Apples',
    quantityTons: 500,
    originCountry: 'Spain',
    supplier: 'Barcelona Coop',
    status: OrderStatus.delivered,
    deliveryDate: DateTime(2025, 8, 12),
  ),
  OrderModel(
    id: '#ORD-2025-0010',
    cropName: 'Milling Wheat',
    quantityTons: 10000,
    originCountry: 'USA',
    supplier: 'Kansas Agri Group',
    status: OrderStatus.pending,
    deliveryDate: DateTime(2025, 9, 15),
  ),
  OrderModel(
    id: '#ORD-2025-0009',
    cropName: 'Soybean Meal',
    quantityTons: 3000,
    originCountry: 'Brazil',
    supplier: 'Mato Grosso Farmers',
    status: OrderStatus.cancelled,
    deliveryDate: DateTime(2025, 7, 20),
  ),
  OrderModel(
    id: '#ORD-2025-0008',
    cropName: 'Corn Feed',
    quantityTons: 15000,
    originCountry: 'Argentina',
    supplier: 'Pampas Exporters',
    status: OrderStatus.delivered,
    deliveryDate: DateTime(2025, 6, 30),
  ),
];
