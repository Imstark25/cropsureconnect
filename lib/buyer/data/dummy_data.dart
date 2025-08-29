import 'package:cropsureconnect/buyer/models/importer_profile_model.dart';

// This single object provides all the data for the prototype UI.
final ImporterProfileModel dummyImporterProfile = ImporterProfileModel(
  // Header & Trust Info
  companyName: 'Al Dahra Agricultural Co.',
  logoPath: 'assets/images/al_dahra_logo.png', // Placeholder path
  isVerified: true,
  trustLevel: TrustLevel.high,
  trustScore: 4.8,

  // Home Screen Card Info
  mainCropInterest: 'Basmati Rice',
  lastTransactionSummary: '5,000 tons from India',
  pendingBookingsCount: 3,

  // --- Fields for other screens (not used in the home screen prototype) ---

  // Detailed Profile Info
  memberSinceYear: 2024,
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

  // Preferences
  cropsInterestedIn: ['Rice', 'Flour', 'Fruits', 'Vegetables', 'Fodder'],
  preferredQualityStandards: ['GLOBALG.A.P.', 'ISO'],
  prefersOrganic: true,
  seasonalDemandCalendar: 'Q3 - Q4',
  annualPurchaseVolume: '>10M tons',
  preferredPaymentMethods: ['Bank Transfer', 'SWIFT'],
  currencyPreference: ['USD', 'AED'],

  // Ratings & History
  farmerRating: 4.8,
  transactionHistorySummary: '250+ successful imports',
  averageOrderValue: '\$2M per order',
  repeatPurchaseRateSummary: 'High',

  // Quick Stats (can be used to replace hardcoded values later)
  activeContractsCount: 12,
  pendingOrdersCount: 3,
  pastImportsCount: 250,
  repeatPurchaseRate: 92.0,
  seasonalDemand: 'Looking for Rice & Wheat suppliers – August 2025',
  recentActivity: [
    {'title': 'Order #1234 confirmed', 'icon': 'check'},
    {'title': 'Document verification pending', 'icon': 'pending'},
  ],

  // Documents Section
  overallVerificationStatus: OverallVerificationStatus.pending,
  requiredDocuments: [], // This would be populated in a real scenario
);