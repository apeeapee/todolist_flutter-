import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;

  // Login
  static Future<User?> login(String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } catch (e) {
      rethrow;
    }
  }

  // Register
  static Future<User?> register(String email, String password) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } catch (e) {
      rethrow;
    }
  }

  // Logout
  static Future<void> logout() async {
    await _auth.signOut();
  }
}