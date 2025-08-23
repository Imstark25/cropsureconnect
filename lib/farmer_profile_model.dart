import 'dart:io';



class Document {
  String name;
  File? file;
  String? url;
  bool isVerified;
  String type;

  Document({
    required this.name,
    this.file,
    this.url,
    this.isVerified = false,
    required this.type,
  });
}

class ExportRecord {
  final String year;
  final String crop;
  final String country;
  final double rating;

  ExportRecord({
    required this.year,
    required this.crop,
    required this.country,
    required this.rating,
  });
}

// New class for a single crop progress report
class CropProgressReport {
  final String id;
  final DateTime reportDate;
  final String imageUrl;
  File? localImageFile; // For new uploads

  CropProgressReport({
    required this.id,
    required this.reportDate,
    required this.imageUrl,
    this.localImageFile,
  });
}


class FarmerProfile {
  String farmerId;
  String name;
  String? profileImageUrl;
  File? localProfileImage;
  String phoneNumber;
  String mainCrop;
  String currentPlantedCrop; // Added this field
  List<String> previousCrops;
  double acres;
  double capacityInTonnes;
  String farmingType;
  String fertilizerUsed;
  double rating;
  List<ExportRecord> exportHistory;
  List<Document> documents;
  List<CropProgressReport> cropProgressReports; // Added this list

  FarmerProfile({
    required this.farmerId,
    required this.name,
    this.profileImageUrl,
    this.localProfileImage,
    required this.phoneNumber,
    required this.mainCrop,
    required this.currentPlantedCrop,
    required this.previousCrops,
    required this.acres,
    required this.capacityInTonnes,
    required this.farmingType,
    required this.fertilizerUsed,
    required this.rating,
    required this.exportHistory,
    required this.documents,
    required this.cropProgressReports,
  });
}