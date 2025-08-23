// lib/auth/views/signup_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class SignupPage extends StatelessWidget {
  final AuthController _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final formWidth = screenWidth > 600 ? 400.0 : screenWidth * 0.9;

    return Scaffold(
      appBar: AppBar(title: Text('Create Account')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: formWidth),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // ** NEW: Name Field **
                    TextField(
                      controller: _authController.nameController,
                      decoration: InputDecoration(labelText: 'Full Name'),
                      keyboardType: TextInputType.name,
                    ),
                    SizedBox(height: 20),

                    // Email Field
                    TextField(
                      controller: _authController.emailController,
                      decoration: InputDecoration(labelText: 'Email'),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 20),

                    // ** NEW: Phone Number Field **
                    TextField(
                      controller: _authController.phoneController,
                      decoration: InputDecoration(labelText: 'Phone Number'),
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(height: 20),

                    // Password Field
                    TextField(
                      controller: _authController.passwordController,
                      decoration: InputDecoration(labelText: 'Password'),
                      obscureText: true,
                    ),
                    SizedBox(height: 20),

                    // ** NEW: User Role Dropdown **
                    Obx(
                      () => DropdownButtonFormField<String>(
                        value: _authController.selectedRole.value,
                        decoration: InputDecoration(
                          labelText: 'I am a',
                          border: OutlineInputBorder(),
                        ),
                        items: _authController.roles.map((String role) {
                          return DropdownMenuItem<String>(
                            value: role,
                            child: Text(role),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          if (newValue != null) {
                            _authController.setSelectedRole(newValue);
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 40),

                    // Sign Up Button
                    Obx(() {
                      return _authController.isLoading.value
                          ? CircularProgressIndicator()
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 50,
                                  vertical: 15,
                                ),
                              ),
                              onPressed: () => _authController.signUp(),
                              child: Text('Sign Up'),
                            );
                    }),

                    // Login Button
                    TextButton(
                      onPressed: () => Get.back(),
                      child: Text('Already have an account? Login'),
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
}
