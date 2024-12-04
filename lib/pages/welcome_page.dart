import 'package:flutter/material.dart';
import 'package:Udyojak/pages/signin_page.dart';
import 'package:Udyojak/pages/signup_page.dart';


// Start of WelcomePage Widget
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent, // Solid red background for a professional look
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Transparent app bar
        elevation: 0, // No shadow for the app bar
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black), // Close icon in the corner
          onPressed: () {
            Navigator.pop(context); // Close the page when the icon is pressed
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center the content vertically
          children: [
            const SizedBox(height: 30),
            // Start of Welcome Message
            const Text(
              'Welcome to Udyojak!', // Title text for the welcome screen
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white, // White color for text
                fontFamily: 'Roboto', // Clean, professional font
              ),
            ),
            const SizedBox(height: 20),
            // Start of Subtext Message
            const Text(
              'Explore opportunities for young entrepreneurs!', // Subtext explaining the app's purpose
              textAlign: TextAlign.center, // Center the subtext
              style: TextStyle(
                fontSize: 18,
                color: Colors.white70, // Slightly transparent white for subtext
                fontFamily: 'Roboto', // Matching font style
              ),
            ),
            const SizedBox(height: 40),

            // Start of Sign In Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // White background for the button
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // Rounded corners for the button
                ),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignInPage()), // Navigate to the SignInPage
                );
              },
              child: const Text(
                'Sign In', // Text on the sign-in button
                style: TextStyle(
                  color: Colors.redAccent, // Red text to contrast with the white button
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Start of Sign Up Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // White background for the button
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // Rounded corners for the button
                ),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpPage()), // Navigate to the SignUpPage
                );
              },
              child: const Text(
                'Sign Up', // Text on the sign-up button
                style: TextStyle(
                  color: Colors.white, // Red text to contrast with the white button
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
