import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Ensure your import paths are correct for your project
import 'package:cropsureconnect/auth/service/auth_service.dart';
import 'package:cropsureconnect/buyer/views/buyer_dashboard_screen.dart';
import 'package:cropsureconnect/seller/views/home_page.dart';
import 'package:cropsureconnect/auth/views/login_page.dart';

class AuthController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  final RxBool isLoading = false.obs;
  final RxString selectedRole = 'Buyer'.obs;
  final List<String> roles = ['Buyer', 'Seller'];

  void setSelectedRole(String role) {
    selectedRole.value = role;
  }

  // Centralized navigation handler that checks both collections
  Future<void> _handleUserNavigation(String uid) async {
    try {
      // Step 1: Check if the user is in the 'Sellers' collection
      DocumentSnapshot sellerDoc = await _db.collection('Sellers').doc(uid).get();
      if (sellerDoc.exists) {
        Get.offAll(() => SellerHomePage());
        return; // Exit after finding the role
      }

      // Step 2: If not a seller, check the 'Buyers' collection
      DocumentSnapshot buyerDoc = await _db.collection('Buyers').doc(uid).get();
      if (buyerDoc.exists) {
        Get.offAll(() => BuyerDashboardScreen());
        return; // Exit after finding the role
      }

      // Step 3: If user exists in Auth but not in any role collection
      Get.snackbar("Login Error", "Could not find user details.");
      _authService.signOut();

    } catch (e) {
      Get.snackbar("Error", "An error occurred: ${e.toString()}");
      _authService.signOut();
    }
  }

  void login() async {
    isLoading.value = true;
    try {
      final user = await _authService.signInWithEmail(
          emailController.text.trim(), passwordController.text.trim());
      if (user != null) {
        await _handleUserNavigation(user.uid);
      }
    } finally {
      isLoading.value = false;
    }
  }

  void signUp() async {
    isLoading.value = true;
    try {
      final user = await _authService.signUpWithEmail(
          emailController.text.trim(), passwordController.text.trim());
      if (user != null) {
        await _authService.addUserDetails(
          user.uid,
          nameController.text.trim(),
          emailController.text.trim(),
          phoneController.text.trim(),
          selectedRole.value,
        );
        await _handleUserNavigation(user.uid);
      }
    } finally {
      isLoading.value = false;
      _clearControllers();
    }
  }

  void logout() async {
    await _authService.signOut();
    Get.offAll(() => LoginPage());
  }

  void _clearControllers() {
    emailController.clear();
    passwordController.clear();
    nameController.clear();
    phoneController.clear();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}