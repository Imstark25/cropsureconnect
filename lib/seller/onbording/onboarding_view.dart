import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cropsureconnect/seller/views/home_view.dart';
import 'dart:ui'; // Needed for the backdrop filter

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/onboarding.jpeg'), // Using the landscape image
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 2. Dark Overlay for better text visibility
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5), // Slightly darker overlay
            ),
          ),

          // 3. UI Elements
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
                children: [
                  // App Logo (you can replace this with your actual logo)
                  const Icon(
                    Icons.agriculture,
                    color: Colors.white,
                    size: 80,
                  ),
                  const SizedBox(height: 30),

                  // Main Title
                  Text(
                    "Welcome to CropSureConnect".tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                        shadows: [
                          Shadow(blurRadius: 10, color: Colors.black87)
                        ]
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Subtitle
                  Text(
                    "Your direct link to global markets.".tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                        shadows: [
                          Shadow(blurRadius: 8, color: Colors.black87)
                        ]
                    ),
                  ),

                  const SizedBox(height: 80),

                  // Start Export Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.off(() => const HomeView());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade600,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 5,
                      ),
                      child: Text(
                        'start_export'.tr,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}