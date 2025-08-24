import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Ensure all your import paths are correct
import 'package:cropsureconnect/auth/service/auth_service.dart';
import 'package:cropsureconnect/buyer/views/buyer_dashboard_screen.dart';
import 'package:cropsureconnect/seller/onbording/onboarding_view.dart';
import 'package:cropsureconnect/auth/views/login_page.dart';

class AuthController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Controllers for the login/signup text fields
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

  // This is the main method called from the LoginPage
  void login() async {
    isLoading.value = true;
    try {
      // Step 1: Verify email and password with Firebase
      final user = await _authService.signInWithEmail(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      // If login is successful, 'user' will not be null
      if (user != null) {
        // Step 2: Handle the navigation based on the user's role
        await _handleUserNavigation(user.uid);
      }
    } finally {
      isLoading.value = false;
      _clearControllers();
    }
  }

  // This private helper function checks Firestore and navigates
  Future<void> _handleUserNavigation(String uid) async {
    try {
      // Step 3: Check if the user is in the 'Sellers' collection
      DocumentSnapshot sellerDoc = await _db.collection('Sellers').doc(uid).get();
      if (sellerDoc.exists) {
        // User is a seller, navigate to their onboarding view
        Get.offAll(() => const OnboardingView());
        return;
      }

      // Step 4: If not a seller, check the 'Buyers' collection
      DocumentSnapshot buyerDoc = await _db.collection('Buyers').doc(uid).get();
      if (buyerDoc.exists) {
        // User is a buyer, navigate to their dashboard
        Get.offAll(() => const BuyerDashboardScreen());
        return;
      }

      // Step 5: If user is not in either collection, show an error and sign out
      Get.snackbar("Login Error", "Could not find user details for this role.");
      _authService.signOut();
    } catch (e) {
      Get.snackbar("Error", "An error occurred: ${e.toString()}");
      _authService.signOut();
    }
  }

  // --- Other Methods (Signup, Logout, etc.) ---

  void signUp() async {
    isLoading.value = true;
    try {
      final user = await _authService.signUpWithEmail(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      if (user != null) {
        await _authService.addUserDetails(
          user.uid,
          nameController.text.trim(),
          emailController.text.trim(),
          phoneController.text.trim(),
          selectedRole.value,
        );
        // After creating the user, use the same handler to navigate
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