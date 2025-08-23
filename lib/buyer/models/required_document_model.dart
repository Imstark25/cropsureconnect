enum DocumentUploadStatus { verified, pendingReview, rejected, notUploaded, expired }

class RequiredDocumentModel {
  final String name;
  final DocumentUploadStatus status;
  final DateTime? expiryDate;

  RequiredDocumentModel({
    required this.name,
    required this.status,
    this.expiryDate,
  });
}