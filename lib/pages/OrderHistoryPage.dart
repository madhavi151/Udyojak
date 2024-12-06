import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the current logged-in user's ID from Firebase Authentication
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    // Ensure user is logged in
    if (userId.isEmpty) {
      return Scaffold(
        body: Center(
          child: Text('Please log in to view your order history.'),
        ),
      );
    }

    // Fetch orders for the logged-in user from Firestore
    CollectionReference orders = FirebaseFirestore.instance.collection('users').doc(userId).collection('orders');

    return Scaffold(
      appBar: AppBar(
        title: const Text("Order History"),
        backgroundColor: Colors.red,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: orders.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No orders available.'));
          }

          // Extract order data from Firestore snapshot
          var orderHistory = snapshot.data!.docs.map((doc) {
            return doc.data() as Map<String, dynamic>;
          }).toList();

          return ListView.builder(
            itemCount: orderHistory.length,
            itemBuilder: (context, index) {
              var order = orderHistory[index];
              return Card(
                margin: const EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Order ID and Date
                      _buildOrderDetail(
                        'Order ID: ${order['orderId'] ?? 'N/A'}',
                        'Date: ${_formatDate(order['orderDate'])}',
                      ),
                      _buildOrderDetail(
                        'Total Amount: ₹${order['totalAmount'] ?? 'N/A'}',
                        '',
                      ),
                      const SizedBox(height: 12),

                      // Product List
                      const Text(
                        'Products:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildProductList(order['products']),

                      const SizedBox(height: 8),
                      // Divider to separate different orders
                      const Divider(color: Colors.grey),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  // Helper function to format date
  String _formatDate(Timestamp? timestamp) {
    if (timestamp == null) return 'N/A';
    DateTime date = timestamp.toDate();
    return "${date.day}-${date.month}-${date.year} ${date.hour}:${date.minute}";
  }

  // Build a list of products in the order
  Widget _buildProductList(dynamic products) {
    if (products == null || products.isEmpty) {
      return const Text('No products available');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        products.length,
            (index) {
          var product = products[index];
          return Text(
            '- ${product['name'] ?? 'Unknown Product'} x${product['quantity'] ?? 0}',
            style: const TextStyle(fontSize: 14),
          );
        },
      ),
    );
  }

  // Helper function to create a reusable order detail
  Widget _buildOrderDetail(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          if (subtitle.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                subtitle,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
        ],
      ),
    );
  }
}
