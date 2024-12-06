import 'package:flutter/material.dart';
import 'PaymentPage.dart';

class DeliveryDetailsPage extends StatefulWidget {
  final double totalAmount;
  final Function(String, String, bool) onSubmit;

  const DeliveryDetailsPage({
    super.key,
    required this.totalAmount,
    required this.onSubmit,
  });

  @override
  _DeliveryDetailsPageState createState() => _DeliveryDetailsPageState();
}

class _DeliveryDetailsPageState extends State<DeliveryDetailsPage> {
  final _addressController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  bool _isDoorstepDelivery = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Delivery Details'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(
                labelText: 'Delivery Address',
                hintText: 'Enter your delivery address',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _phoneNumberController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                hintText: 'Enter your phone number',
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  value: _isDoorstepDelivery,
                  onChanged: (value) {
                    setState(() {
                      _isDoorstepDelivery = value!;
                    });
                  },
                ),
                const Text('Doorstep Delivery'),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_addressController.text.isNotEmpty && _phoneNumberController.text.isNotEmpty) {
                  widget.onSubmit(
                    _addressController.text,
                    _phoneNumberController.text,
                    _isDoorstepDelivery,
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentScreen(totalAmount: widget.totalAmount, cart: [],),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill in all fields')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: Size(double.infinity, 50),
              ),
              child: const Text(
                'Proceed to Payment',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
