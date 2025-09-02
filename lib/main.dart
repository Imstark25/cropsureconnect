import 'package:cropsureconnect/admin/admin_checking_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// ✅ FIXED: Make sure these import paths exactly match your file structure
import 'package:cropsureconnect/admin/controllers/admin_controller.dart';
import 'package:cropsureconnect/buyer/services/buyer_service.dart';
import 'package:cropsureconnect/seller/settings/settings_controller.dart';
import 'package:cropsureconnect/auth/controllers/auth_controller.dart';
import 'package:cropsureconnect/auth/service/auth_service.dart';
import 'package:cropsureconnect/auth/views/user_checking_auth.dart';
import 'package:cropsureconnect/seller/language/localization_service.dart';
import 'package:cropsureconnect/seller/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Get.put(AuthService());
  Get.put(SettingsController());
  Get.put(AuthController());
  Get.put(BuyerService());
  Get.put(AdminController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsController settingsController = Get.find();

    return Obx(() => GetMaterialApp(
          title: 'CropSureConnect',

          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: const Color(0xFF388E3C),
            scaffoldBackgroundColor: const Color(0xFFF1F8E9),
            textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF388E3C),
              surface: const Color(0xFFF1F8E9),
              brightness: Brightness.light,
            ),
            appBarTheme: AppBarTheme(
              titleTextStyle: GoogleFonts.lato(
                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            // ✅ FIXED: Changed to CardThemeData
            cardTheme: CardThemeData(
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            useMaterial3: true,
          ),

          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: const Color(0xFF66BB6A),
            scaffoldBackgroundColor: const Color(0xFF121212),
            textTheme: GoogleFonts.latoTextTheme(Theme.of(context)
                .primaryTextTheme
                .apply(bodyColor: Colors.white70, displayColor: Colors.white)),
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF66BB6A),
              surface: const Color(0xFF121212),
              brightness: Brightness.dark,
            ),
            appBarTheme: AppBarTheme(
              titleTextStyle: GoogleFonts.lato(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            // ✅ FIXED: Changed to CardThemeData
            cardTheme: CardThemeData(
              color: const Color(0xFF1F1F1F),
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            useMaterial3: true,
          ),

          themeMode: settingsController.isDarkMode.value
              ? ThemeMode.dark
              : ThemeMode.light,

          translations: LocalizationService(),
          locale: Get.deviceLocale,
          fallbackLocale: const Locale('en', 'US'),

          home: const UserCheckingAuth(),// user page navigation
          // home: const AdminCheckingAuth(), //admin page navigation

          debugShowCheckedModeBanner: false,
        ));
  }
}
