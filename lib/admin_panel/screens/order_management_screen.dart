import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OrderManagementScreen extends StatefulWidget {
  const OrderManagementScreen({super.key, required this.business});
  final String business;

  @override
  _OrderManagementScreenState createState() => _OrderManagementScreenState();
}

class _OrderManagementScreenState extends State<OrderManagementScreen> {
  Stream<List<Map<String, dynamic>>> get orderList => Supabase.instance.client
      .from('orders')
      .stream(primaryKey: ['id'])
      .eq('business_id', widget.business);

  void _updateOrderStatusWithReason(Map<String, dynamic> order, String newStatus) {
    final TextEditingController reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Provide Reason'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Why are you marking this order as $newStatus?'),
              const SizedBox(height: 8),
              TextField(
                controller: reasonController,
                decoration: const InputDecoration(
                  labelText: 'Reason',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final String reason = reasonController.text.trim();
                if (reason.isNotEmpty) {
                  try {
                    await Supabase.instance.client.from('orders').update({
                      'status': newStatus,
                      'reason': reason,
                    }).eq('id', order['id']);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'Order ${order['id']} marked as $newStatus with reason: "$reason"'),
                      ),
                    );
                    Navigator.of(context).pop();
                  } catch (error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Failed to update order: $error'),
                      ),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Reason cannot be empty.'),
                    ),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Management'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: orderList,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.data!.isEmpty) {
            return const Center(child: Text('No orders available.'));
          }

          final orders = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Order ID: ${order['id']}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green[700],
                            ),
                          ),
                          DropdownButton<String>(
                            value: order['status'],
                            items: ['Pending', 'Accepted', 'Declined'].map((status) {
                              return DropdownMenuItem<String>(
                                value: status,
                                child: Text(status),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null && value != order['status']) {
                                _updateOrderStatusWithReason(order, value);
                              }
                            },
                          ),
                        ],
                      ),
                      Divider(color: Colors.grey[300]),
                      const SizedBox(height: 8),
                      Text('Customer: ${order['customer_name']}',
                          style: const TextStyle(fontSize: 14)),
                      Text('Phone: ${order['phone_no']}',
                          style: const TextStyle(fontSize: 14)),
                      Text('Product: ${order['product']}',
                          style: const TextStyle(fontSize: 14)),
                      Text('Quantity: ${order['quantity']}',
                          style: const TextStyle(fontSize: 14)),
                      Text('Total: ₹${order['price']}',
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                      Text('Address: ${order['address']}',
                          style: const TextStyle(fontSize: 14)),
                      if (order['reason'] != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            'Reason: ${order['reason']}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.red,
                            ),
                          ),
                        ),
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
}
