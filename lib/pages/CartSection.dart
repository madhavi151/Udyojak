import 'package:flutter/material.dart';
import 'HomeSection.dart';
import 'PaymentPage.dart';

class CartSection extends StatelessWidget {
  final List<Product> cart;
  final Function(Product) removeFromCart;
  final double totalAmount;

  const CartSection({
    super.key,
    required this.cart,
    required this.removeFromCart,
    required this.totalAmount,
  });

  void navigateToPayment(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentScreen(totalAmount: totalAmount),
      ),
    );
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
                  margin:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
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
              onPressed: () => navigateToPayment(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text(
                'Select Payment Method',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


