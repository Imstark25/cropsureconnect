import 'package:flutter/material.dart';
import 'package:cropsureconnect/buyer/models/importer_profile_model.dart';

class ProfileHeader extends StatelessWidget {
  final ImporterProfileModel profile;
  const ProfileHeader({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const CircleAvatar(radius: 32, child: Icon(Icons.business, size: 32)),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                profile.companyName,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Chip(
              label: const Text('Verified Importer', style: TextStyle(color: Colors.green)),
              avatar: const Icon(Icons.verified, color: Colors.green, size: 18),
              backgroundColor: Colors.green.withOpacity(0.1),
              side: BorderSide.none,
            ),
            const Spacer(),
            Text('Member since ${profile.memberSinceYear}', style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ],
    );
  }
}