import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // This is the method that checks if email and password are correct
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } on FirebaseAuthException catch (e) {
      // Handle Firebase-specific errors like 'wrong-password' or 'user-not-found'
      String errorMessage = "An unknown error occurred.";
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for that user.';
      } else {
        errorMessage = e.message ?? errorMessage;
      }
      Get.snackbar("Login Failed", errorMessage, snackPosition: SnackPosition.BOTTOM);
      return null;
    }
  }

  // --- Other Methods (Signup, AddUserDetails, etc.) ---

  Future<User?> signUpWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error Signing Up", e.message ?? "An unknown error occurred.");
      return null;
    }
  }

  Future<void> addUserDetails(
    String uid, String name, String email, String phone, String role) async {
    final userData = {
      'user_name': name,
      'user_email': email,
      'user_phone': phone,
      'user_role': role,
      'user_uid': uid,
      // You can add other default fields for new users here
    };

    try {
      if (role.toLowerCase() == 'seller') {
        await _db.collection('Sellers').doc(uid).set(userData);
      } else {
        await _db.collection('Buyers').doc(uid).set(userData);
      }
    } catch (e) {
      Get.snackbar("Error Saving Data", "Your details could not be saved.");
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}