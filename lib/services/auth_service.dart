import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl =
      'https://your-backend-api-url.com'; // Replace with your backend URL

  /// Method for signing in a user
  Future<String?> signIn(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/signin'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['token']; // Return the token on successful login
      } else {
        return null; // Login failed
      }
    } catch (e) {
      print('Sign-In Error: $e');
      return null;
    }
  }

  /// Method for signing up a user
  Future<bool> signUp(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 201) {
        return true; // Sign-up successful
      } else {
        return false; // Sign-up failed
      }
    } catch (e) {
      print('Sign-Up Error: $e');
      return false;
    }
  }
}
