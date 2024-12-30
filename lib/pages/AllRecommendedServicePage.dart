import 'package:flutter/material.dart';
import 'ServiceDetailPage.dart';


class AllRecommendedServicesPage extends StatelessWidget {
  final List<Map<String, dynamic>> recommendedServices;

  const AllRecommendedServicesPage({super.key, required this.recommendedServices});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Recommended Services'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: recommendedServices.length,  // Use all services here
          itemBuilder: (context, index) {
            final service = recommendedServices[index];
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
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12.0),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      service['image'],  // Displaying service image
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    service['name'],  // Displaying service name
                    style: TextStyle(
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
      ),
    );
  }
}
