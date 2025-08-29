import 'package:cloud_firestore/cloud_firestore.dart';


import 'required_document_model.dart';

// --- Enums ---
enum TrustLevel { high, medium, low }
enum OverallVerificationStatus { verified, pending, rejected }

// --- Main Model Class ---
class ImporterProfileModel {
  // --- HEADER & TRUST ---
  final String companyName;
  final String logoPath;
  final bool isVerified;
  final int memberSinceYear;
  final TrustLevel trustLevel;
  final double trustScore; // From prototype

  // --- HOME SCREEN & QUICK STATS ---
  final int activeContractsCount;
  final int pendingOrdersCount;
  final int pastImportsCount;
  final double repeatPurchaseRate;
  final String seasonalDemand;
  final List<Map<String, String>> recentActivity;
  final String mainCropInterest; // From prototype
  final String lastTransactionSummary; // From prototype
  final int pendingBookingsCount; // From prototype

  // --- BASIC INFO ---
  final String businessAddress;
  final String country;
  final String city;
  final String contactPerson;
  final String email;
  final bool isEmailVerified;
  final String mobile;
  final bool isMobileVerified;

  // --- BUSINESS & PREFERENCES ---
  final String tradeLicenseNumber;
  final String vatNumber;
  final List<String> cropsInterestedIn;
  final List<String> preferredQualityStandards;
  final bool prefersOrganic;
  final String seasonalDemandCalendar;
  final String annualPurchaseVolume;
  final List<String> preferredPaymentMethods;
  final List<String> currencyPreference;

  // --- RATINGS & HISTORY ---
  final double farmerRating;
  final String transactionHistorySummary;
  final String averageOrderValue;
  final String repeatPurchaseRateSummary;

  // --- DOCUMENTS ---
  final OverallVerificationStatus overallVerificationStatus;
  final List<RequiredDocumentModel> requiredDocuments;

  ImporterProfileModel({
    // Header & Trust
    required this.companyName,
    required this.logoPath,
    required this.isVerified,
    required this.memberSinceYear,
    required this.trustLevel,
    required this.trustScore,
    // Home Screen & Quick Stats
    required this.activeContractsCount,
    required this.pendingOrdersCount,
    required this.pastImportsCount,
    required this.repeatPurchaseRate,
    required this.seasonalDemand,
    required this.recentActivity,
    required this.mainCropInterest,
    required this.lastTransactionSummary,
    required this.pendingBookingsCount,
    // Basic Info
    required this.businessAddress,
    required this.country,
    required this.city,
    required this.contactPerson,
    required this.email,
    required this.isEmailVerified,
    required this.mobile,
    required this.isMobileVerified,
    // Business & Preferences
    required this.tradeLicenseNumber,
    required this.vatNumber,
    required this.cropsInterestedIn,
    required this.preferredQualityStandards,
    required this.prefersOrganic,
    required this.seasonalDemandCalendar,
    required this.annualPurchaseVolume,
    required this.preferredPaymentMethods,
    required this.currencyPreference,
    // Ratings & History
    required this.farmerRating,
    required this.transactionHistorySummary,
    required this.averageOrderValue,
    required this.repeatPurchaseRateSummary,
    // Documents
    required this.overallVerificationStatus,
    required this.requiredDocuments,
  });

  factory ImporterProfileModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>? ?? {};

    TrustLevel parseTrustLevel(String? level) {
      switch (level?.toLowerCase()) {
        case 'high': return TrustLevel.high;
        case 'medium': return TrustLevel.medium;
        default: return TrustLevel.low;
      }
    }

    OverallVerificationStatus parseOverallStatus(String? status) {
      switch (status?.toLowerCase()) {
        case 'verified': return OverallVerificationStatus.verified;
        case 'pending': return OverallVerificationStatus.pending;
        default: return OverallVerificationStatus.rejected;
      }
    }

    return ImporterProfileModel(
      // Header & Trust
      companyName: data['user_name'] ?? 'N/A',
      logoPath: data['logo_path'] ?? '',
      isVerified: data['is_verified'] ?? false,
      memberSinceYear: data['member_since_year'] ?? DateTime.now().year,
      trustLevel: parseTrustLevel(data['trust_level']),
      trustScore: (data['trust_score'] ?? 0.0).toDouble(),
      // Home Screen & Quick Stats
      activeContractsCount: data['active_contracts_count'] ?? 0,
      pendingOrdersCount: data['pending_orders_count'] ?? 0,
      pastImportsCount: data['past_imports_count'] ?? 0,
      repeatPurchaseRate: (data['repeat_purchase_rate'] ?? 0.0).toDouble(),
      seasonalDemand: data['seasonal_demand'] ?? 'No current demand specified',
      recentActivity: List<Map<String, String>>.from(
        (data['recent_activity'] as List<dynamic>? ?? []).map(
              (item) => Map<String, String>.from(item),
        ),
      ),
      mainCropInterest: data['main_crop_interest'] ?? 'N/A',
      lastTransactionSummary: data['last_transaction_summary'] ?? 'N/A',
      pendingBookingsCount: data['pending_bookings_count'] ?? 0,
      // Basic Info
      contactPerson: data['contact_person'] ?? 'N/A',
      mobile: data['user_phone'] ?? 'N/A',
      isMobileVerified: data['is_mobile_verified'] ?? false,
      email: data['user_email'] ?? 'N/A',
      isEmailVerified: data['is_email_verified'] ?? false,
      country: data['country'] ?? 'N/A',
      city: data['city'] ?? 'N/A',
      businessAddress: data['business_address'] ?? 'N/A',
      // Business & Preferences
      tradeLicenseNumber: data['trade_license_number'] ?? 'Not Provided',
      vatNumber: data['vat_number'] ?? 'Not Provided',
      cropsInterestedIn: List<String>.from(data['crops_interested_in'] ?? []),
      preferredQualityStandards: List<String>.from(data['preferred_quality_standards'] ?? []),
      prefersOrganic: data['prefers_organic'] ?? false,
      seasonalDemandCalendar: data['seasonal_demand_calendar'] ?? 'N/A',
      annualPurchaseVolume: data['annual_purchase_volume'] ?? 'N/A',
      preferredPaymentMethods: List<String>.from(data['preferred_payment_methods'] ?? []),
      currencyPreference: List<String>.from(data['currency_preference'] ?? []),
      // Ratings & History
      farmerRating: (data['farmer_rating'] ?? 0.0).toDouble(),
      transactionHistorySummary: data['transaction_history_summary'] ?? 'N/A',
      averageOrderValue: data['average_order_value'] ?? 'N/A',
      repeatPurchaseRateSummary: data['repeat_purchase_rate_summary'] ?? 'N/A',
      // Documents
      overallVerificationStatus: parseOverallStatus(data['overall_verification_status']),
      requiredDocuments: [], // In a real app, this would be parsed from a subcollection
    );
  }
}