import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';



class SettingsController extends GetxController {
  // Observable variables to hold the state of the toggles
  var isDarkMode = false.obs;
  var areNotificationsOn = true.obs;

  // Methods to toggle the values
  void toggleDarkMode(bool value) {
    isDarkMode.value = value;
    // In a real app, you would also change the theme here
    Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
    Get.snackbar(
      'Theme Changed',
      'Dark Mode is now ${value ? "ON" : "OFF"}',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void toggleNotifications(bool value) {
    areNotificationsOn.value = value;
    Get.snackbar(
      'Notifications',
      'Notifications are now ${value ? "ON" : "OFF"}',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}