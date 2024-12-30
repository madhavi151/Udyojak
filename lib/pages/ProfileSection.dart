import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AppearanceSettingsPage.dart';
import 'EditPersonalDetailsPage.dart';
import 'signin_page.dart';
import 'OrderHistoryPage.dart'; // Import the OrderHistoryPage

class ProfileSection extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) onDarkModeToggle;

  const ProfileSection({
    super.key,
    required this.isDarkMode,
    required this.onDarkModeToggle,
  });

  @override
  _ProfileSectionState createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {
  late String username;
  late String email;
  String? mobileNumber;
  String? address; // Add address to the state

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // Method to load user data from Firebase
  Future<void> _loadUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      email = user.email ?? 'No email';
      username = user.displayName ??
          'No username'; // Fallback if displayName is not set
      mobileNumber = await _fetchMobileNumber(user.uid) ?? 'Not Available';
      address =
          await _fetchAddress(user.uid) ?? 'Not Available'; // Fetch address
    } else {
      email = 'No email';
      username = 'No username';
      mobileNumber = 'Not Available';
      address = 'Not Available'; // Fallback address
    }

    setState(() {});
  }

  // Fetch mobile number from Firestore (if stored)
  Future<String?> _fetchMobileNumber(String userId) async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      return userDoc.exists ? userDoc['mobileNumber'] : null;
    } catch (e) {
      print('Error fetching mobile number: $e');
      return null;
    }
  }

  // Fetch address from Firestore (if stored)
  Future<String?> _fetchAddress(String userId) async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      return userDoc.exists ? userDoc['address'] : null;
    } catch (e) {
      print('Error fetching address: $e');
      return null;
    }
  }

  // Method to update user details in Firebase
  Future<void> updateDetails(String newUsername, String newEmail,
      String newMobileNumber, String newAddress) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        // Update username
        await user.updateDisplayName(newUsername);

        // Update mobile number and address in Firestore
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'mobileNumber': newMobileNumber,
          'address': newAddress, // Update address
        }, SetOptions(merge: true));

        // Update local state
        setState(() {
          username = newUsername;
          email = newEmail;
          mobileNumber = newMobileNumber;
          address = newAddress; // Update address
        });
      } catch (e) {
        print('Error updating details: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text(
      //     "Profile",
      //     style: TextStyle(fontWeight: FontWeight.bold),
      //   ),
      //   backgroundColor: Colors.red,
      // ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          children: [
            const SizedBox(height: 20),

            // User Info Section
            _buildProfileHeader(context),

            const SizedBox(height: 20),

            // Sections
            _buildListTile(
              context,
              icon: Icons.person,
              title: 'Personal Details',

              ///subtitle: 'Username: $username\nEmail: $email\nMobile: $mobileNumber\nAddress: $address',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditPersonalDetailsPage(
                      username: username,
                      email: email,
                      mobileNumber: mobileNumber ?? "",
                      address: address ?? "", // Pass address here
                      onSave: updateDetails,
                    ),
                  ),
                );
              },
            ),
            _buildListTile(
              context,
              icon: Icons.history,
              title: 'Order History',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => OrderHistoryPage(),
                  ),
                );
              },
            ),
            _buildListTile(
              context,
              icon: Icons.dark_mode,
              title: 'Appearance Settings',

              ///subtitle: 'Dark Mode: ${widget.isDarkMode ? 'Enabled' : 'Disabled'}',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AppearanceSettingsPage(
                      isDarkMode: widget.isDarkMode,
                      onDarkModeToggle: widget.onDarkModeToggle,
                    ),
                  ),
                );
              },
            ),

            // const SizedBox(height: 20),

            // Log Out Section
            _buildListTile(
              context,
              icon: Icons.logout,
              title: 'Log Out',
              subtitle: 'Tap to log out from the app.',
              onTap: () {
                // Log out from Firebase

                FirebaseAuth.instance.signOut();
                clearUserCredentials();

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const SignInPage(), // Redirect to SignInPage
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> clearUserCredentials() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_email'); // Remove the email
    await prefs.remove('user_password'); // Remove the password
  }

  // Profile Header Widget
  Widget _buildProfileHeader(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              username,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              email,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }

  // Generic List Tile with Icon
  Widget _buildListTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    VoidCallback? onTap,
  }) {
    return Card(
      elevation: 5,
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: Colors.red[50],
          child: Icon(
            icon,
            color: Colors.green,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              )
            : null,
        trailing:
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      ),
    );
  }
}
