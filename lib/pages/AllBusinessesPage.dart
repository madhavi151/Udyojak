import 'package:flutter/material.dart';
import 'BusinessDetailPage.dart'; // Import BusinessDetailPage

class AllBusinessesPage extends StatelessWidget {
  final List<Map<String, dynamic>> businesses;

  const AllBusinessesPage({super.key, required this.businesses});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Recommended Businesses')),
      body: ListView.builder(
        itemCount: businesses.length,
        itemBuilder: (context, index) {
          final business = businesses[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BusinessDetailPage(business: business),
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
                  child: Image.asset(
                    business['image'],
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  business['name'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                ///subtitle: Text(
                  ///business['description'],
                  ///style: const TextStyle(
                    ///fontSize: 14,
                  ///),
                //),
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
