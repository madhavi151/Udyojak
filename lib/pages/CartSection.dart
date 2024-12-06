import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'DeliveryDetailsPage.dart'; // Your delivery details screen
import 'PaymentPage.dart'; // Payment screen for selecting the payment method
import 'HomeSection.dart'; // If needed for navigation

class CartSection extends StatelessWidget {
  final List<Product> cart;
  final Function(Product) removeFromCart;
  final Function() clearCart;
  final double totalAmount;

  const CartSection({
    super.key,
    required this.cart,
    required this.removeFromCart,
    required this.clearCart,
    required this.totalAmount,
  });

  // Method to navigate to the payment screen
  void navigateToPaymentScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentScreen(
          totalAmount: totalAmount,
          cart: cart,
        ),
      ),
    );
  }

  // Method to save the order to Firestore
  Future<void> saveOrderToFirestore(
      String address, String phoneNumber, bool isDoorstepDelivery) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print('User not logged in');
      return;
    }

    try {
      // Save the order details in Firestore
      await FirebaseFirestore.instance.collection('users').doc(user.uid).collection('orders').add({
        'orderId': DateTime.now().millisecondsSinceEpoch.toString(),
        'products': cart.map((product) => {
          'name': product.name,
          'price': product.price,
          'image': product.image,  // Including image if needed
        }).toList(),
        'totalAmount': totalAmount,
        'address': address,
        'phoneNumber': phoneNumber,
        'isDoorstepDelivery': isDoorstepDelivery,
        'orderDate': DateTime.now(),
      });
      print('Order saved to Firestore');
    } catch (e) {
      print('Error saving order: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Expanded(
            child: cart.isEmpty
                ? Center(
              child: Text(
                'Your cart is empty!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            )
                : ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(8),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        cart[index].image,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(cart[index].name),
                    subtitle: Text('₹${cart[index].price}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete_forever),
                      onPressed: () {
                        removeFromCart(cart[index]);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Subtotal',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '₹$totalAmount',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: cart.isEmpty
                  ? null // Disable the button if cart is empty
                  : () {
                // Open the delivery details page, and when the order is submitted,
                // navigate to the payment screen
                navigateToPaymentScreen(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: cart.isEmpty ? Colors.grey : Colors.green, // Change color if empty
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text(
                'Proceed to Payment',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
