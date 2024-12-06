import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Clean white background for professional look
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.redAccent, // Subtle red accent for dynamic energy
                  Colors.lightGreenAccent, // Smooth orange gradient for warmth
                ],
              ),
            ),
          ),
          // Image fully visible and fitting the screen
          Positioned.fill(
            child: Image.asset(
              'assets/image/splashscreen.jpg', // Path to your image
              fit: BoxFit.cover, // Ensure the image fully fits and covers the screen without stretching
            ),
          ),
          // Content on top of the image
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0), // Add padding for better layout
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Text with modern, clean styling
                  Text(
                    "Welcome to Udyojak",
                    style: TextStyle(
                      fontSize: 36, // Larger font size for prominence
                      fontWeight: FontWeight.w700, // Bold but not too heavy
                      color: Colors.white, // White color for a clean and professional look
                      letterSpacing: 1.5, // Slight letter spacing for refinement
                      shadows: [
                        Shadow(
                          blurRadius: 8.0,
                          color: Colors.black.withOpacity(0.6),
                          offset: const Offset(2.0, 2.0),
                        ),
                      ], // Subtle shadow for depth
                    ),
                    textAlign: TextAlign.center, // Center the text for balance
                  ),
                  const SizedBox(height: 20), // Add space between text and arrow
                  // Professional looking Arrow with animation
                  GestureDetector(
                    onTap: () {
                      // Navigate to Sign In / Sign Up page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignInPage()),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15.0), // Padding for the container
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7), // Slightly transparent background
                        borderRadius: BorderRadius.circular(50), // Rounded corners for a smooth look
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.arrow_right_alt_outlined,
                        color: Colors.redAccent, // Professional red color for the arrow
                        size: 40,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Sign In Page
class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Sign In Page', style: TextStyle(fontSize: 24)),
            // Add Sign In form here
          ],
        ),
      ),
    );
  }
}

// Sign Up Page
class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Sign Up Page', style: TextStyle(fontSize: 24)),
            // Add Sign Up form here
          ],
        ),
      ),
    );
  }
}
