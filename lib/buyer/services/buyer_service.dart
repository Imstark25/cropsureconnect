import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/importer_profile_model.dart';

class BuyerService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // This function fetches the buyer's profile from the 'Buyers' collection
  Future<ImporterProfileModel> getBuyerProfile(String uid) async {
    try {
      final doc = await _db.collection('Buyers').doc(uid).get();
      if (doc.exists) {
        return ImporterProfileModel.fromFirestore(doc);
      } else {
        throw Exception('Buyer profile document not found.');
      }
    } catch (e) {
      throw Exception('Failed to load profile: $e');
    }
  }

  // This function updates the buyer's profile in Firestore
  Future<void> updateBuyerProfile(String uid, Map<String, dynamic> data) async {
    try {
      await _db.collection('Buyers').doc(uid).update(data);
      Get.snackbar(
        "Success",
        "Your profile has been updated successfully.",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Profile could not be updated. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
      );
      throw Exception('Failed to update profile: $e');
    }
  }
}