import 'package:flutter/material.dart';

import 'package:cropsureconnect/buyer/models/order_model.dart';
import 'package:cropsureconnect/buyer/widgets/order/order_card.dart';

import '../data/dummy_order_data.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // State for the tonnage filter
  RangeValues _currentRangeValues = const RangeValues(0, 10000); // Default full range

  @override
  void initState() {
    super.initState();
    // UPDATED: Length is now 4 for the new tab
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // NEW: Method to show the filter modal
  void _showFilterModal() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        // Use a StatefulWidget to manage the slider's state within the modal
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Filter by Metric Tons (MT)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  RangeSlider(
                    values: _currentRangeValues,
                    min: 0,
                    max: 10000,
                    divisions: 100,
                    labels: RangeLabels(
                      _currentRangeValues.start.round().toString(),
                      _currentRangeValues.end.round().toString(),
                    ),
                    onChanged: (RangeValues values) {
                      setModalState(() {
                        _currentRangeValues = values;
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        child: const Text('Min: 5-10 MT'),
                        onPressed: () => setModalState(() => _currentRangeValues = const RangeValues(5, 10)),
                      ),
                      ElevatedButton(
                        child: const Text('Max: 50-100 MT'),
                        onPressed: () => setModalState(() => _currentRangeValues = const RangeValues(50, 100)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: const Text('Reset'),
                        onPressed: () {
                          // Reset state inside and outside the modal
                          setModalState(() => _currentRangeValues = const RangeValues(0, 10000));
                          setState(() => _currentRangeValues = const RangeValues(0, 10000));
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        child: const Text('Apply Filter'),
                        onPressed: () {
                          // Apply the filter and close the modal
                          setState(() {}); // This triggers a rebuild of the main screen
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  // UPDATED: This function now applies the tonnage filter first
  Widget _buildOrderList(OrderStatus status) {
    final List<OrderModel> tonnageFiltered = dummyOrders.where((order) {
      return order.quantityTons >= _currentRangeValues.start && order.quantityTons <= _currentRangeValues.end;
    }).toList();

    final List<OrderModel> filteredOrders = tonnageFiltered.where((order) => order.status == status).toList();

    if (filteredOrders.isEmpty) {
      return Center(
        child: Text('No ${status.name} orders found in this range.', style: const TextStyle(color: Colors.grey)),
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
        actions: [
          // NEW: Filter button in the AppBar
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterModal,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true, // Allows tabs to scroll if they don't fit
          tabs: const [
            Tab(text: 'Active'),
            Tab(text: 'Pre-Booked'), // <-- NEW TAB
            Tab(text: 'Completed'),
            Tab(text: 'Cancelled'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildActiveOrdersList(),
          _buildOrderList(OrderStatus.preBooked), // <-- NEW TAB VIEW
          _buildOrderList(OrderStatus.delivered),
          _buildOrderList(OrderStatus.cancelled),
        ],
      ),
    );
  }

  // UPDATED: This helper also applies the tonnage filter
  Widget _buildActiveOrdersList() {
    final List<OrderModel> tonnageFiltered = dummyOrders.where((order) {
      return order.quantityTons >= _currentRangeValues.start && order.quantityTons <= _currentRangeValues.end;
    }).toList();

    final List<OrderModel> activeOrders = tonnageFiltered
        .where((order) => order.status == OrderStatus.pending || order.status == OrderStatus.inTransit)
        .toList();

    if (activeOrders.isEmpty) {
      return const Center(
        child: Text('No active orders found in this range.', style: TextStyle(color: Colors.grey)),
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