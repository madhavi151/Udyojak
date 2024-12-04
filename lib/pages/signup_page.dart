import 'package:flutter/material.dart';
import 'package:Udyojak/services/auth_service.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // Text controllers to manage the input fields for email, password, and confirm password.
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
  TextEditingController();

  // Instance of AuthService to handle sign-up functionality
  final AuthService authService = AuthService();

  // FormKey to manage form validation state
  final _formKey = GlobalKey<FormState>();

  // State variables to manage loading and error messages
  bool isLoading = false;
  String? errorMessage;

  // Method to handle sign-up logic
  void signUp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    try {
      final isSuccess = await authService.signUp(email, password);

      setState(() {
        isLoading = false;
      });

      if (isSuccess) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SignUpSuccessPage()),
        );
      } else {
        setState(() {
          errorMessage = "Sign-Up failed. Please try again.";
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = e.toString(); // Display error message
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color to white
      body: SingleChildScrollView( // Make the page scrollable
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Form(
          key: _formKey,  // Use the form key for validation
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // App Logo
              Center(
                child: Image.asset(
                  'assets/image/WelcomeLogo.jpg', // Replace with your logo path
                  height: 100,  // Set height for the logo
                ),
              ),
              const SizedBox(height: 20), // Add space below the logo

              // Page Title
              const Text(
                "Create an Account",
                style: TextStyle(
                  fontSize: 28, // Set font size for the title
                  fontWeight: FontWeight.bold, // Set bold font weight
                  color: Colors.black, // Set text color to black
                ),
              ),
              const SizedBox(height: 10), // Add space below the title

              // Subtitle for the page
              const Text(
                "Sign up to explore our services and connect with opportunities.",
                style: TextStyle(fontSize: 16, color: Colors.grey), // Set font size and color
              ),
              const SizedBox(height: 30), // Add space below the subtitle

              // Email Field
              TextFormField(
                controller: emailController, // Bind the email controller
                keyboardType: TextInputType.emailAddress, // Set keyboard to email type
                decoration: InputDecoration(
                  labelText: "Email",  // Label for the email input field
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                  prefixIcon: const Icon(Icons.email), // Icon for the email field
                ),
                validator: (value) {
                  // Validate the email input
                  if (value == null || value.isEmpty) {
                    return "Please enter your email."; // Show error if empty
                  }
                  // Regex for validating email format
                  if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                      .hasMatch(value)) {
                    return "Please enter a valid email."; // Show error for invalid format
                  }
                  return null; // Return null if email is valid
                },
              ),
              const SizedBox(height: 20), // Add space below email field

              // Password Field
              TextFormField(
                controller: passwordController, // Bind the password controller
                obscureText: true, // Hide password input
                decoration: InputDecoration(
                  labelText: "Password",  // Label for the password input field
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                  prefixIcon: const Icon(Icons.lock), // Icon for the password field
                ),
                validator: (value) {
                  // Validate password input
                  if (value == null || value.isEmpty) {
                    return "Please enter your password."; // Show error if empty
                  }
                  if (value.length < 6) {
                    return "Password must be at least 6 characters."; // Validate length
                  }
                  return null; // Return null if password is valid
                },
              ),
              const SizedBox(height: 20), // Add space below password field

              // Confirm Password Field
              TextFormField(
                controller: confirmPasswordController, // Bind the confirm password controller
                obscureText: true, // Hide confirm password input
                decoration: InputDecoration(
                  labelText: "Confirm Password",  // Label for confirm password field
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                  prefixIcon: const Icon(Icons.lock_outline), // Icon for confirm password
                ),
                validator: (value) {
                  // Validate confirm password input
                  if (value == null || value.isEmpty) {
                    return "Please confirm your password."; // Show error if empty
                  }
                  if (value != passwordController.text.trim()) {
                    return "Passwords do not match."; // Show error if passwords don't match
                  }
                  return null; // Return null if passwords match
                },
              ),
              const SizedBox(height: 20), // Add space below confirm password field

              // Display error message if any
              if (errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10), // Padding for error message
                  child: Text(
                    errorMessage!, // Display error message
                    style: const TextStyle(color: Colors.red), // Red color for error
                  ),
                ),

              // Sign-Up Button
              isLoading
                  ? const Center(child: CircularProgressIndicator()) // Show loading indicator if isLoading is true
                  : SizedBox(
                width: double.infinity, // Full width for the button
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent, // Button color
                    padding: const EdgeInsets.symmetric(vertical: 15), // Button padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Rounded corners
                    ),
                  ),
                  onPressed: signUp, // Call signUp method when pressed
                  child: const Text(
                    "Sign Up",  // Text for the button
                    style: TextStyle(fontSize: 18, color: Colors.white), // Text style
                  ),
                ),
              ),

              const SizedBox(height: 20), // Add space below the sign-up button

              // "Already have an account?" and "Log In" text with the same color
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // Center the row content
                children: [
                  const Text(
                    "Already have an account?",
                    style: TextStyle(color: Colors.black), // Text color for "Already have an account?"
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Navigate back to login page
                    },
                    child: const Text(
                      "Log In",  // Text for the login link
                      style: TextStyle(color: Colors.redAccent), // Text color for login link
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

class AuthService {
  // Simulating sign-up functionality (replace with actual backend API call)
  Future<bool> signUp(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate network request delay
    return true; // Simulate success; return `false` to simulate failure
  }
}

class SignUpSuccessPage extends StatelessWidget {
  const SignUpSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, size: 100, color: Colors.green), // Success icon
            const SizedBox(height: 20), // Space below the icon
            const Text(
              "Sign-Up Successful!", // Success message text
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), // Style for success message
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Navigate back to login page
              },
              child: const Text("Go to Log In"), // Button text
            ),
          ],
        ),
      ),
    );
  }
}
