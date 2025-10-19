import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  // Get instance of FirebaseAuth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get user => _auth.authStateChanges();

  // Sign Up with Email & Password
  Future<UserCredential> signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      // Instead of returning null, we re-throw the exception
      // so the BLoC can handle it.
      throw e;
    }
  }
  // Sign In with Email & Password
  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      // Re-throw the exception here as well.
      throw e;
    }
  }
  // Sign Out
  Future<void> signOut() async {
    await _auth.signOut();
    print('User signed out');
  }
}