import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/orders_controller.dart';  // ✅ make sure this path is correct

class OrdersScreen extends StatelessWidget {
  OrdersScreen({super.key});

  final OrdersController ordersController = Get.put(OrdersController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Orders")),
      body: Obx(() {
        if (ordersController.orders.isEmpty) {
          return const Center(child: Text("No orders placed yet."));
        }

        return ListView.builder(
          itemCount: ordersController.orders.length,
          itemBuilder: (context, index) {
            final order = ordersController.orders[index];
            return Card(
              margin: const EdgeInsets.all(8),
              child: ListTile(
                title: Text(order.crop.name),
                subtitle: Text(
                  "Quantity: ${order.quantity} tons\nAdvance: ₹${order.advance}",
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              ),
            );
          },
        );
      }),
    );
  }
}
