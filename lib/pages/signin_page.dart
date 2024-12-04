import 'package:Udyojak/pages/signup_page.dart';
import 'package:flutter/material.dart';


// Start of SignInPage Widget
class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  // Start of the form controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Instance of AuthService to call sign-in functionality
  final AuthService authService = AuthService();

  // Form key to handle form validation
  final _formKey = GlobalKey<FormState>();

  // State variables to manage loading and error messages
  bool isLoading = false;
  String? errorMessage;

  // Start of sign-in method
  void signIn() async {
    if (!_formKey.currentState!.validate()) return; // Return if form is invalid

    setState(() {
      isLoading = true;  // Show loading indicator
      errorMessage = null; // Reset any previous error messages
    });

    final email = emailController.text.trim();  // Get email input
    final password = passwordController.text.trim();  // Get password input

    final isSuccess = await authService.signIn(email, password); // Attempt sign-in
    setState(() {
      isLoading = false;  // Hide loading indicator after response
    });

    if (isSuccess) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SignInSuccessPage()), // Navigate to success page
      );
    } else {
      setState(() {
        errorMessage = "Sign-In failed. Please try again.";  // Show error message if sign-in fails
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,  // Set background color
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Form(
          key: _formKey,  // Form key for validation
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Start of Logo or Header Section
              Center(
                child: Image.asset(
                  'assets/image/WelcomeLogo.jpg', // Logo asset
                  height: 100,  // Logo height
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Welcome Back!",  // Welcome message
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Sign in to continue your journey.",  // Subtext for sign-in prompt
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 30),

              // Start of Email Field
              TextFormField(
                controller: emailController,  // Email controller to handle input
                keyboardType: TextInputType.emailAddress,  // Set keyboard type for email
                decoration: InputDecoration(
                  labelText: "Email",  // Label text for the email input field
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),  // Rounded corners for input field
                  ),
                  prefixIcon: const Icon(Icons.email),  // Icon for email field
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your email.";  // Email validation for empty input
                  }
                  if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                      .hasMatch(value)) {
                    return "Please enter a valid email.";  // Email format validation
                  }
                  return null;  // Return null if email is valid
                },
              ),
              const SizedBox(height: 20),

              // Start of Password Field
              TextFormField(
                controller: passwordController,  // Password controller to handle input
                obscureText: true,  // Hide password characters
                decoration: InputDecoration(
                  labelText: "Password",  // Label text for the password input field
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),  // Rounded corners for input field
                  ),
                  prefixIcon: const Icon(Icons.lock),  // Icon for password field
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your password.";  // Password validation for empty input
                  }
                  if (value.length < 6) {
                    return "Password must be at least 6 characters.";  // Password length validation
                  }
                  return null;  // Return null if password is valid
                },
              ),
              const SizedBox(height: 20),

              // Start of Error Message Section
              if (errorMessage != null)
                Text(
                  errorMessage!,  // Display error message if sign-in fails
                  style: const TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 10),

              // Start of Sign-In Button
              isLoading
                  ? const Center(child: CircularProgressIndicator())  // Show loading indicator if isLoading is true
                  : SizedBox(
                width: double.infinity,  // Full width for the button
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,  // Button color
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),  // Rounded corners for the button
                    ),
                  ),
                  onPressed: signIn,  // Call sign-in method when button is pressed
                  child: const Text(
                    "Sign In",  // Text on the button
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),

              // Start of Sign-Up Navigation Section
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",  // Text prompting user to sign up
                    style: TextStyle(color: Colors.black),  // Text color changed to black
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const SignUpPage()),  // Navigate to sign-up page
                      );
                    },
                    child: const Text(
                      "Sign Up",  // Text for sign-up button
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Start of AuthService Class
class AuthService {
  // Simulating sign-in functionality
  Future<bool> signIn(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2));  // Simulate a network request delay
    return true;  // Return true for a successful sign-in (replace with actual API call)
  }
}

// Start of SignInSuccessPage Widget
class SignInSuccessPage extends StatelessWidget {
  const SignInSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, size: 100, color: Colors.green),  // Success icon
            const SizedBox(height: 20),
            const Text(
              "Sign-In Successful!",  // Success message text
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);  // Navigate back to home/dashboard
              },
              child: const Text("Go to Dashboard"),  // Button to go to dashboard
            ),
          ],
        ),
      ),
    );
  }
}
