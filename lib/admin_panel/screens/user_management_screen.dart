import 'package:flutter/material.dart';

class UserManagementScreen extends StatelessWidget {
  // Simulated user data
  final List<Map<String, String>> users = [
    {'id': '1', 'name': 'Jane Doe', 'email': 'jane.doe@example.com'},
    {'id': '2', 'name': 'John Smith', 'email': 'john.smith@example.com'},
    {'id': '3', 'name': 'Alice Brown', 'email': 'alice.brown@example.com'},
  ];

   UserManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Management'),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];

          return ListTile(
            title: Text('User: ${user['name']}'),
            subtitle: Text('Email: ${user['email']}'),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                // Delete user logic (simulated here)
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('User ${user['name']} deleted')),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
