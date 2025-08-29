import 'package:flutter/material.dart';
import 'package:cropsureconnect/buyer/models/order_model.dart';

class OrderStatusBadge extends StatelessWidget {
  final OrderStatus status;
  const OrderStatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    String text;
    Color color;
    IconData icon;

    switch (status) {
    // THIS IS THE FIX: Added the missing case for preBooked.
      case OrderStatus.preBooked:
        text = 'Pre-Booked';
        color = Colors.purple;
        icon = Icons.bookmark_added;
        break;
      case OrderStatus.pending:
        text = 'Pending';
        color = Colors.orange;
        icon = Icons.pending_actions;
        break;
      case OrderStatus.inTransit:
        text = 'In Transit';
        color = Colors.blue;
        icon = Icons.local_shipping;
        break;
      case OrderStatus.delivered:
        text = 'Delivered';
        color = Colors.green;
        icon = Icons.check_circle;
        break;
      case OrderStatus.cancelled:
        text = 'Cancelled';
        color = Colors.red;
        icon = Icons.cancel;
        break;
    }

    return Chip(
      avatar: Icon(icon, color: color, size: 16),
      label: Text(text),
      labelStyle: TextStyle(color: color, fontWeight: FontWeight.bold),
      backgroundColor: color.withOpacity(0.1),
      side: BorderSide.none,
    );
  }
}