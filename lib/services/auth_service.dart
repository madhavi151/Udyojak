import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> signInWithFirebase(String email, String password) async {
    try {
      // Sign in with Firebase Authentication
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        // If Firebase sign-in is successful, return the user UID or success message
        return 'Sign-in successful!';
      } else {
        return 'Failed to sign in with Firebase.';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided.';
      } else {
        return 'Failed to sign in: ${e.message}';
      }
    } catch (e) {
      return 'An unexpected error occurred: ${e.toString()}';
    }
  }

  // Sign-up method using Firebase Authentication
  Future<String> signUpWithFirebase(String email, String password) async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'Sign-up successful!'; // Return success message
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return 'Email is already in use.';
      } else if (e.code == 'weak-password') {
        return 'The password is too weak.';
      } else {
        return 'Failed to sign up: ${e.message}';
      }
    } catch (e) {
      return 'An unexpected error occurred: ${e.toString()}';
    }
  }

  // Method to sign out the user
  Future<String> signOut() async {
    try {
      await _auth.signOut();
      return 'Sign-out successful!';
    } catch (e) {
      return 'An error occurred while signing out: ${e.toString()}';
    }
  }

  // Method to reset password
  Future<String> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return 'Password reset email sent.';
    } catch (e) {
      return 'An error occurred: ${e.toString()}';
    }
  }

  // Method to check if a user is logged in
  Future<String?> getCurrentUser() async {
    try {
      final User? user = _auth.currentUser;
      if (user != null) {
        return 'Logged in as: ${user.email}';
      } else {
        return 'No user is logged in.';
      }
    } catch (e) {
      return 'An error occurred: ${e.toString()}';
    }
  }
}
