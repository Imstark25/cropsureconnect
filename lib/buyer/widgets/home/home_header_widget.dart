import 'package:flutter/material.dart';
import 'package:cropsureconnect/buyer/models/importer_profile_model.dart';

class HomeHeader extends StatelessWidget {
  final ImporterProfileModel profile;
  const HomeHeader({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const CircleAvatar(radius: 28, child: Icon(Icons.business, size: 28)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        profile.companyName,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (profile.isVerified) ...[
                      const SizedBox(width: 4),
                      const Icon(Icons.verified, color: Colors.green, size: 18),
                    ]
                  ],
                ),
                const SizedBox(height: 4),
                _buildTrustChip(profile.trustLevel),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrustChip(TrustLevel level) {
    Color color;
    String label;
    switch (level) {
      case TrustLevel.high:
        color = Colors.green;
        label = 'High';
        break;
      case TrustLevel.medium:
        color = Colors.orange;
        label = 'Medium';
        break;
      case TrustLevel.low:
        color = Colors.red;
        label = 'Low';
        break;
    }
    return Chip(
      avatar: Icon(Icons.shield, color: color, size: 16),
      label: Text('Trust Level: $label', style: TextStyle(color: color, fontWeight: FontWeight.bold)),
      backgroundColor: color.withOpacity(0.1),
      side: BorderSide.none,
      padding: const EdgeInsets.symmetric(horizontal: 8),
    );
  }
}