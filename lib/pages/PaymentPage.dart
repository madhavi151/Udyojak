import 'package:flutter/material.dart';
import 'OrderConfirmationScreen.dart'; // Import the order confirmation screen

class PaymentScreen extends StatelessWidget {
  final double totalAmount;
  final List<dynamic> cart; // Add cart as a parameter

  const PaymentScreen({super.key, required this.totalAmount, required this.cart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Payment Method'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Total Amount to Pay: ₹$totalAmount',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            SizedBox(height: 30),
            Divider(),
            // Cash on Delivery Button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderConfirmationScreen(
                      paymentMethod: 'Cash on Delivery',
                      totalAmount: totalAmount,
                      cart: cart,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange, // COD button color
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text(
                'Cash on Delivery (COD)',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            SizedBox(height: 10),
            // Razorpay Button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderConfirmationScreen(
                      paymentMethod: 'Razorpay',
                      totalAmount: totalAmount,
                      cart: cart,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Razorpay button color
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text(
                'Pay via Razorpay',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

