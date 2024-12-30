import 'package:Udyojak/pages/Homepage.dart';
import 'package:Udyojak/pages/data/datalists.dart';
import 'package:flutter/material.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;

  ProductDetailPage({required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  // Add product to the cart
  void addToCart(Product product) {
    setState(() {
      cart.add(product);
    });
  }

  // Remove product from the cart
  void _removeFromCart(Product product) {
    setState(() {
      cart.remove(product);
    });
  }

  // Check if product is in the cart
  bool isProductInCart(Product product) {
    return cart.contains(product);
  }

  // Calculate total amount of items in the cart

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.product.name)),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display Product Image
              Image.asset(widget.product.image,
                  height: 250, width: double.infinity, fit: BoxFit.cover),

              // Product Name
              SizedBox(height: 16),
              Text(widget.product.name,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),

              // Product Price
              SizedBox(height: 8),
              Text("\$${widget.product.price}",
                  style: TextStyle(fontSize: 20, color: Colors.green)),

              // Product Description (Placeholder)
              SizedBox(height: 16),
              Text(
                  "This is a detailed description of ${widget.product.name}. It is an amazing product that you will love!"),
              SizedBox(height: 16),

              // Add to Cart Button
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    // Check if the product is already in the cart
                    if (isProductInCart(widget.product)) {
                      setState(() {
                        _removeFromCart(widget.product);
                      });
                    } else {
                      setState(() {
                        addToCart(widget.product);
                      });
                    }

                    // Show a SnackBar with the notification
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          !isProductInCart(widget.product)
                              ? '${widget.product.name} removed from cart!'
                              : '${widget.product.name} added to cart!',
                          style: const TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.lightGreen,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  child: Text(
                    isProductInCart(widget.product)
                        ? "Remove from Cart"
                        : 'Add to Cart',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              // Reviews Section
              SizedBox(height: 32),
              ReviewSection(
                product: widget.product,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReviewSection extends StatefulWidget {
  final Product product;

  ReviewSection({required this.product});

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
    final List<Map<String, dynamic>> reviews = widget.product.reviews!;

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
              widget.product.reviews?.add({
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
