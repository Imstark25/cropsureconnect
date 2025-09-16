// File: lib/buyer/models/contract_model.dart

import '../../seller/models/farmer_profile_model.dart';
import 'market_crop_model.dart';


// Assuming you have a Buyer/Importer Profile model
class ImporterProfile {
  final String importerId;
  final String companyName;
  final String location;

  ImporterProfile({
    required this.importerId,
    required this.companyName,
    required this.location,
  });
}

class ContractModel {
  final String contractRefNo;
  final DateTime contractDate;
  final MarketCropModel crop;
  final FarmerProfile farmer;
  final ImporterProfile importer;
  final double quantityTons;
  final double unitPrice; // USD per Ton
  final DateTime deliveryDate;
  final String portOfDelivery;
  final String paymentTermsSummary;

  ContractModel({
    required this.contractRefNo,
    required this.contractDate,
    required this.crop,
    required this.farmer,
    required this.importer,
    required this.quantityTons,
    required this.unitPrice,
    required this.deliveryDate,
    required this.portOfDelivery,
    required this.paymentTermsSummary,
  });

  double get totalContractValue => quantityTons * unitPrice;
}