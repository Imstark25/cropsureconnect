import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Ensure your import paths are correct for your project structure
import 'package:cropsureconnect/admin/admin_main.dart';
import 'package:cropsureconnect/buyer/views/buyer_dashboard_screen.dart';
import 'package:cropsureconnect/seller/views/seller_dashboard_screen.dart';
import 'package:cropsureconnect/auth/views/auth_screen.dart';

class UserCheckingAuth extends StatelessWidget {
  const UserCheckingAuth({super.key});

  // ✅ UPDATED: This function now prioritizes the 'admin' role check.
  Future<String?> _checkUserRole(String uid) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;

    // --- Check the Sellers Collection First ---
    DocumentSnapshot sellerDoc = await db.collection('Sellers').doc(uid).get();
    if (sellerDoc.exists && sellerDoc.data() != null) {
      final data = sellerDoc.data() as Map<String, dynamic>;
      // **PRIORITY CHECK**: If the user has a 'role' field and it's 'admin',
      // we immediately return 'admin' and stop checking.
      if (data['role'] == 'admin') {
        return 'admin';
      }
      // Otherwise, they are a regular seller.
      return 'seller';
    }

    // --- If not a seller, check the Buyers Collection ---
    DocumentSnapshot buyerDoc = await db.collection('Buyers').doc(uid).get();
    if (buyerDoc.exists && buyerDoc.data() != null) {
      final data = buyerDoc.data() as Map<String, dynamic>;
      // **PRIORITY CHECK**: We do the same check here.
      if (data['role'] == 'admin') {
        return 'admin';
      }
      // Otherwise, they are a regular buyer.
      return 'buyer';
    }

    // If the user's UID is not found in either collection, return null.
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, authSnapshot) {
        if (authSnapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (authSnapshot.hasData) {
          return FutureBuilder<String?>(
            future: _checkUserRole(authSnapshot.data!.uid),
            builder: (context, roleSnapshot) {
              if (roleSnapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(body: Center(child: CircularProgressIndicator()));
              }

              if (roleSnapshot.hasData) {
                final String? role = roleSnapshot.data;
                // This logic will now correctly route the admin first
                if (role == 'admin') {
                  return const AdminMainScreen();
                } else if (role == 'seller') {
                  return const SellerDashboardScreen();
                } else if (role == 'buyer') {
                  return const BuyerDashboardScreen();
                }
              }
              // If role is not found, send to the auth screen to be safe
              return const AuthScreen();
            },
          );
        }
        // If logged out, show the auth screen
        return const AuthScreen();
      },
    );
  }
}