import 'package:flutter/material.dart';
import 'AppearanceSettingsPage.dart';
import 'DetailsPage.dart';
import 'signin_page.dart'; // Import SignInPage for navigation

class ProfileSection extends StatelessWidget {
  final bool isDarkMode;
  final Function(bool) onDarkModeToggle;

  const ProfileSection({
    super.key,
    required this.isDarkMode,
    required this.onDarkModeToggle,
  });

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

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const DetailsPage(
                      title: "Personal Details",
                      details: "Username: Madhavi\nEmail: @example.com\n"
                          "Contact: 1234567890\nAddress: City, Country",
                    ),
                  ),
                );
              },
            ),
            _buildListTile(
              context,
              icon: Icons.history,
              title: 'Order History ',
             /// subtitle: 'Orders History',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const DetailsPage(
                      title: "Order History",
                      details: "No orders available.",
                    ),
                  ),
                );
              },
            ),
            _buildListTile(
              context,
              icon: Icons.dark_mode,
              title: 'Appearance Settings',
              subtitle: 'Dark Mode: ${isDarkMode ? 'Enabled' : 'Disabled'}',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AppearanceSettingsPage(
                      isDarkMode: isDarkMode,
                      onDarkModeToggle: onDarkModeToggle,
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            // About App Section
            _buildListTile(
              context,
              icon: Icons.info_outline,
              title: 'About the App',
              subtitle: 'Learn more about the features of the app.',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const DetailsPage(
                      title: "About the App",
                      details: "This is a sample app profile section.",
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
                // Navigate to SignInPage or SignUpPage
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SignInPage(), // Redirect to SignInPage
                  ),
                );
              },
            ),

            const SizedBox(height: 20),
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
          children: const [
            Text(
              'Madhavi Balsara',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              '@example.com',
              style: TextStyle(fontSize: 16, color: Colors.grey),
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
