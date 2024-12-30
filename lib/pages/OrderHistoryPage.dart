import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Order History')),
        body: Center(
          child: Text('You must be logged in to view order history.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Order History'),
        backgroundColor: Colors.green,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('orders')
            .orderBy('orderDate', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No orders found.'));
          }

          return ListView(
            children: snapshot.data!.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;

              // Safely handling timestamp to DateTime conversion
              Timestamp timestamp = data['orderDate'];
              DateTime orderDate = timestamp.toDate();

              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text('Order ID: ${data['orderId']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Total: ₹${data['totalAmount']}'),
                      Text('Date: ${orderDate.toLocal()}'), // Properly format DateTime
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
