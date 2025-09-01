import 'package:cropsureconnect/auth/views/login_page.dart';
import 'package:cropsureconnect/seller/settings/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cropsureconnect/seller/views/farmer_profile_view.dart';

import '../language/language_selection_view.dart'; // Import the new view

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsController controller = Get.put(SettingsController());

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: Text(
          'settings_title'.tr, // Translated
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          children: [
            _buildProfileCard(),
            const SizedBox(height: 20),
            _buildSettingsGroup(
              title: 'General',
              children: [
                Obx(
                  () => _buildToggleItem(
                    title: 'dark_mode'.tr, // Translated
                    icon: Icons.dark_mode,
                    iconColor: Colors.black,
                    value: controller.isDarkMode.value,
                    onChanged: controller.toggleDarkMode,
                  ),
                ),
              ],
            ),
            _buildSettingsGroup(
              title: 'profile'.tr, // Translated
              children: [
                _buildNavigationItem(
                  title: 'edit_profile'.tr, // Translated
                  icon: Icons.person,
                  iconColor: Colors.orange,
                  onTap: () => Get.to(() => const FarmerProfileView()),
                ),
                _buildNavigationItem(
                  title: 'change_password'.tr, // Translated
                  icon: Icons.lock,
                  iconColor: Colors.blue,
                  onTap: () {},
                ),
              ],
            ),
            _buildSettingsGroup(
              title: 'notifications'.tr, // Translated
              children: [
                Obx(
                  () => _buildToggleItem(
                    title: 'notifications'.tr, // Translated
                    icon: Icons.notifications,
                    iconColor: Colors.green,
                    value: controller.areNotificationsOn.value,
                    onChanged: controller.toggleNotifications,
                  ),
                ),
              ],
            ),
            _buildSettingsGroup(
              title: 'Regional',
              children: [
                _buildNavigationItem(
                  title: 'language'.tr, // Translated
                  icon: Icons.language,
                  iconColor: Colors.purple,
                  onTap: () => Get.to(
                    () => const LanguageSelectionView(),
                  ), // Navigate to new screen
                ),
                _buildNavigationItem(
                  title: 'logout'.tr, // Translated
                  icon: Icons.logout,
                  iconColor: Colors.red,
                  onTap: () {
                    Get.to(() => LoginPage());
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ... (rest of the helper widgets remain the same)
  Widget _buildProfileCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=subash'),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Subash',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'edit_profile'.tr,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
        ],
      ),
    );
  }

  Widget _buildSettingsGroup({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(children: children),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildNavigationItem({
    required String title,
    required IconData icon,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: iconColor.withOpacity(0.1),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(title),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Colors.grey,
        size: 16,
      ),
      onTap: onTap,
    );
  }

  Widget _buildToggleItem({
    required String title,
    required IconData icon,
    required Color iconColor,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: iconColor.withOpacity(0.1),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(title),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: Colors.green,
      ),
    );
  }
}
