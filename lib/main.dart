import 'package:cropsureconnect/settings/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cropsureconnect/home_view.dart';


import 'language/localization_service.dart'; // Import the service

void main() {
  Get.put(SettingsController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsController settingsController = Get.find();

    return Obx(() => GetMaterialApp(
      title: 'CropSureConnect',
      // --- THEME DATA ---
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color(0xFFF5F5F0),
        fontFamily: 'Inter',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color(0xFF121212),
        fontFamily: 'Inter',
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1F1F1F),
          foregroundColor: Colors.white,
        ),
        cardColor: const Color(0xFF1F1F1F),
      ),
      themeMode: settingsController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,

      // --- LOCALIZATION SETTINGS ---
      translations: LocalizationService(), // Your translations
      locale: Get.deviceLocale, // Default language
      fallbackLocale: LocalizationService.fallbackLocale, // Fallback language

      home: const HomeView(),
      debugShowCheckedModeBanner: false,
    ));
  }
}