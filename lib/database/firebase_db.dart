import 'package:firebase_auth/firebase_auth.dart';

class FirebaseHelper {
  final FirebaseAuth auth = FirebaseAuth.instance;

  // Get the current user
  User? get user => auth.currentUser;

  // Stream to listen for user authentication state changes
  Stream<User?> get userChanges => auth.authStateChanges();

  // Register a new user
  Future<String?> register({
    required String useremail,
    required String password,
  }) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: useremail,
        password: password,
      );
      return null; // Return null if registration is successful
    } on FirebaseAuthException catch (e) {
      return e.message; // Return the error message if an exception occurs
    }
  }

  // Log in an existing user
  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null; // Return null if login is successful
    } on FirebaseAuthException catch (e) {
      return e.message; // Return the error message if an exception occurs
    }
  }

  // Sign out the current user
  Future<void> signOut() async {
    await auth.signOut();
  }
}
