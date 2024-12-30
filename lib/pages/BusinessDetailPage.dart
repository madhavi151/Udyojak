import 'package:Udyojak/pages/productdetails.dart';
import 'package:flutter/material.dart';

class BusinessDetailPage extends StatefulWidget {
  final Map<String, dynamic> business;

  const BusinessDetailPage({super.key, required this.business});

  @override
  State<BusinessDetailPage> createState() => _BusinessDetailPageState();
}

class _BusinessDetailPageState extends State<BusinessDetailPage> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _commentController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text(widget.business['name'])),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(widget.business['image'],
                  width: double.infinity, height: 200, fit: BoxFit.cover),
              const SizedBox(height: 20),
              Text(
                widget.business['name'],
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                widget.business['description'],
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                'Email: ${widget.business['email']}',
                style:
                    const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 5),
              Text(
                'Contact: ${widget.business['contactNo']}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 5),
              Text(
                'Address: ${widget.business['address']}',
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
                itemCount: widget.business['products'].length,
                itemBuilder: (context, index) {
                  final product = widget.business['products'][index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductDetailPage(product: product),
                          ));
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      child: ListTile(
                        leading:
                            Image.asset(product.image, width: 150, height: 200),
                        title: Text(product.name),
                        subtitle: Text('₹${product.price.toStringAsFixed(2)}'),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              ReviewSection(
                business: widget.business,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ReviewSection extends StatefulWidget {
  final Map<String, dynamic> business;

  ReviewSection({required this.business});

  @override
  _ReviewSectionState createState() => _ReviewSectionState();
}

class _ReviewSectionState extends State<ReviewSection> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  double rating = 1.0;

  @override
  Widget build(BuildContext context) {
    // Fetching reviews from the selected business
    final List<Map<String, dynamic>> reviews = widget.business['reviews'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Reviews:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        // List of reviews
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: reviews.length,
          itemBuilder: (context, index) {
            final review = reviews[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                title: Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 20),
                    const SizedBox(width: 5),
                    Text(
                      review['rating'].toString(),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review['name'],
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(review['comment']),
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 20),
        // Add Review Form
        const Text(
          'Add Your Review:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _nameController,
          decoration: const InputDecoration(
            labelText: 'Your Name',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _commentController,
          decoration: const InputDecoration(
            labelText: 'Your Review',
            border: OutlineInputBorder(),
          ),
          maxLines: 4,
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const Text('Rating:'),
            Slider(
              value: rating,
              min: 1.0,
              max: 5.0,
              divisions: 4,
              label: rating.toStringAsFixed(1),
              onChanged: (value) {
                setState(() {
                  rating = value;
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            // Add the review to the selected business's reviews
            setState(() {
              widget.business['reviews'].add({
                'name': _nameController.text,
                'rating': rating,
                'comment': _commentController.text,
              });
              _nameController.clear();
              _commentController.clear();
              rating = 1.0;
            });
          },
          child: const Text('Submit Review'),
        ),
      ],
    );
  }
}
