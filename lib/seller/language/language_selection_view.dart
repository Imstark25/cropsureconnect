import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'localization_service.dart';


class LanguageSelectionView extends StatelessWidget {
  const LanguageSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('language'.tr), // Uses translated string
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(LocalizationService.langs[index]),
            onTap: () {
              // Call the changeLocale method from the service
              LocalizationService().changeLocale(LocalizationService.langs[index]);
              Get.back(); // Go back to the previous screen
            },
          );
        },
        separatorBuilder: (context, index) => const Divider(),
        itemCount: LocalizationService.langs.length,
      ),
    );
  }
}