import 'dart:async';
import 'package:Udyojak/main.dart';
import 'package:Udyojak/pages/Homepage.dart';
import 'package:Udyojak/pages/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FlutterSecureStorage storage = FlutterSecureStorage();

  ThemeMode _themeMode = ThemeMode.light;

  // Function to toggle theme
  void _toggleTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  void initState() {
    super.initState();
    _navigateBasedOnPreference();
  }

  // Function to check saved credentials and navigate accordingly
  Future<void> _navigateBasedOnPreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? email = prefs.getString('user_email');
    final String? password = prefs.getString('user_password');

    // Simulate a delay (e.g., for the splash screen display)
    await Future.delayed(const Duration(seconds: 3));

    // Check if credentials are available and navigate accordingly
    if (email != null && password != null) {
      // Proceed to HomePage if credentials are found
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginSuccess()),
      );
    } else {
      // Navigate to the sign-in page if no credentials are found
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => WelcomScreen(
            onThemeChanged: _toggleTheme,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/image/splashscreen.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // Semi-transparent overlay for better readability
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.1), // Further reduced opacity for clearer image visibility
            ),
          ),
          // Overlay content
          Center(
            child: Text(
              "Welcome to Udyojak",
              style: TextStyle(
                fontSize: 28, // Larger font size for better visibility
                fontWeight: FontWeight.bold,
                color: Colors.black, // White text for better contrast
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.black.withOpacity(0.7),
                    offset: Offset(2.0, 2.0),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
