import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Import the controller that was missing


// Import all the screens for the tabs
import '../controllers/dashboard_controller.dart';
import 'home_content_screen.dart';
import 'market_screen.dart';
import 'orders_screen.dart';
import 'payment_screen.dart';
import 'profile_screen.dart';

// For better state management with GetX, this can be a StatelessWidget
class BuyerDashboardScreen extends StatelessWidget {
  const BuyerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // THIS IS THE FIX:
    // We create and register the DashboardController here.
    // Get.put() ensures it's available for child screens like ProfileScreen.
    final DashboardController controller = Get.put(DashboardController());

    // This list holds all the screens for the bottom navigation bar.
    final List<Widget> screens = [
      const HomeContentScreen(),
      const MarketScreen(),
      const OrdersScreen(),
      const PaymentScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      // The Obx widget listens for changes in controller.tabIndex
      // and automatically rebuilds the body with the correct screen.
      body: Obx(() => screens[controller.tabIndex.value]),

      bottomNavigationBar: Obx(() => BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store_outlined),
            activeIcon: Icon(Icons.store),
            label: 'Market',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description_outlined),
            activeIcon: Icon(Icons.description),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment_outlined),
            activeIcon: Icon(Icons.payment),
            label: 'Payment',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        // The state is now managed by the controller
        currentIndex: controller.tabIndex.value,
        onTap: controller.changeTab,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFFFF6600), // Alibaba Orange
        unselectedItemColor: Colors.grey[600],
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
      )),
    );
  }
}