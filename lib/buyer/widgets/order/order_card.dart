import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cropsureconnect/buyer/models/order_model.dart';
import 'order_status_badge.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;
  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(order.id, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                OrderStatusBadge(status: order.status),
              ],
            ),
            const Divider(height: 24),
            _buildInfoRow(
              icon: Icons.eco,
              label: 'Crop',
              value: '${order.cropName} - ${order.quantityTons} tons',
            ),
            const SizedBox(height: 8),
            _buildInfoRow(
              icon: Icons.public,
              label: 'Origin',
              value: '${order.originCountry} (${order.supplier})',
            ),
            const SizedBox(height: 8),
            _buildInfoRow(
              icon: Icons.calendar_today,
              label: order.status == OrderStatus.delivered ? 'Delivered On' : 'Expected Delivery',
              value: DateFormat('dd MMM yyyy').format(order.deliveryDate),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(onPressed: () {}, child: const Text('View Details')),
                const SizedBox(width: 8),
                ElevatedButton(onPressed: () {}, child: const Text('Repeat Order')),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({required IconData icon, required String label, required String value}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: Colors.grey[600]),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              const SizedBox(height: 2),
              Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ],
    );
  }
}