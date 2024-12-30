import 'dart:async';

import 'package:Udyojak/admin_panel/Auth/auth_service.dart';
import 'package:Udyojak/admin_panel//screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

// Business Dashboard Screen
class BusinessDashboardScreen extends StatelessWidget {
  final Map<String, String> business;

  const BusinessDashboardScreen({super.key, required this.business});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${business['name']} Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Business Name: ${business['name']}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Email: ${business['email']}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              'Description: ${business['description']}',
              style: const TextStyle(fontSize: 16),
            ),
            // Add other business-specific management options here
          ],
        ),
      ),
    );
  }
}

// Business Management Screen
class BusinessManagementScreen extends StatefulWidget {
  const BusinessManagementScreen({super.key});
  
  @override
  _BusinessManagementScreenState createState() =>
      _BusinessManagementScreenState();
}

class _BusinessManagementScreenState extends State<BusinessManagementScreen> {
  
  final authService = AuthService();
  //final admin_id = AuthService().getCurrentUserEmail();
  //final _businessStream = Supabase.instance.client.from('businesses').stream(primaryKey: ['id']).eq('admin_id',admin_id.toString());
  
   final String admin_id = AuthService().getCurrentUserEmail()!;

  Stream<List<Map<String, dynamic>>> get businessStream => Supabase.instance.client
      .from('businesses')
      .stream(primaryKey: ['id'])
      .eq('admin_id', admin_id);


  final businessName = TextEditingController();
  final businessEmail = TextEditingController();
  final businessDescription = TextEditingController();
  final businessContact = TextEditingController();
  final businessAddress = TextEditingController();

  
  final SupabaseClient supabase = Supabase.instance.client;
  File? _selectedImage;
  String? _imageUrl;
  bool _isUploading = false;
  Future pickImage() async {
    
  }
  // Pick an image using ImagePicker
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
      _uploadImage();
    }
  }

  Future<void> _uploadImage() async {
    if (_selectedImage == null) return;

    try {
      setState(() {
        _isUploading = true;
      });

      // Create a unique file name
      final fileName = "images/"+DateTime.now().millisecondsSinceEpoch.toString();

      // Upload to the 'images' bucket
      final response = await supabase.storage
          .from('images') // Replace 'images' with your bucket name
          .upload(fileName, _selectedImage!);

      /*if (response.error != null) {
        throw response.error!;
      }*/

      // Get the public URL of the uploaded image
      final publicUrl = supabase.storage.from('images').getPublicUrl(fileName);

      setState(() {
        _imageUrl = publicUrl;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Upload failed: $e')),
      );
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }
  // Function to show the dialog and add a new business
  void _showAddBusinessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.green[50],
          title: const Text('Add New Business'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Business Name
                TextField(
                  controller: businessName,
                  decoration: const InputDecoration(
                    labelText: 'Business Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                // business contact
                const SizedBox(height: 10),
                TextField(
                  controller: businessContact,
                  decoration: const InputDecoration(
                    labelText: 'Contact No',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: businessAddress,
                  decoration: const InputDecoration(
                    labelText: 'Business Address',
                    border: OutlineInputBorder(),
                  ),
                   maxLines: 2,
                ),
                const SizedBox(height: 10),
                // Business Email
                TextField(
                  controller: businessEmail,
                  decoration: const InputDecoration(
                    labelText: 'Business Email',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 10),
                // Business Description
                TextField(
                  controller: businessDescription,
                  decoration: const InputDecoration(
                    labelText: 'Business Description',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                 const SizedBox(height: 10),
                // Business Image
                GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Center(child: Text('Tap to select an image')),
                ),
              ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                final name = businessName.text.trim();
                final email = businessEmail.text.trim();
                final description = businessDescription.text.trim();
                final contact = businessContact.text.trim();
                final address = businessAddress.text.trim();
                final image = _imageUrl;

                if (name.isNotEmpty &&
                    email.isNotEmpty &&
                    description.isNotEmpty && contact.isNotEmpty && address.isNotEmpty) {
                  final admin = authService.getCurrentUserEmail();
                  
                  
                  await Supabase.instance.client.from('businesses').insert({
                    'name' : name,
                    'description':description,
                    'email':email,
                    'contact':contact,
                    'address':address,
                    'image':image,
                    'admin_id':admin
                  });
                    
                  
                  // Clear fields after adding the business
                  businessName.clear();
                  businessEmail.clear();
                  businessDescription.clear();
                  businessAddress.clear();
                  businessContact.clear();
                  //businessImage.clear();

                  Navigator.of(context).pop(); // Close the dialog
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please fill out all fields'),
                    ),
                  );
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  // Function to navigate to Business Dashboard on click
  void _navigateToDashboard(String name) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DashboardScreen(business: name),
      ),
    );
  }

  void logout() async{
      await authService.signOut();
      Navigator.pop(context);
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Business Management'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: businessStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final businesses = snapshot.data!;
                return ListView.builder(
                  itemCount: businesses.length,
                  itemBuilder: (context, index) {
                    final business = businesses[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      elevation: 4,
                      child: ListTile(
                        leading: business['image'] != null
                            ? Image.network(
                                business['image'],
                                height: 50,
                                width: 50,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.broken_image),
                              )
                            : const Icon(Icons.business),
                        title: Text(business['name'] ?? 'Unnamed Business'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Email: ${business['email'] ?? 'No Email'}'),
                            if (business['description'] != null)
                              Text('Description: ${business['description']}'),
                          ],
                        ),
                        trailing: const Icon(Icons.arrow_forward),
                        onTap: () => _navigateToDashboard(business['name']),
                      ),
                    );

                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: _showAddBusinessDialog,
              icon: const Icon(Icons.add),
              label: const Text('Add Business'),
            ),
          ),
        ],
      ),
    );
  }
}
/*
ListTile(
                        tileColor: Colors.green[400],
                        title: Text(business['name'] ?? 'Unnamed Business'),
                        subtitle: Text('Email: ${business['email'] ?? 'No Email'}'),
                        onTap: () => _navigateToDashboard(business['name']),
                      ),*/