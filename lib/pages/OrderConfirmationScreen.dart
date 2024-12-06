import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'OrderHistoryPage.dart'; // Import the OrderHistoryPage

class OrderConfirmationScreen extends StatefulWidget {
  final String paymentMethod;
  final double totalAmount;
  final List<dynamic> cart;

  const OrderConfirmationScreen({
    super.key,
    required this.paymentMethod,
    required this.totalAmount,
    required this.cart,
  });

  @override
  _OrderConfirmationScreenState createState() => _OrderConfirmationScreenState();
}

class _OrderConfirmationScreenState extends State<OrderConfirmationScreen> {
  // Method to save the order to Firestore
  Future<void> saveOrderToFirestore() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print('User not logged in');
      return;
    }

    try {
      // Save the order details in Firestore
      await FirebaseFirestore.instance.collection('users').doc(user.uid).collection('orders').add({
        'orderId': DateTime.now().millisecondsSinceEpoch.toString(),
        'products': widget.cart.map((product) => {
          'name': product['name'],
          'price': product['price'],
          'quantity': product['quantity'],
        }).toList(),
        'totalAmount': widget.totalAmount,
        'paymentMethod': widget.paymentMethod,
        'orderDate': DateTime.now(),
      });
      print('Order saved to Firestore');
    } catch (e) {
      print('Error saving order: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    // Save the order when the screen is initialized
    saveOrderToFirestore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Confirmation'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Your Order has been placed!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            SizedBox(height: 20),
            Text(
              'Payment Method: ${widget.paymentMethod}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Total Amount: ₹${widget.totalAmount}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 30),
            Text(
              'Cart Details:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: widget.cart.length,
                itemBuilder: (context, index) {
                  final item = widget.cart[index];
                  return ListTile(
                    title: Text(item['name']),
                    subtitle: Text('Quantity: ${item['quantity']} | Price: ₹${item['price']}'),
                  );
                },
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // After confirmation, navigate to the order history page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OrderHistoryPage()), // Navigate to the Order History Page
                );
              },
              child: const Text('Go to Order History'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
