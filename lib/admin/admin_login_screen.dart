// lib/admin/views/admin_login_screen.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cropsureconnect/admin/admin_main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  Future<String?> _checkAdminRole(String uid) async {
    try {
      // ✅ CHANGED: Collection is now 'admin' instead of 'Sellers'
      final docSnapshot = await FirebaseFirestore.instance.collection('admin').doc(uid).get();
      
      // ✅ CHANGED: Field is now 'user_role' instead of 'role'
      if (docSnapshot.exists && docSnapshot.data()?['user_role'] == 'admin') {
        return 'admin';
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<void> _loginAdmin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (userCredential.user != null) {
        final role = await _checkAdminRole(userCredential.user!.uid);

        if (role == 'admin') {
          Get.offAll(() => const AdminMainScreen());
        } else {
          await FirebaseAuth.instance.signOut();
          _errorMessage = 'Access Denied. Not an admin user.';
        }
      }
    } on FirebaseAuthException {
      _errorMessage = 'Invalid email or password.';
    } catch (e) {
      _errorMessage = 'An unexpected error occurred.';
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Your UI build method remains the same
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Login')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Admin Portal', style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 32),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
                  validator: (value) => value!.isEmpty ? 'Please enter email' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password', border: OutlineInputBorder()),
                  obscureText: true,
                  validator: (value) => value!.isEmpty ? 'Please enter password' : null,
                ),
                const SizedBox(height: 24),
                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
                  ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _loginAdmin,
                    child: _isLoading ? const CircularProgressIndicator(color: Colors.white) : const Text('Login'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}