import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
  late String mobileNumber;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      email = user.email ?? 'No email';
      username = user.displayName ?? 'No username'; // Fallback if displayName is not set
      mobileNumber = 'Not Available'; // Firebase Auth does not store the phone number directly
    } else {
      email = 'No email';
      username = 'No username';
      mobileNumber = 'Not Available';
    }
  }

  void updateDetails(String newUsername, String newEmail, String newMobileNumber) {
    setState(() {
      username = newUsername;
      email = newEmail;
      mobileNumber = newMobileNumber;
    });

    // You can also update Firebase here
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      user.updateDisplayName(newUsername);  // Update username
      // Update the mobile number in Firebase if you're using Firebase Database or Firestore.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red,
      ),
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
              subtitle: 'Username: $username\nEmail: $email\nMobile: $mobileNumber',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditPersonalDetailsPage(
                      username: username,
                      email: email,
                      mobileNumber: mobileNumber,
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
                    builder: (_) => const OrderHistoryPage(), // Now no need to pass orderHistory
                  ),
                );
              },
            ),
            _buildListTile(
              context,
              icon: Icons.dark_mode,
              title: 'Appearance Settings',
              subtitle: 'Dark Mode: ${widget.isDarkMode ? 'Enabled' : 'Disabled'}',
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

            const SizedBox(height: 20),

            // Log Out Section
            _buildListTile(
              context,
              icon: Icons.logout,
              title: 'Log Out',
              subtitle: 'Tap to log out from the app.',
              onTap: () {
                // Log out from Firebase
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SignInPage(), // Redirect to SignInPage
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Profile Header Widget
  Widget _buildProfileHeader(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.green[200],
          child: const Icon(
            Icons.person,
            size: 40,
            color: Colors.white,
          ),
        ),
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
    return ListTile(
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
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
    );
  }
}
