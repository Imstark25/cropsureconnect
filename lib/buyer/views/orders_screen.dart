import 'package:cropsureconnect/buyer/models/dummy_data.dart';
import 'package:cropsureconnect/buyer/widgets/order/order_card.dart';
import 'package:flutter/material.dart';
import 'package:cropsureconnect/buyer/models/order_model.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Helper function to build the list of orders for a specific tab
  Widget _buildOrderList(OrderStatus status) {
    final List<OrderModel> filteredOrders = dummyOrders
        .where((order) => order.status == status)
        .toList();

    if (filteredOrders.isEmpty) {
      return Center(
        child: Text(
          'No ${status.name} orders found.',
          style: const TextStyle(color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      itemCount: filteredOrders.length,
      itemBuilder: (context, index) {
        return OrderCard(order: filteredOrders[index]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders / Contracts'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Active'),
            Tab(text: 'Completed'),
            Tab(text: 'Cancelled'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Active Tab (Pending + InTransit)
          _buildActiveOrdersList(),

          // Completed Tab
          _buildOrderList(OrderStatus.delivered),

          // Cancelled Tab
          _buildOrderList(OrderStatus.cancelled),
        ],
      ),
    );
  }

  // Special helper for "Active" tab which combines two statuses
  Widget _buildActiveOrdersList() {
    final List<OrderModel> activeOrders = dummyOrders
        .where(
          (order) =>
              order.status == OrderStatus.pending ||
              order.status == OrderStatus.inTransit,
        )
        .toList();

    if (activeOrders.isEmpty) {
      return const Center(
        child: Text(
          'No active orders found.',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      itemCount: activeOrders.length,
      itemBuilder: (context, index) {
        return OrderCard(order: activeOrders[index]);
      },
    );
  }
}
