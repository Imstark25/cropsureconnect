import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // SIGN UP with Email and Password
  Future<User?> signUpWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Error Signing Up",
        e.message ?? "An unknown error occurred.",
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    }
  }

  // Add user details to 'Sellers' or 'Buyers' collection
  Future<void> addUserDetails(
    String uid,
    String name,
    String email,
    String phone,
    String role,
  ) async {
    final userData = {
      'user_name': name,
      'user_email': email,
      'user_phone': phone,
      'user_role': role,
      'user_uid': uid,
    };

    try {
      if (role.toLowerCase() == 'seller') {
        await _db.collection('Sellers').doc(uid).set(userData);
      } else {
        await _db.collection('Buyers').doc(uid).set(userData);
      }
    } catch (e) {
      Get.snackbar(
        "Error Saving Data",
        "Your details could not be saved.",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // SIGN IN with Email and Password
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Error Signing In",
        e.message ?? "An unknown error occurred.",
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    }
  }

  // SIGN OUT
  Future<void> signOut() async {
    await _auth.signOut();
  }
}