import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/importer_profile_model.dart';
import '../services/buyer_service.dart';


class ProfileController extends GetxController {
  final BuyerService _buyerService = Get.find<BuyerService>();
  final User? _currentUser = FirebaseAuth.instance.currentUser;

  final RxBool isLoading = true.obs;
  final Rxn<ImporterProfileModel> profile = Rxn<ImporterProfileModel>();

  @override
  void onInit() {
    super.onInit();
    loadProfileData();
  }

  Future<void> loadProfileData() async {
    // This is a placeholder for a real prototype.
    // In a real app, this would fetch from the database.
    isLoading.value = true;
    // We can use a small delay to simulate loading
    await Future.delayed(const Duration(milliseconds: 500));
    // For now, we will just set a default profile or handle null
    // In a real app: profile.value = await _buyerService.getBuyerProfile(_currentUser!.uid);
    isLoading.value = false;
  }
}