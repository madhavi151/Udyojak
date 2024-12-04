import 'package:flutter/material.dart';

class ServiceDetailPage extends StatelessWidget {
  final Map<String, dynamic> service;

  const ServiceDetailPage({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(service['name']),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),  // Back navigation
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Service Image
          Image.asset(
            service['image'],
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 20),

          // Service Name
          Text(
            service['name'],
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          // Service Description
          Text(
            service['description'],
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),

          // Contact Info
          Text(
            'Email: ${service['email']}',
            style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: 5),
          Text(
            'Contact: ${service['contactNo']}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 5),
          Text(
            'Address: ${service['address']}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),

          // Related Services (If any)
          const Text(
            'Related Services:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: service['services'].length,
            itemBuilder: (context, index) {
              final relatedService = service['services'][index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: ListTile(
                  leading: Image.asset(
                    relatedService['image'],
                    width: 50,
                    height: 50,
                  ),
                  title: Text(relatedService['name']),
                  subtitle: Text('₹${relatedService['price'].toStringAsFixed(2)}'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
