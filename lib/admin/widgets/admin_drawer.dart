import 'package:cropsureconnect/admin/admin_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminDrawer extends StatelessWidget {
  final Function(int) onItemSelected;

  const AdminDrawer({super.key, required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: const Text(
              'Admin Panel',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          _buildDrawerItem(
            icon: Icons.dashboard,
            text: 'Dashboard',
            onTap: () => onItemSelected(0),
          ),
          _buildDrawerItem(
            icon: Icons.people,
            text: 'User Management',
            onTap: () => onItemSelected(1),
          ),
          _buildDrawerItem(
            icon: Icons.receipt_long,
            text: 'Transactions',
            onTap: () => onItemSelected(2),
          ),
          const Divider(),
          _buildDrawerItem(
            icon: Icons.settings,
            text: 'Settings',
            onTap: () {}, // Not yet implemented
          ),
          _buildDrawerItem(
            icon: Icons.logout,
            text: 'Logout',
            onTap: () {
              Get.to(() => const AdminLoginScreen());
            }, // Not yet implemented
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
      {required IconData icon,
      required String text,
      required GestureTapCallback onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      onTap: onTap,
    );
  }
}
