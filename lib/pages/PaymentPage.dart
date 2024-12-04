import 'package:flutter/material.dart';
import 'OrderConfirmationScreen.dart';

class PaymentScreen extends StatelessWidget {
  final double totalAmount;

  const PaymentScreen({super.key, required this.totalAmount});

  void placeOrder(BuildContext context, String paymentMethod) {
    // Navigate to a confirmation screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderConfirmationScreen(
          paymentMethod: paymentMethod,
          totalAmount: totalAmount,
        ),
      ),
    );
  }

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
              'Total Amount to Pay',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '₹$totalAmount',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            SizedBox(height: 30),
            Divider(),
            ElevatedButton(
              onPressed: () => placeOrder(context, 'Cash on Delivery'),
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
            ElevatedButton(
              onPressed: () => placeOrder(context, 'Razorpay'),
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