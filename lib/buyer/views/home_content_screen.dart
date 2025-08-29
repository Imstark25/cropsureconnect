
// 1. THIS IS THE FIRST FIX: Import the dummy data file.

import 'package:cropsureconnect/buyer/models/importer_profile_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/dummy_data.dart';

class HomeContentScreen extends StatelessWidget {
  const HomeContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // This now works because the object is imported correctly
    final ImporterProfileModel profile = dummyImporterProfile;

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFF8C00), Color(0xFFFF6600)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text('CropsureConnect', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.chat_bubble_outline),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for products...',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildHeader(profile),
            const SizedBox(height: 24),
            _buildInfoCard(
              context,
              icon: Icons.eco,
              title: 'Main Crop of Interest',
              value: profile.mainCropInterest,
              color: Colors.green,
            ),
            const SizedBox(height: 16),
            _buildInfoCard(
              context,
              icon: Icons.history,
              title: 'Last Transaction',
              value: profile.lastTransactionSummary,
              color: Colors.blue,
            ),
            const SizedBox(height: 16),
            _buildInfoCard(
              context,
              icon: Icons.pending_actions,
              title: 'Pending Bookings',
              value: '${profile.pendingBookingsCount} Bookings',
              color: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }

  // 2. THIS IS THE SECOND FIX: Full implementation for the helper methods.

  Widget _buildHeader(ImporterProfileModel profile) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 24,
          backgroundColor: Colors.white,
          child: Icon(Icons.business, color: Color(0xFFFF6600)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            profile.companyName,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Chip(
          avatar: const Icon(Icons.star, color: Colors.white, size: 16),
          label: Text(
            '${profile.trustScore}',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color(0xFFFF6600),
          padding: const EdgeInsets.symmetric(horizontal: 8),
        ),
      ],
    );
  }

  Widget _buildInfoCard(BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.1),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
          ],
        ),
      ),
    );
  }
}