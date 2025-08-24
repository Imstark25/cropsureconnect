
import 'package:cropsureconnect/seller/settings/settings_controller.dart';
import 'package:cropsureconnect/auth/controllers/auth_controller.dart';
import 'package:cropsureconnect/auth/service/auth_service.dart';
import 'package:cropsureconnect/auth/views/userCheckingAuth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'seller/language/localization_service.dart';
import 'seller/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.put(AuthService());
  Get.put(SettingsController());
  Get.put(AuthController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SettingsController settingsController = Get.find();

    return Obx(() => GetMaterialApp(
      title: 'CropSureConnect',
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
      translations: LocalizationService(),
      locale: Get.deviceLocale,
      fallbackLocale: LocalizationService.fallbackLocale,

      // *** UPDATED: Start the app with the OnboardingView ***
      home:  UserCheckingAuth(),
      debugShowCheckedModeBanner: false,
    ));
  }
}
