import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'OrderHistoryPage.dart'; // Import the order history page
import 'HomeSection.dart';
import 'data/datalists.dart';

class CartSection extends StatefulWidget {
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

  @override
  _CartSectionState createState() => _CartSectionState();
}
class _CartSectionState extends State<CartSection> {
  bool _isLoading = false;
  bool isCOD = false; // Track if Cash on Delivery is selected

  // User data
  String email = '';
  String mobileNumber = '';
  String address = '';

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  // Fetch user data from Firestore
  Future<void> _fetchUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          setState(() {
            email = user.email ?? '';
            mobileNumber = userDoc['mobileNumber'] ?? '';
            address = userDoc['address'] ?? '';
          });
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to fetch user data: $e')),
        );
      }
    }
  }

  // Method to save the order to Firestore
  Future<void> saveOrderToFirestore(
      String address,
      String phoneNumber,
      bool isDoorstepDelivery,
      bool isCOD,
      ) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You must be logged in to place an order.')),
      );
      return;
    }

    try {
      setState(() => _isLoading = true);

      // Save order to Firestore
      final orderData = {
        'userId': user.uid,
        'email': user.email,
        'address': address,
        'phoneNumber': phoneNumber,
        'isDoorstepDelivery': isDoorstepDelivery,
        'isCOD': isCOD,
        'totalAmount': widget.totalAmount,
        'products': widget.cart.map((product) {
          return {
            'name': product.name,
            'price': product.price,
            'image': product.image,
          };
        }).toList(),
        'timestamp': FieldValue.serverTimestamp(),
      };

      // Add order to the "orders" collection
      await FirebaseFirestore.instance.collection('orders').add(orderData);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Order placed successfully!')),
      );

      // Clear the cart after order is placed
      widget.clearCart();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save order: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              // Navigate to the order history page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OrderHistoryPage()),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: widget.cart.isEmpty
                    ? Center(
                  child: Text(
                    'Your cart is empty!',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                )
                    : ListView.builder(
                  itemCount: widget.cart.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            widget.cart[index].image,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(widget.cart[index].name),
                        subtitle: Text('₹${widget.cart[index].price}'),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            widget.removeFromCart(widget.cart[index]);
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
                      '₹${widget.totalAmount}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              // COD Option Section - Add the Checkbox here
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Text(
                      'Cash on Delivery (COD)',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Checkbox(
                      value: isCOD,
                      onChanged: (bool? value) {
                        setState(() {
                          isCOD = value ?? false;  // Update the state when the checkbox is toggled
                        });
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: widget.cart.isEmpty
                      ? null
                      : () {
                    // Simulate placing an order with COD
                    saveOrderToFirestore(
                      address,  // Use the fetched address
                      mobileNumber,  // Use the fetched mobile number
                      true, // Doorstep delivery
                      isCOD, // Pass the COD selection
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text(
                    'Place Order',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
