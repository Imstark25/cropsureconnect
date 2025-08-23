
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cropsureconnect/buyer/models/required_document_model.dart';

class DocumentCard extends StatelessWidget {
  final RequiredDocumentModel document;
  const DocumentCard({super.key, required this.document});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.folder_zip_outlined, color: Colors.grey),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(document.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildStatusChip(document.status),
            if (document.expiryDate != null) ...[
              const SizedBox(height: 8),
              _buildExpiryInfo(document.expiryDate!),
            ],
            const Divider(height: 24),
            _buildActionButtons(document.status),
          ],
        ),
      ),
    );
  }
  
  Widget _buildStatusChip(DocumentUploadStatus status) {
    // Logic to determine color and text based on status
    // ... (Similar to OrderStatusBadge)
    return const Chip(label: Text('Status Placeholder')); // Placeholder
  }

  Widget _buildExpiryInfo(DateTime date) {
    final bool isNearExpiry = date.difference(DateTime.now()).inDays < 30;
    return Row(
      children: [
        if (isNearExpiry)
          const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 16),
        const SizedBox(width: 4),
        Text(
          'Expires: ${DateFormat('dd MMM yyyy').format(date)}',
          style: TextStyle(color: isNearExpiry ? Colors.orange : Colors.grey),
        ),
      ],
    );
  }

  Widget _buildActionButtons(DocumentUploadStatus status) {
    if (status == DocumentUploadStatus.notUploaded || status == DocumentUploadStatus.rejected) {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          icon: const Icon(Icons.upload_file),
          label: Text(status == DocumentUploadStatus.rejected ? 'Re-upload Now' : 'Upload Now'),
          onPressed: () {},
        ),
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(onPressed: () {}, child: const Text('View')),
          const SizedBox(width: 8),
          TextButton(onPressed: () {}, child: const Text('Replace')),
        ],
      );
    }
  }
}