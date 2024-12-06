import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'HomeSection.dart';
import 'ProfileSection.dart';
import 'CartSection.dart';
import 'SearchSection.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;
  final List<Product> _cart = [];

  // Toggle dark mode
  void _toggleDarkMode(bool value) {
    setState(() {
      _isDarkMode = value;
    });
  }

  // Add product to the cart
  void addToCart(Product product) {
    setState(() {
      _cart.add(product);
    });
  }

  // Remove product from the cart
  void _removeFromCart(Product product) {
    setState(() {
      _cart.remove(product);
    });
  }

  // Calculate total amount of items in the cart
  double _getTotalAmount() {
    return _cart.fold(0.0, (sum, product) => sum + product.price);
  }

  // Clear the cart
  void _clearCart() {
    setState(() {
      _cart.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Udyojak',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: _isDarkMode ? Brightness.dark : Brightness.light,
        primaryColor: Colors.red,
        hintColor: Colors.white,
        textTheme: TextTheme(
          bodyMedium: TextStyle(
            fontSize: 16,
            color: _isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
      home: HomePage(
        isDarkMode: _isDarkMode,
        onDarkModeToggle: _toggleDarkMode,
        cart: _cart,
        addToCart: addToCart,
        removeFromCart: _removeFromCart,
        totalAmount: _getTotalAmount(),
        clearCart: _clearCart,  // Passing clearCart to HomePage
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) onDarkModeToggle;
  final List<Product> cart;
  final Function(Product) addToCart;
  final Function(Product) removeFromCart;
  final double totalAmount;
  final Function() clearCart; // Added clearCart function

  const HomePage({
    super.key,
    required this.isDarkMode,
    required this.onDarkModeToggle,
    required this.cart,
    required this.addToCart,
    required this.removeFromCart,
    required this.totalAmount,
    required this.clearCart,  // Passing clearCart function
  });

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getPage() {
    switch (_selectedIndex) {
      case 0:
        return HomeSection(addToCart: widget.addToCart);
      case 1:
        return SearchSection(
          addToCart: widget.addToCart,
          cart: widget.cart,
        );
      case 2:
        return CartSection(
          cart: widget.cart,
          removeFromCart: widget.removeFromCart,
          clearCart: widget.clearCart, // Passing clearCart to CartSection
          totalAmount: widget.totalAmount, // Pass totalAmount to CartSection
        );
      case 3:
        final user = FirebaseAuth.instance.currentUser;
        final username = user?.displayName ?? "User";
        final email = user?.email ?? "No email";

        return ProfileSection(
          isDarkMode: widget.isDarkMode,
          onDarkModeToggle: widget.onDarkModeToggle,
        );
      default:
        return HomeSection(addToCart: widget.addToCart);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Udyojak',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
        elevation: 5,
        actions: [
          IconButton(
            icon: Icon(
                widget.isDarkMode ? Icons.nightlight_round : Icons.wb_sunny),
            onPressed: () {
              widget.onDarkModeToggle(!widget.isDarkMode);
            },
          ),
        ],
      ),
      body: _getPage(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
