class PaymentDetailsModel {
  final String bookingId;
  final String cropName;
  final String quantitySummary;
  final String importerName;
  final String farmerName;
  final double totalOrderValueINR;
  final double totalOrderValueUSD;
  final double advancePayment;
  final double pendingPayment;
  final double platformFee;
  final double finalReceivable;
  final double escrowBalance;
  final double amountReleased;
  final DateTime nextReleaseDate;

  PaymentDetailsModel({
    required this.bookingId,
    required this.cropName,
    required this.quantitySummary,
    required this.importerName,
    required this.farmerName,
    required this.totalOrderValueINR,
    required this.totalOrderValueUSD,
    required this.advancePayment,
    required this.pendingPayment,
    required this.platformFee,
    required this.finalReceivable,
    required this.escrowBalance,
    required this.amountReleased,
    required this.nextReleaseDate,
  });
}