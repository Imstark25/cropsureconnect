
import 'package:cropsureconnect/buyer/models/required_document_model.dart';
import 'package:flutter/material.dart';

class VerificationProgressIndicator extends StatelessWidget {
  final List<RequiredDocumentModel> documents;
  const VerificationProgressIndicator({super.key, required this.documents});

  @override
  Widget build(BuildContext context) {
    final uploadedCount = documents.where((d) => d.status == DocumentUploadStatus.verified).length;
    final totalCount = documents.length;
    final progress = totalCount > 0 ? uploadedCount / totalCount : 0.0;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Verification Progress: ${progress * 100}% Complete',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              borderRadius: BorderRadius.circular(5),
            ),
            const SizedBox(height: 4),
            Text('$uploadedCount of $totalCount documents verified.', style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}