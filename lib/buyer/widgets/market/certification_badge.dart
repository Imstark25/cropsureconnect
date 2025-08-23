

import 'package:flutter/material.dart';

class CertificationBadge extends StatelessWidget {
  final String label;
  const CertificationBadge({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.teal.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.teal.shade100),
      ),
      child: Text(
        label,
        style: const TextStyle(
            color: Colors.teal, fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }
}