import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Ensure your import paths are correct for your project
import 'package:cropsureconnect/buyer/views/buyer_dashboard_screen.dart';
import 'package:cropsureconnect/seller/views/home_page.dart';
import 'package:cropsureconnect/auth/views/login_page.dart';

class UserCheckingAuth extends StatelessWidget {
  const UserCheckingAuth({super.key});

  // A helper function to check both collections and return the role as a string
  Future<String?> _checkUserRole(String uid) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;

    // Check Sellers first
    DocumentSnapshot sellerDoc = await db.collection('Sellers').doc(uid).get();
    if (sellerDoc.exists) {
      return 'seller';
    }

    // Then check Buyers
    DocumentSnapshot buyerDoc = await db.collection('Buyers').doc(uid).get();
    if (buyerDoc.exists) {
      return 'buyer';
    }

    return null; // User not found in either collection
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, authSnapshot) {
        if (authSnapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (authSnapshot.hasData) {
          // Use a FutureBuilder to call our new role-checking function
          return FutureBuilder<String?>(
            future: _checkUserRole(authSnapshot.data!.uid),
            builder: (context, roleSnapshot) {
              if (roleSnapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }

              if (roleSnapshot.hasData) {
                final String? role = roleSnapshot.data;
                if (role == 'seller') {
                  return SellerHomePage();
                } else if (role == 'buyer') {
                  return BuyerDashboardScreen();
                }
              }

              // If role is null or any other issue, send to login
              return LoginPage();
            },
          );
        }

        // If not authenticated, send to login
        return LoginPage();
      },
    );
  }
}
