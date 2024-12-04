import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final String title;
  final String details;

  const DetailsPage({super.key, required this.title, required this.details});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          details,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}