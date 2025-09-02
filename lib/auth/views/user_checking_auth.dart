import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Ensure your import paths are correct for your project structure
import 'package:cropsureconnect/buyer/views/buyer_dashboard_screen.dart';
import 'package:cropsureconnect/seller/views/seller_dashboard_screen.dart';
import 'package:cropsureconnect/auth/views/auth_screen.dart';

class UserCheckingAuth extends StatelessWidget {
  const UserCheckingAuth({super.key});

  Future<String?> _checkUserRole(String uid) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;

    // --- Check the Sellers Collection ---
    DocumentSnapshot sellerDoc = await db.collection('Sellers').doc(uid).get();
    if (sellerDoc.exists) {
      return 'seller';
    }

    // --- If not a seller, check the Buyers Collection ---
    DocumentSnapshot buyerDoc = await db.collection('Buyers').doc(uid).get();
    if (buyerDoc.exists) {
      return 'buyer';
    }

    // If the UID is not found in either collection, return null.
    return null;
  }

  // ✅ NEW METHOD: Handles signing out and showing a SnackBar.
  void _handleUserNotFound(BuildContext context) {
    // We use a post-frame callback to ensure the build is complete before
    // showing a SnackBar or triggering a state change.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // First, sign the user out from Firebase Authentication.
      FirebaseAuth.instance.signOut();

      // Then, show a SnackBar to inform the user what happened.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('User record not found. Please sign up or contact support.'),
          backgroundColor: Colors.redAccent,
        ),
      );
      // The StreamBuilder will automatically detect the signOut and navigate to AuthScreen.
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, authSnapshot) {
        // Show a loading indicator while checking auth state.
        if (authSnapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }

        // If the user is logged in, check their role.
        if (authSnapshot.hasData) {
          return FutureBuilder<String?>(
            future: _checkUserRole(authSnapshot.data!.uid),
            builder: (context, roleSnapshot) {
              // Show a loading indicator while fetching the role.
              if (roleSnapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                    body: Center(child: CircularProgressIndicator()));
              }

              // ✅ UPDATED: Check if the role data exists and is not null.
              if (roleSnapshot.hasData && roleSnapshot.data != null) {
                final String role = roleSnapshot.data!;
                if (role == 'seller') {
                  return const SellerDashboardScreen();
                } else if (role == 'buyer') {
                  return const BuyerDashboardScreen();
                }
              }

              // --- ROLE NOT FOUND LOGIC ---
              // If we reach here, it means the Future is complete but the role is null.
              // This indicates the user exists in Firebase Auth but not in our database.
              _handleUserNotFound(context);

              // Return a loading UI while the sign-out and navigation process happens.
              return const Scaffold(
                  body: Center(child: CircularProgressIndicator()));
            },
          );
        }
        // If the user is logged out, show the auth screen.
        return const AuthScreen();
      },
    );
  }
}
