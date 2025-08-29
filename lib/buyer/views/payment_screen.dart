import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/payment_controller.dart';
import '../models/payment_details_model.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PaymentController controller = Get.put(PaymentController());

    final paymentDetails = PaymentDetailsModel(
      bookingId: '#BK-2025-0078',
      cropName: 'Turmeric',
      quantitySummary: '10 MT',
      importerName: 'Al Dahra Agri. Co.',
      farmerName: 'Erode Farmers FPO',
      totalOrderValueINR: 1200000,
      totalOrderValueUSD: 14400,
      advancePayment: 360000,
      pendingPayment: 840000,
      platformFee: 12000,
      finalReceivable: 1188000,
      escrowBalance: 840000,
      amountReleased: 360000,
      nextReleaseDate: DateTime.now().add(const Duration(days: 15)),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        title: const Text('Payment Details'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 1,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: FilledButton.tonal(
              onPressed: () => _showPaymentOptionsModal(context, controller),
              child: const Text('Pay Now'),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(paymentDetails),
            const SizedBox(height: 24),
            _buildPaymentSummaryCard(paymentDetails),
            const SizedBox(height: 24),
            _buildLiveCurrencyConverter(paymentDetails),
            const SizedBox(height: 24),
            _buildFarmerPayoutView(paymentDetails, controller),
            const SizedBox(height: 24),
            _buildDownloadOptions(),
          ],
        ),
      ),
    );
  }

  // --- FULL IMPLEMENTATION OF ALL HELPER METHODS ---

  void _showPaymentOptionsModal(BuildContext context, PaymentController controller) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            const Center(
              child: Text(
                'Choose a Payment Method',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(),
            _buildPaymentOptionTile(
              icon: Icons.g_mobiledata,
              title: 'GPay / UPI',
              subtitle: 'For payments within India',
              onTap: () => controller.showPaymentMethodModal('UPI'),
            ),
            _buildPaymentOptionTile(
              icon: Icons.account_balance,
              title: 'Net Banking',
              subtitle: 'Indian & International Banks',
              onTap: () => controller.showPaymentMethodModal('Net Banking'),
            ),
            _buildPaymentOptionTile(
              icon: Icons.credit_card,
              title: 'Credit/Debit Cards',
              subtitle: 'Visa, Mastercard, Amex',
              onTap: () => controller.showPaymentMethodModal('Cards'),
            ),
            _buildPaymentOptionTile(
              icon: CupertinoIcons.globe,
              title: 'International Wire (SWIFT)',
              subtitle: 'For international payments',
              onTap: () => controller.showPaymentMethodModal('SWIFT'),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildHeader(PaymentDetailsModel details) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'CONTRACT ID: ${details.bookingId}',
              style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '${details.quantitySummary} ${details.cropName}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 20),
            Row(
              children: [
                const Icon(Icons.business, color: Colors.blue, size: 20),
                const SizedBox(width: 8),
                Text(details.importerName, style: const TextStyle(color: Colors.black54)),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(Icons.swap_horiz, color: Colors.grey, size: 16),
                ),
                const Icon(Icons.eco, color: Colors.green, size: 20),
                const SizedBox(width: 8),
                Text(details.farmerName, style: const TextStyle(color: Colors.black54)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentSummaryCard(PaymentDetailsModel details) {
    final formatCurrency = NumberFormat.currency(locale: 'en_IN', symbol: '₹');
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Payment Summary", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _buildSummaryRow('Total Order Value', formatCurrency.format(details.totalOrderValueINR)),
            _buildSummaryRow('Advance Payment (Escrow)', formatCurrency.format(details.advancePayment)),
            _buildSummaryRow('Pending Payment', formatCurrency.format(details.pendingPayment)),
            _buildSummaryRow('Platform Fee', formatCurrency.format(details.platformFee)),
            const Divider(height: 20),
            _buildSummaryRow('Final Receivable (Farmer)', formatCurrency.format(details.finalReceivable), isBold: true),
          ],
        ),
      ),
    );
  }

  Widget _buildLiveCurrencyConverter(PaymentDetailsModel details) {
    const double inrToUsdRate = 0.012;
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Live Currency Converter", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildCurrencyDisplay('INR', NumberFormat.currency(locale: 'en_IN', symbol: '₹').format(details.totalOrderValueINR)),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Icon(CupertinoIcons.arrow_right_arrow_left, color: Colors.grey),
                ),
                _buildCurrencyDisplay('USD', NumberFormat.currency(locale: 'en_US', symbol: '\$').format(details.totalOrderValueINR * inrToUsdRate)),
              ],
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                'As of ${DateFormat('dd MMM yyyy, hh:mm a').format(DateTime.now())} (IST)',
                style: const TextStyle(color: Colors.grey, fontSize: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFarmerPayoutView(PaymentDetailsModel details, PaymentController controller) {
    final formatCurrency = NumberFormat.currency(locale: 'en_IN', symbol: '₹');
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Farmer's View (Payouts)", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _buildSummaryRow('Escrow Balance', formatCurrency.format(details.escrowBalance)),
            _buildSummaryRow('Amount Released', formatCurrency.format(details.amountReleased)),
            _buildSummaryRow('Next Release Date', DateFormat('dd MMM yyyy').format(details.nextReleaseDate)),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.arrow_downward),
                label: const Text('Withdraw to Bank'),
                onPressed: controller.simulateWithdrawal,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDownloadOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Download Options", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildDownloadButton(icon: CupertinoIcons.doc_text_fill, label: 'Invoice'),
            _buildDownloadButton(icon: CupertinoIcons.doc_on_doc_fill, label: 'Contract'),
            _buildDownloadButton(icon: Icons.workspace_premium, label: 'Certificate'),
          ],
        ),
      ],
    );
  }

  Widget _buildSummaryRow(String title, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(color: Colors.grey[700])),
          Text(
            value,
            style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.w500, fontSize: isBold ? 16 : 14),
          ),
        ],
      ),
    );
  }

  Widget _buildDownloadButton({required IconData icon, required String label}) {
    return Column(
      children: [
        IconButton.filledTonal(onPressed: () {}, icon: Icon(icon)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildPaymentOptionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isEnabled = true,
  }) {
    return ListTile(
      leading: Icon(icon, color: isEnabled ? Get.theme.primaryColor : Colors.grey),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: isEnabled ? Colors.black87 : Colors.grey)),
      subtitle: Text(subtitle, style: TextStyle(color: isEnabled ? Colors.grey[600] : Colors.grey)),
      onTap: isEnabled ? onTap : null,
      trailing: isEnabled ? const Icon(Icons.arrow_forward_ios, size: 16) : null,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  Widget _buildCurrencyDisplay(String code, String amount) {
    return Column(
      children: [
        Text(code, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
        Text(amount, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }
}