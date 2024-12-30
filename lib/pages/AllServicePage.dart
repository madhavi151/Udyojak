import 'package:flutter/material.dart';
import 'ServiceDetailPage.dart';

class AllServicesPage extends StatelessWidget {
  final List<Map<String, dynamic>> services;  // List of all services

  const AllServicesPage({super.key, required this.services});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Services'),
      ),
      body: ListView.builder(
        itemCount: services.length,
        itemBuilder: (context, index) {
          final service = services[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ServiceDetailPage(service: service),
                ),
              );
            },
            child: Card(
              elevation: 5.0,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(service['image']),
                        fit: BoxFit.cover, // Ensures the image fills the box
                      ),
                    ),
                  ),
                ),
                title: Text(
                  service['name'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.blueAccent,
                  size: 20,
                ),
              ),
            ),
          );
        },
      ),
    );

  }
}
