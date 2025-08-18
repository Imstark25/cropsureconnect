// CONTROLLERS
// -----------------------------------------------------------------------------

// The controller manages the state and business logic.
// It interacts with the Service and notifies the View of changes.
class FarmerAuthController with ChangeNotifier {
  final FarmerAuthService _authService = FarmerAuthService();

  bool _isLoading = false;
  String? _errorMessage;
  UserModel? _currentUser;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  UserModel? get currentUser => _currentUser;

  // Log in the user
  Future<void> loginUser(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final userCredential = await _authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;
      if (user != null) {
        // You would typically fetch user details from Firestore here
        _currentUser = UserModel.fromFirebaseUser('', uid: user.uid, email: user.email!);
      }
    } on FirebaseAuthException catch (e) {
      _errorMessage = _getAuthErrorMessage(e.code);
    } catch (e) {
      _errorMessage = 'An unexpected error occurred. Please try again.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Register a new user
  Future<void> registerUser(String name, String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final userCredential = await _authService.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;
      if (user != null) {
        // Here you would save the user details (like name) to Firestore
        _currentUser = UserModel.fromFirebaseUser(name, uid: user.uid, email: user.email!);
      }
    } on FirebaseAuthException catch (e) {
      _errorMessage = _getAuthErrorMessage(e.code);
    } catch (e) {
      _errorMessage = 'An unexpected error occurred. Please try again.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Sign out the current user
  Future<void> signOut() async {
    await _authService.signOut();
    _currentUser = null;
    notifyListeners();
  }

  // Helper function to provide user-friendly error messages
  String _getAuthErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Wrong password provided for that user.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'email-already-in-use':
        return 'An account already exists for that email.';
      case 'weak-password':
        return 'The password is too weak.';
      default:
        return 'An authentication error occurred. Please try again.';
    }
  }
}
