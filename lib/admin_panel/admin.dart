import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/dashboard_screen.dart';
import 'screens/inventory_screen.dart';
import 'screens/order_management_screen.dart';
import 'screens/sign_in.dart'; // Import renamed Sign In screen
import 'screens/sign_up.dart'; // Import renamed Sign Up screen
//import 'package:firebase_core/firebase_core.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
   await Supabase.initialize(
    anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InV3b3h6ZHFoZ2l0eGphZGNtbW1yIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzM4NDk3OTUsImV4cCI6MjA0OTQyNTc5NX0.yIj3_vl2jzQ1lehwWStKQ8_RWiWWBVEfdSDkjUzYu4I",
    url: "https://uwoxzdqhgitxjadcmmmr.supabase.co"
    );
  // Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
 

   MyApp({super.key});

     
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin Panel',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainScreen(), // Start with the MainScreen
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade300, Colors.green.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Welcome to Admin Panel',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        offset: Offset(2, 2),
                        blurRadius: 4,
                        color: Colors.black26,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignInScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.blue.shade800,
                    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  child: Text('Sign In', style: TextStyle(color: Colors.white,fontWeight: FontWeight.w200)),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.green.shade800,
                    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w200),
                  ),
                  child: Text('Register', style: TextStyle(color: Colors.white,fontWeight: FontWeight.w200)),
                ),
                const SizedBox(height: 32),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
