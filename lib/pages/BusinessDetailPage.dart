import 'package:flutter/material.dart';


class BusinessDetailPage extends StatelessWidget {
  final Map<String, dynamic> business;

  const BusinessDetailPage({super.key, required this.business});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(business['name'])),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(business['image'],
                  width: double.infinity, height: 200, fit: BoxFit.cover),
              const SizedBox(height: 20),
              Text(
                business['name'],
                style:
                const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                business['description'],
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                'Email: ${business['email']}',
                style:
                const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 5),
              Text(
                'Contact: ${business['contactNo']}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 5),
              Text(
                'Address: ${business['address']}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text(
                'Products:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: business['products'].length,
                itemBuilder: (context, index) {
                  final product = business['products'][index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      leading:
                      Image.asset(product.image, width: 150, height: 200),
                      title: Text(product.name),
                      subtitle: Text('₹${product.price.toStringAsFixed(2)}'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
