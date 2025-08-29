import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:cropsureconnect/buyer/controllers/payment_controller.dart';
import 'package:cropsureconnect/buyer/models/payment_details_model.dart';

class PayoutViewWidget extends StatelessWidget {
  final PaymentDetailsModel details;
  const PayoutViewWidget({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    final PaymentController controller = Get.find<PaymentController>();
    final formatCurrency = NumberFormat.currency(locale: 'en_IN', symbol: '₹');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Farmer's View (Payouts)",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildPayoutRow(
                  'Escrow Balance',
                  formatCurrency.format(details.escrowBalance),
                ),
                const Divider(),
                _buildPayoutRow(
                  'Amount Released',
                  formatCurrency.format(details.amountReleased),
                ),
                const Divider(),
                _buildPayoutRow(
                  'Next Release Date',
                  DateFormat('dd MMM yyyy').format(details.nextReleaseDate),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.arrow_downward),
                    label: const Text('Withdraw to Bank'),
                    onPressed: controller.simulateWithdrawal,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      textStyle: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Helper to build a row in the payout card
  Widget _buildPayoutRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(color: Colors.grey[700])),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}