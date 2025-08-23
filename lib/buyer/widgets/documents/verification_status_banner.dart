import 'package:flutter/material.dart';
import 'package:cropsureconnect/buyer/models/importer_profile_model.dart';

class VerificationStatusBanner extends StatelessWidget {
  final OverallVerificationStatus status;
  const VerificationStatusBanner({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    String text;
    Color color;
    IconData icon;

    switch (status) {
      case OverallVerificationStatus.verified:
        text = 'Verified Importer';
        color = Colors.green;
        icon = Icons.check_circle;
        break;
      case OverallVerificationStatus.pending:
        text = 'Verification Pending';
        color = Colors.orange;
        icon = Icons.watch_later;
        break;
      case OverallVerificationStatus.rejected:
        text = 'Rejected – Resubmit Documents';
        color = Colors.red;
        icon = Icons.cancel;
        break;
    }

    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Text(text, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
          ),
        ],
      ),
    );
  }
}