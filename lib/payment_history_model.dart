enum TransactionStatus { completed, pending, failed }

class PaymentTransaction {
  final String id;
  final String partyName; // e.g., 'Salem Farmers Co.' or 'Subash'
  final String partyImageUrl;
  final String description;
  final double amount;
  final DateTime date;
  final TransactionStatus status;
  final bool isCredit; // True if money was received, false if sent

  PaymentTransaction({
    required this.id,
    required this.partyName,
    required this.partyImageUrl,
    required this.description,
    required this.amount,
    required this.date,
    required this.status,
    required this.isCredit,
  });
}