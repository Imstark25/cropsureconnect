
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

import 'farmer_profile_model.dart';


class FarmerProfileController extends GetxController {
  var isLoading = true.obs;
  final Rx<FarmerProfile?> farmerProfile = Rx<FarmerProfile?>(null);

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    fetchFarmerProfile();
  }

  void fetchFarmerProfile() async {
    try {
      isLoading(true);
      await Future.delayed(const Duration(milliseconds: 800));

      farmerProfile.value = FarmerProfile(
        farmerId: 'FARM78654',
        name: 'Subash',
        phoneNumber: '9876543210',
        profileImageUrl: 'https://i.pravatar.cc/150?u=subash',
        mainCrop: 'Rice',
        currentPlantedCrop: 'Basmati Rice',
        previousCrops: ['Turmeric', 'Sugarcane'],
        acres: 15.5,
        capacityInTonnes: 30,
        farmingType: 'Organic',
        fertilizerUsed: 'Panchagavya, Jeevamrutham',
        rating: 4.8,
        // More varied data for the chart
        exportHistory: [
          ExportRecord(year: '2023', crop: 'Rice', country: 'USA', rating: 4.5),
          ExportRecord(year: '2024', crop: 'Turmeric', country: 'Germany', rating: 4.9),
          ExportRecord(year: '2024', crop: 'Rice', country: 'UAE', rating: 4.7),
          ExportRecord(year: '2025', crop: 'Mangoes', country: 'UK', rating: 4.8),
        ],
        documents: [
          Document(name: 'Organic Certificate', type: 'Organic', isVerified: true, url: 'path/to/organic.pdf'),
          Document(name: 'GLOBALG.A.P. Cert', type: 'GLOBALG.A.P.', isVerified: true, url: 'path/to/globalgap.pdf'),
        ],
        // Using stable image URLs
        cropProgressReports: [
          CropProgressReport(id: 'R1', reportDate: DateTime(2025, 8, 16), imageUrl: 'https://images.unsplash.com/photo-1595138135742-15f012b18753?q=80&w=300'),
          CropProgressReport(id: 'R2', reportDate: DateTime(2025, 8, 9), imageUrl: 'https://images.unsplash.com/photo-1560447992-91372863ce04?q=80&w=300'),
          CropProgressReport(id: 'R3', reportDate: DateTime(2025, 8, 2), imageUrl: 'https://images.unsplash.com/photo-1560447992-82855f462a34?q=80&w=300'),
        ],
      );
    } finally {
      isLoading(false);
    }
  }

  // ... (all other methods like pickImage, pickDocumentForType, etc. remain the same)
  Future<void> addCropProgressReport() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      final newReport = CropProgressReport(
        id: 'NEW_${DateTime.now().millisecondsSinceEpoch}',
        reportDate: DateTime.now(),
        imageUrl: '',
        localImageFile: File(image.path),
      );
      farmerProfile.update((val) {
        val?.cropProgressReports.insert(0, newReport);
      });
      Get.snackbar('Success', 'New crop report added!');
    }
  }

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      farmerProfile.update((val) {
        val?.localProfileImage = File(image.path);
      });
    }
  }

  Future<void> pickDocumentForType(String docType) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'png'],
    );
    if (result != null) {
      File file = File(result.files.single.path!);
      String fileName = result.files.single.name;
      farmerProfile.update((val) {
        if (val != null) {
          int docIndex = val.documents.indexWhere((doc) => doc.type == docType);
          if (docIndex != -1) {
            val.documents[docIndex].file = file;
            val.documents[docIndex].name = fileName;
            val.documents[docIndex].isVerified = false;
          } else {
            val.documents.add(Document(name: fileName, file: file, type: docType));
          }
        }
      });
      Get.snackbar('Success', '$docType certificate updated.');
    }
  }

  void saveProfile(Map<String, String> updatedData) {
    farmerProfile.update((val) {
      if (val != null) {
        val.name = updatedData['name'] ?? val.name;
        val.phoneNumber = updatedData['phoneNumber'] ?? val.phoneNumber;
        val.mainCrop = updatedData['mainCrop'] ?? val.mainCrop;
        val.farmingType = updatedData['farmingType'] ?? val.farmingType;
        val.fertilizerUsed = updatedData['fertilizerUsed'] ?? val.fertilizerUsed;
      }
    });
    Get.back();
    Get.snackbar('Success', 'Profile updated successfully!');
  }
}