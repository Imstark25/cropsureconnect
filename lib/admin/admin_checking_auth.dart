// lib/admin/admin_checking_auth.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cropsureconnect/admin/admin_login_screen.dart';
import 'package:cropsureconnect/admin/admin_main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminCheckingAuth extends StatelessWidget {
  const AdminCheckingAuth({super.key});

  Future<String> _checkCurrentUserRole() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return 'logged_out';
    }

    try {
      // ✅ CHANGED: Collection is now 'admin' instead of 'Sellers'
      final docSnapshot = await FirebaseFirestore.instance
          .collection('admin')
          .doc(user.uid)
          .get();

      // ✅ CHANGED: Field is now 'user_role' instead of 'role'
      if (docSnapshot.exists && docSnapshot.data()?['user_role'] == 'admin') {
        return 'admin';
      } else {
        await FirebaseAuth.instance.signOut();
        return 'not_admin';
      }
    } catch (e) {
      await FirebaseAuth.instance.signOut();
      return 'error';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _checkCurrentUserRole(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasData && snapshot.data == 'admin') {
          return const AdminMainScreen();
        } else {
          return const AdminLoginScreen();
        }
      },
    );
  }
}
