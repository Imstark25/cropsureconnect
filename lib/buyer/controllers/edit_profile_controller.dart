import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/importer_profile_model.dart';
import '../services/buyer_service.dart';

class EditProfileController extends GetxController {
  final ImporterProfileModel profile;
  EditProfileController({required this.profile});

  final BuyerService _buyerService = Get.find<BuyerService>();
  final User? _currentUser = FirebaseAuth.instance.currentUser;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late final TextEditingController companyNameController;
  late final TextEditingController addressController;
  late final TextEditingController countryController;
  late final TextEditingController contactPersonController;
  late final TextEditingController mobileController;

  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // This will now work correctly because the fields exist in the model
    companyNameController = TextEditingController(text: profile.companyName);
    addressController = TextEditingController(text: profile.businessAddress);
    countryController = TextEditingController(text: profile.country);
    contactPersonController = TextEditingController(text: profile.contactPerson);
    mobileController = TextEditingController(text: profile.mobile);
  }

  @override
  void onClose() {
    companyNameController.dispose();
    addressController.dispose();
    countryController.dispose();
    contactPersonController.dispose();
    mobileController.dispose();
    super.onClose();
  }

  Future<void> saveProfile() async {
    // --- CORRECTED VALIDATION LOGIC ---
    // Safely check if the form is valid without the unnecessary '!'
    final form = formKey.currentState;
    if (form == null || !form.validate()) {
      Get.snackbar("Error", "Please fill all required fields.");
      return;
    }
    
    if (_currentUser == null) return;

    isLoading.value = true;
    final Map<String, dynamic> updatedData = {
      'user_name': companyNameController.text,
      'business_address': addressController.text,
      'country': countryController.text,
      'contact_person': contactPersonController.text,
      'user_phone': mobileController.text,
    };

    // The '!' is safe here because we've already checked for null
    await _buyerService.updateBuyerProfile(_currentUser!.uid, updatedData);
    isLoading.value = false;

    Get.back(result: true);
  }
}