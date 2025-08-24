import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Ensure your import paths are correct
import 'package:cropsureconnect/buyer/views/buyer_dashboard_screen.dart';
import 'package:cropsureconnect/seller/onbording/onboarding_view.dart';
import 'package:cropsureconnect/auth/views/login_page.dart';

class UserCheckingAuth extends StatelessWidget {
  const UserCheckingAuth({super.key});

  // This helper function checks Firestore to find the user's role
  Future<String?> _checkUserRole(String uid) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;

    // Check Sellers collection first
    DocumentSnapshot sellerDoc = await db.collection('Sellers').doc(uid).get();
    if (sellerDoc.exists) {
      return 'seller';
    }

    // If not a seller, check the Buyers collection
    DocumentSnapshot buyerDoc = await db.collection('Buyers').doc(uid).get();
    if (buyerDoc.exists) {
      return 'buyer';
    }

    // Return null if the user has an auth record but no data record
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // This stream listens for login/logout state changes
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, authSnapshot) {
        if (authSnapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // If the stream has a user object, it means the user is logged in
        if (authSnapshot.hasData) {
          // Now, find out the user's role to navigate correctly
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
                  return OnboardingView();
                } else if (role == 'buyer') {
                  return BuyerDashboardScreen();
                }
              }

              // If role is null (user exists in Auth but not Firestore),
              // show the login page. This is a safe fallback.
              return LoginPage();
            },
          );
        }

        // If the stream has no user, they are logged out. Show the login page.
        return LoginPage();
      },
    );
  }
}
