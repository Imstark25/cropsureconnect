import 'package:cropsureconnect/buyer/models/importer_profile_model.dart';
import 'package:flutter/material.dart';

class QuickStatsGrid extends StatelessWidget {
  final ImporterProfileModel profile;
  const QuickStatsGrid({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      // CHANGED: Adjusted aspect ratio to give cards more height vs. width.
      // 1.8 was too wide, 1.5 is more balanced for this content.
      childAspectRatio: 1.5,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      children: [
        _buildStatCard(
          icon: Icons.description,
          title: 'Active Contracts',
          value: profile.activeContractsCount.toString(),
          color: Colors.blue,
        ),
        _buildStatCard(
          icon: Icons.pending_actions,
          title: 'Pending Orders',
          value: profile.pendingOrdersCount.toString(),
          color: Colors.orange,
        ),
        _buildStatCard(
          icon: Icons.local_shipping,
          title: 'Past Imports',
          value: profile.pastImportsCount.toString(),
          color: Colors.purple,
        ),
        _buildStatCard(
          icon: Icons.reorder,
          title: 'Repeat Purchase',
          value: '${profile.repeatPurchaseRate.toStringAsFixed(0)}%',
          color: Colors.teal,
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        // ADDED: SingleChildScrollView to prevent overflow within the card
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
