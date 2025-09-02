import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/admin_dashboard_screen.dart';
import 'screens/user_management_screen.dart';
import 'screens/transactions_screen.dart';
import 'widgets/admin_drawer.dart';

class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen({super.key});

  @override
  State<AdminMainScreen> createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _screens = <Widget>[
    AdminDashboardScreen(),
    UserManagementScreen(),
    TransactionsScreen(),
  ];

  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context); // Close the drawer
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CropSureConnect Admin'),
        titleTextStyle: GoogleFonts.lato(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      drawer: AdminDrawer(onItemSelected: _onItemSelected),
      body: _screens[_selectedIndex],
    );
  }
}
