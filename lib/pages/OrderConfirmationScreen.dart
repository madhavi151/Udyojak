import 'package:flutter/material.dart';

class OrderConfirmationScreen extends StatelessWidget {
  final String paymentMethod;
  final double totalAmount;

  const OrderConfirmationScreen({
    super.key,
    required this.paymentMethod,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Confirmation'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Order Placed Successfully!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Payment Method: $paymentMethod',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Total Amount: ₹$totalAmount',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Navigate back to the previous screen
              },
              child: const Text('Go to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
