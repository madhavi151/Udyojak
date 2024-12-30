import 'package:Udyojak/pages/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:Udyojak/pages/signin_page.dart';
import 'package:Udyojak/pages/signup_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InV3b3h6ZHFoZ2l0eGphZGNtbW1yIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzM4NDk3OTUsImV4cCI6MjA0OTQyNTc5NX0.yIj3_vl2jzQ1lehwWStKQ8_RWiWWBVEfdSDkjUzYu4I",
      url: "https://uwoxzdqhgitxjadcmmmr.supabase.co"
  );
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
  ThemeMode _themeMode = ThemeMode.light;

  // Function to toggle theme
  void _toggleTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.lightGreen,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF3C7838),
        useMaterial3: true,
      ),
      themeMode: _themeMode, // Dynamically apply theme
      // home: WelcomScreen(onThemeChanged: _toggleTheme),
      home: const SplashScreen(),
    );
  }
}

class WelcomScreen extends StatelessWidget {
  final Function(bool) onThemeChanged;

  const WelcomScreen({super.key, required this.onThemeChanged});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome to Udyojak!",
              style: GoogleFonts.mcLaren(
                textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
              ),
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignInPage()),
                );
              },
              child: Text(
                "Sign In",
                style: GoogleFonts.mcLaren(
                  fontSize: 16, // Adjust size as needed
                  color: Colors.black, // Text color
                ),
              ),
            ),

            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpPage()),
                );
              },
              child: Text(
                "Sign Up",
                style: GoogleFonts.mcLaren(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}