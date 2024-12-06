import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:Udyojak/pages/signin_page.dart';
import 'package:Udyojak/pages/signup_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyCq9Hv8p1W9w39gnuRyJZ2qPDIWdvtOQAM',
      appId: '1:825527275199:android:f9e2768a3629024e6b000a',
      messagingSenderId: '825527275199',
      projectId: 'udyojak-ac670',
      storageBucket: 'udyojak-ac670.firebasestorage.app',
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Default theme mode is light
  ThemeMode _themeMode = ThemeMode.light;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Theme section: Define the light and dark theme for the app
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: true, // Enable Material 3
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.lightGreen,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent, // Transparent app bar
          elevation: 0, // No shadow
          iconTheme: IconThemeData(color: Colors.blueGrey), // Black icons for light mode
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black, fontSize: 16), // General text
          titleLarge: TextStyle(
            fontSize: 35, // Larger title for welcome message
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey, // Title text in black for light mode
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            color: Colors.white, // Slightly faded text in light mode
          ), // Smaller descriptive text
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red, // Red button for light mode
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 150), // Increased horizontal padding for a longer button
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero, // No rounded corners for a rectangular button
            ),
            side: const BorderSide(color: Colors.red), // Red border
          ),
        ),
      ),
      // Dark theme section: Define dark theme styling
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF3C7838),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF5AB850),
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
          titleLarge: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Title text in white for dark mode
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            color: Colors.white70, // Slightly faded text in dark mode
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red, // Red button for light mode
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 150), // Increased horizontal padding for a longer button
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero, // No rounded corners for a rectangular button
            ),
            side: const BorderSide(color: Colors.red), // Red border
          ),
        ),
      ),
      themeMode: _themeMode, // Dynamically apply theme
      home: HomePage(onThemeChanged: _toggleTheme), // Pass the theme change function
    );
  }

  // Theme toggle function: Toggle between light and dark theme
  void _toggleTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }
}

class HomePage extends StatelessWidget {
  final Function(bool) onThemeChanged;

  const HomePage({super.key, required this.onThemeChanged});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        actions: [
          // Dark mode toggle: Switch to toggle between light and dark themes
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Switch(
              value: Theme.of(context).brightness == Brightness.dark,
              onChanged: (bool value) {
                onThemeChanged(value); // Toggle theme
              },
              activeColor: Colors.black12, // Toggle switch color
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        // Background gradient: Gradient color background for the main page
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.red.withOpacity(0.8),
              Colors.orange.withOpacity(0.8),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Welcome message: Title and description text
              Text(
                "Welcome to Udyojak!",
                style: textTheme.titleLarge?.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                "Join us to explore opportunities and services tailored for young entrepreneurs.",
                style: textTheme.bodyMedium?.copyWith(color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              // Sign In and Sign Up Buttons: Navigation to sign in and sign up pages
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignInPage()),
                  );
                },
                child: const Text(
                  'Sign In',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUpPage()),
                  );
                },
                child: const Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
