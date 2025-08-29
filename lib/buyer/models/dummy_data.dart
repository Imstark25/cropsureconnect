import 'package:cropsureconnect/buyer/models/importer_profile_model.dart';
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

final ImporterProfileModel alDahraProfile = ImporterProfileModel(
  // --- Fields from the previous B2B model ---
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

  // --- MISSING FIELDS THAT CAUSED THE ERROR ---
  // These have now been added to fix the issue.
  trustScore: 4.8,
  mainCropInterest: 'Basmati Rice',
  lastTransactionSummary: '5,000 tons from India',
  pendingBookingsCount: 3,
);