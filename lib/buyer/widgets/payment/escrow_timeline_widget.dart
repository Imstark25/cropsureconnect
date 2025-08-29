

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EscrowTimelineWidget extends StatelessWidget {
  const EscrowTimelineWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Escrow Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.account_balance, color: Colors.blue, size: 28),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text('Secured by RBI Regulated Escrow Partner'),
                ),
                const Icon(Icons.verified_user, color: Colors.green),
              ],
            ),
            const Divider(height: 24),
            _buildTimelineStep(
              icon: Icons.lock,
              title: 'Advance Locked',
              subtitle: 'Payment secured in escrow.',
              color: Colors.green,
              isActive: true,
            ),
            _buildTimelineConnector(),
            _buildTimelineStep(
              icon: Icons.local_shipping_outlined,
              title: 'Shipment in Progress',
              subtitle: 'Awaiting harvest/shipment proof.',
              color: Colors.grey,
              isActive: false,
            ),
            _buildTimelineConnector(),
            _buildTimelineStep(
              icon: Icons.lock_open_outlined,
              title: 'Payment Released',
              subtitle: 'Funds will be released upon confirmation.',
              color: Colors.grey,
              isActive: false,
            ),
          ],
        ),
      ),
    );
  }

  // Helper to build a single step in the timeline
  Widget _buildTimelineStep({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required bool isActive,
  }) {
    return Row(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: isActive ? color : Colors.grey[300],
          child: Icon(icon, color: isActive ? Colors.white : Colors.grey, size: 18),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isActive ? Colors.black87 : Colors.grey,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }

  // Helper to build the vertical line connecting the steps
  Widget _buildTimelineConnector() {
    return Container(
      height: 20,
      width: 2,
      margin: const EdgeInsets.only(left: 15, top: 4, bottom: 4),
      color: Colors.grey[300],
    );
  }
}