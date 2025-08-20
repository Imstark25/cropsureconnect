import 'package:cropsureconnect/payment_history_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cropsureconnect/payment_history_controller.dart';

import 'package:intl/intl.dart';

class PaymentHistoryView extends StatelessWidget {
  const PaymentHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final PaymentHistoryController controller = Get.put(PaymentHistoryController());

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text('Payments', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return Column(
          children: [
            _buildHeader(controller),
            const SizedBox(height: 24),
            _buildTransactionList(controller),
          ],
        );
      }),
    );
  }

  // Header section with balance and Send Money button
  Widget _buildHeader(PaymentHistoryController controller) {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 15,
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'TOTAL BALANCE',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
          const SizedBox(height: 8),
          Obx(() => Text(
            '₹${NumberFormat('#,##,##0.00').format(controller.totalBalance.value)}',
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          )),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text('Send Money', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  // Transaction list section
  Widget _buildTransactionList(PaymentHistoryController controller) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Transactions',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('See all', style: TextStyle(color: Colors.green)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.separated(
                itemCount: controller.transactions.length,
                separatorBuilder: (context, index) => const Divider(height: 1, indent: 68),
                itemBuilder: (context, index) {
                  final txn = controller.transactions[index];
                  return _buildTransactionTile(txn);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // A single transaction list tile
  Widget _buildTransactionTile(PaymentTransaction txn) {
    final Color amountColor = txn.isCredit ? Colors.green : Colors.black87;
    final String amountPrefix = txn.isCredit ? '+' : '-';

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8),
      leading: CircleAvatar(
        radius: 25,
        backgroundImage: NetworkImage(txn.partyImageUrl),
      ),
      title: Text(
        txn.partyName,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        DateFormat('dd-MM-yyyy hh:mm a').format(txn.date),
        style: const TextStyle(color: Colors.grey),
      ),
      trailing: Text(
        '$amountPrefix ₹${NumberFormat('#,##0.00').format(txn.amount)}',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: amountColor,
          fontSize: 16,
        ),
      ),
    );
  }
}