import 'package:cropsureconnect/buyer/controllers/dashboard_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cropsureconnect/auth/controllers/auth_controller.dart';
import 'package:cropsureconnect/buyer/models/importer_profile_model.dart';
import 'package:cropsureconnect/buyer/services/buyer_service.dart';
import 'package:cropsureconnect/buyer/views/edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<ImporterProfileModel>? _profileFuture;
  final BuyerService buyerService = Get.find<BuyerService>();
  final User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  void _loadProfile() {
    if (currentUser != null) {
      setState(() {
        _profileFuture = buyerService.getBuyerProfile(currentUser!.uid);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Company Profile'), elevation: 0),
      body: FutureBuilder<ImporterProfileModel>(
        future: _profileFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (snapshot.hasData) {
            final profile = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Column(
                children: [
                  _buildHeader(profile),
                  const SizedBox(height: 24),
                  _buildSectionCard('Basic Company Information', [
                    _buildInfoRow('Contact Person', profile.contactPerson),
                    _buildInfoRow(
                      'Mobile',
                      profile.mobile,
                      trailing: TextButton(
                        onPressed: () {},
                        child: const Text('OTP Verify'),
                      ),
                    ),
                    _buildInfoRow(
                      'Email',
                      profile.email,
                      trailing: Icon(
                        profile.isEmailVerified
                            ? Icons.verified
                            : Icons.error_outline,
                        color: profile.isEmailVerified
                            ? Colors.green
                            : Colors.grey,
                        size: 18,
                      ),
                    ),
                    _buildInfoRow(
                      'Location',
                      '${profile.city}, ${profile.country}',
                    ),
                    _buildInfoRow('Business Address', profile.businessAddress),
                  ]),
                  const SizedBox(height: 16),
                  _buildSectionCard('Business Registration & Legal', [
                    _buildInfoRow(
                      'Trade License No.',
                      profile.tradeLicenseNumber,
                      isGreyedOut: true,
                    ),
                    _buildInfoRow(
                      'VAT Number',
                      profile.vatNumber,
                      isGreyedOut: true,
                    ),
                  ]),
                  const SizedBox(height: 16),
                  _buildSectionCard('Ratings & Trust Score', [
                    _buildInfoRow(
                      'Trust Level',
                      profile.trustLevel.name.capitalizeFirst!,
                      trailing: Icon(Icons.shield, color: Colors.blue),
                    ),
                    _buildInfoRow(
                      'Farmer Ratings',
                      '${profile.farmerRating}/5.0',
                      trailing: const Icon(Icons.star, color: Colors.amber),
                    ),
                    _buildInfoRow(
                      'Transaction History',
                      profile.transactionHistorySummary,
                    ),
                  ]),
                  const SizedBox(height: 24),
                  _buildActionButtons(profile),
                ],
              ),
            );
          }
          return const Center(child: Text("Profile not found."));
        },
      ),
    );
  }

  // --- HELPER WIDGETS ---
  Widget _buildHeader(ImporterProfileModel profile) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(radius: 28, child: Icon(Icons.business, size: 28)),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    profile.companyName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Chip(
                  label: Text(
                    'Verified Importer',
                    style: TextStyle(
                      color: profile.isVerified ? Colors.green : Colors.orange,
                    ),
                  ),
                  avatar: Icon(
                    profile.isVerified ? Icons.verified : Icons.pending,
                    color: profile.isVerified ? Colors.green : Colors.orange,
                    size: 18,
                  ),
                  backgroundColor: profile.isVerified
                      ? Colors.green.withOpacity(0.1)
                      : Colors.orange.withOpacity(0.1),
                  side: BorderSide.none,
                ),
                const Spacer(),
                Text(
                  'Member since ${profile.memberSinceYear}',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard(String title, List<Widget> children) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 24),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    String label,
    String value, {
    Widget? trailing,
    bool isGreyedOut = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    color: isGreyedOut ? Colors.grey : Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          if (trailing != null) trailing,
        ],
      ),
    );
  }

  Widget _buildActionButtons(ImporterProfileModel profile) {
    final AuthController authController = Get.find<AuthController>();
    final DashboardController dashboardController =
        Get.find<DashboardController>();

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                icon: const Icon(Icons.edit_note),
                label: const Text('Edit Profile'),
                onPressed: () async {
                  final result = await Get.to(
                    () => EditProfileScreen(profile: profile),
                  );
                  if (result == true) {
                    _loadProfile();
                  }
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: FilledButton.icon(
                icon: const Icon(Icons.folder_copy),
                label: const Text('Manage Documents'),
                onPressed: () =>
                    dashboardController.changeTab(3), // 3 = Documents tab
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(onPressed: () {}, child: const Text('Help & Support')),
            TextButton(
              onPressed: authController.logout,
              child: const Text('Logout', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ],
    );
  }
}
