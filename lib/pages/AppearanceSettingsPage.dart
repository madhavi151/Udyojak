import 'package:flutter/material.dart';

class AppearanceSettingsPage extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) onDarkModeToggle;

  const AppearanceSettingsPage({
    super.key,
    required this.isDarkMode,
    required this.onDarkModeToggle,
  });

  @override
  State<AppearanceSettingsPage> createState() => _AppearanceSettingsPageState();
}

class _AppearanceSettingsPageState extends State<AppearanceSettingsPage> {
  late bool isDarkMode;

  @override
  void initState() {
    super.initState();
    isDarkMode = widget.isDarkMode; // Initialize with the passed value
  }

  void _toggleDarkMode(bool value) {
    setState(() {
      isDarkMode = value;
    });
    widget.onDarkModeToggle(value); // Notify the parent widget
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Appearance Settings"),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Enable Dark Mode",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Switch(
              value: isDarkMode,
              onChanged: _toggleDarkMode,
              activeColor: Colors.red,
              inactiveThumbColor: Colors.grey,
              inactiveTrackColor: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }
}
