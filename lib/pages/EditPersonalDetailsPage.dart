import 'package:flutter/material.dart';

class EditPersonalDetailsPage extends StatefulWidget {
  final String username;
  final String email;
  final String mobileNumber;
  final String address;
  final Function(String, String, String,String) onSave;

  const EditPersonalDetailsPage({
    super.key,
    required this.username,
    required this.email,
    required this.mobileNumber,
    required this.onSave,
    required this.address,

  });

  @override
  _EditPersonalDetailsPageState createState() => _EditPersonalDetailsPageState();
}

class _EditPersonalDetailsPageState extends State<EditPersonalDetailsPage> {
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController mobileNumberController;

  late TextEditingController addressController;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController(text: widget.username);
    emailController = TextEditingController(text: widget.email);
    mobileNumberController = TextEditingController(text: widget.mobileNumber);
    addressController = TextEditingController(text: widget.address);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Personal Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              enabled: false, // Email is read-only
            ),
            TextField(
              controller: mobileNumberController,
              decoration: const InputDecoration(labelText: 'Mobile Number'),
            ),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(labelText: 'Adresss'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                widget.onSave(
                  usernameController.text,
                  emailController.text,
                  mobileNumberController.text,
                  addressController.text,
                );
                Navigator.pop(context); // Go back after saving
              },
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
