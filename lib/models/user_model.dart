class UserModel {
  final String uid;
  final String email;
  final String name;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
  });

  // Factory constructor to create a UserModel from a Firebase User object
  factory UserModel.fromFirebaseUser(String name, {required String uid, required String email}) {
    return UserModel(
      uid: uid,
      email: email,
      name: name,
    );
  }
}