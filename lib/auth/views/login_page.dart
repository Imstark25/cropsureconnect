// lib/auth/views/login_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/auth_controller.dart';
import 'signup_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Find the controller, or initialize if not found
    final AuthController authController = Get.put(AuthController());
    final screenWidth = MediaQuery.of(context).size.width;
    final formWidth = screenWidth > 600 ? 400.0 : screenWidth * 0.9;

    return Scaffold(
      backgroundColor: const Color(0xFFF1F8E9), // Light greenish background
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: formWidth),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    // ✅ UI UPDATE: Added a branded header
                    const Icon(Icons.grass, size: 60, color: Color(0xFF388E3C)),
                    const SizedBox(height: 16),
                    Text(
                      'Welcome Back!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      'Log in to your CropSureConnect account',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // ✅ UI UPDATE: Styled TextFields
                    TextField(
                      controller: authController.emailController,
                      decoration: _buildInputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icons.email_outlined,
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: authController.passwordController,
                      decoration: _buildInputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icons.lock_outline,
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 40),

                    // ✅ UI UPDATE: Styled Button
                    Obx(() {
                      return authController.isLoading.value
                          ? const Center(child: CircularProgressIndicator())
                          : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF388E3C),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () => authController.login(),
                        child: Text(
                          'Login',
                          style: GoogleFonts.lato(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () => Get.to(() => const SignupPage()),
                      child: Text(
                        'Don\'t have an account? Sign Up',
                        style: GoogleFonts.lato(color: Colors.green.shade800),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper method for consistent input styling
  InputDecoration _buildInputDecoration({required String labelText, required IconData prefixIcon}) {
    return InputDecoration(
      labelText: labelText,
      prefixIcon: Icon(prefixIcon, color: Colors.grey.shade600),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF388E3C), width: 2.0),
      ),
      filled: true,
      fillColor: Colors.white,
    );
  }
}