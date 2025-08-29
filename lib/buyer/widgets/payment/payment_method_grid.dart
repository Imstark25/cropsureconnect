import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cropsureconnect/buyer/controllers/payment_controller.dart';

class PaymentMethodGrid extends StatelessWidget {
  const PaymentMethodGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final PaymentController controller = Get.find<PaymentController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Payment Methods (Importer)',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildPaymentIcon(
              icon: CupertinoIcons.qrcode,
              label: 'UPI',
              onTap: () => controller.showPaymentMethodModal('UPI'),
            ),
            _buildPaymentIcon(
              icon: Icons.account_balance,
              label: 'NetBanking',
              onTap: () => controller.showPaymentMethodModal('NetBanking'),
            ),
            _buildPaymentIcon(
              icon: Icons.credit_card,
              label: 'Cards',
              onTap: () => controller.showPaymentMethodModal('Cards'),
            ),
            _buildPaymentIcon(
              icon: CupertinoIcons.globe,
              label: 'SWIFT',
              onTap: () => controller.showPaymentMethodModal('SWIFT'),
            ),
          ],
        ),
      ],
    );
  }

  // Helper to build a single payment method icon
  Widget _buildPaymentIcon({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Icon(icon, size: 32, color: Colors.black87),
            const SizedBox(height: 8),
            Text(label),
          ],
        ),
      ),
    );
  }
}