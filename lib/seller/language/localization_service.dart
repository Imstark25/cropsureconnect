import 'package:get/get.dart';
import 'package:flutter/material.dart'; // Import material for Locale

class LocalizationService extends Translations {
  // --- THIS IS THE FIX ---
  // fallbackLocale is now a Locale object instead of a String.
  static const fallbackLocale = Locale('en', 'US');

  // Supported languages
  static final langs = [
    'English',
    'தமிழ்',
    'हिन्दी',
  ];

  // Supported locales
  static final locales = [
    const Locale('en', 'US'),
    const Locale('ta', 'IN'),
    const Locale('hi', 'IN'),
  ];

  // Keys and their translations
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      'app_title': 'CropSureConnect',
      'language': 'Language',
      'search_by_location': 'Search By "Location"',
      'top_farmers_title': 'Top Farmers in Your Region',
      'category_title': 'Category',
      'see_all': 'See All',
      'filter': 'Filter',
      'sort': 'Sort',
      'home': 'Home',
      'payment_history': 'Payment History',
      'profile': 'Profile',
      'status': 'Status',
      'settings': 'Settings',
      'settings_title': 'Settings',
      'dark_mode': 'Dark Mode',
      'edit_profile': 'Edit Profile',
      'change_password': 'Change Password',
      'notifications': 'Notifications',
      'logout': 'Logout',
    },
    'ta_IN': {
      'app_title': 'கிராப்சுயர்கனெக்ட்',
      'language': 'மொழி',
      'search_by_location': '"இடம்" மூலம் தேடு',
      'top_farmers_title': 'உங்கள் பகுதியில் சிறந்த விவசாயிகள்',
      'category_title': 'வகை',
      'see_all': 'அனைத்தையும் காட்டு',
      'filter': 'வடிகட்டு',
      'sort': 'வரிசைப்படுத்து',
      'home': 'முகப்பு',
      'payment_history': 'பணப்பரிவர்த்தனை வரலாறு',
      'profile': 'சுயவிவரம்',
      'status': 'நிலை',
      'settings': 'அமைப்புகள்',
      'settings_title': 'அமைப்புகள்',
      'dark_mode': 'இருண்ட பயன்முறை',
      'edit_profile': 'சுயவிவரத்தைத் திருத்து',
      'change_password': 'கடவுச்சொல்லை மாற்று',
      'notifications': 'அறிவிப்புகள்',
      'logout': 'வெளியேறு',
    },
    'hi_IN': {
      'app_title': 'क्रॉपश्योरकनेक्ट',
      'language': 'भाषा',
      'search_by_location': '"स्थान" से खोजें',
      'top_farmers_title': 'आपके क्षेत्र के शीर्ष किसान',
      'category_title': 'श्रेणी',
      'see_all': 'सभी देखें',
      'filter': 'फ़िल्टर',
      'sort': 'क्रमबद्ध करें',
      'home': 'होम',
      'payment_history': 'भुगतान इतिहास',
      'profile': 'प्रोफ़ाइल',
      'status': 'स्थिति',
      'settings': 'सेटिंग्स',
      'settings_title': 'सेटिंग्स',
      'dark_mode': 'डार्क मोड',
      'edit_profile': 'प्रोफ़ाइल संपादित करें',
      'change_password': 'पासवर्ड बदलें',
      'notifications': 'सूचनाएं',
      'logout': 'लॉग आउट',
    },
  };

  void changeLocale(String lang) {
    final locale = _getLocaleFromLanguage(lang);
    Get.updateLocale(locale);
  }

  Locale _getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }
    return Get.locale!;
  }
}