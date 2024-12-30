import 'package:Udyojak/admin_panel//screens/inventory_screen.dart';
import 'package:flutter/material.dart';
import 'product_management_screen.dart';
import 'order_management_screen.dart';
import 'user_management_screen.dart';

class DashboardScreen extends StatelessWidget {
  final String business;
  const DashboardScreen({super.key, required this.business});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${business} Admin Dashboard'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
          ),
          children: [
            AdminCard(
              title: 'Products',
              icon: Icons.shopping_bag,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductManagementScreen(business: business,)),
                );
              },
            ),
            AdminCard(
              title: 'Orders',
              icon: Icons.receipt,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrderManagementScreen(business: business,)),
                );
              },
            ),
            AdminCard(
              title: 'Inventory',
              icon: Icons.inventory_outlined,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InventoryPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AdminCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const AdminCard({super.key, required this.title, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4.0,
        color: Colors.green[100],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40.0),
              const SizedBox(height: 8.0),
              Text(title, style: const TextStyle(fontSize: 18.0)),
            ],
          ),
        ),
      ),
    );
  }
}
