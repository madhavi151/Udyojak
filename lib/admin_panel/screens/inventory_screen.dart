import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  
  

  Stream<List<Map<String, dynamic>>> get inventoryList => Supabase.instance.client.from('inventory').stream(primaryKey: ['id']);
  void _incrementQuantity(int index) {
    
  }

  void _decrementQuantity(int index) {
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Back button icon
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
        ),
        title: const Text('Inventory'),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: StreamBuilder<List<Map<String,dynamic>>>(
        stream: inventoryList,
        builder: (context,snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      'No products added yet!',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  );
                }
                final products = snapshot.data!;
                return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context,index){
                    final product = products[index];
                    return Card(
              color: Colors.green[50],
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product['product_name'],
                      style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        
                        Text(
                          '${product['quantity']}',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        
                      ],
                    ),
                  ],
                ),
              ),
            );
                  }
                  
                  );
        },
        )
    );
  }
}

