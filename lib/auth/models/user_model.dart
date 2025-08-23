class UserModel {
  final String uid;
  final String name;
  final String email;
  final String phone;
  final String role; // "Buyer" or "Seller"

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
  });

  // Helper function to convert UserModel to a Map, for Firestore
  Map<String, dynamic> toMap() {
    return {
      'user_uid': uid,
      'user_name': name,
      'user_email': email,
      'user_phone': phone,
      'user_role': role,
    };
  }
}
