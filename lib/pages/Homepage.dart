import 'package:Udyojak/pages/data/datalists.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'HomeSection.dart';
import 'ProfileSection.dart';
import 'CartSection.dart';
import 'SearchSection.dart';
import 'package:google_fonts/google_fonts.dart';

final List<Product> cart = [];

class LoginSuccess extends StatefulWidget {
  const LoginSuccess({super.key});

  @override
  _LoginSuccessState createState() => _LoginSuccessState();
}

class _LoginSuccessState extends State<LoginSuccess> {
  bool _isDarkMode = false;

  // Toggle dark mode
  void _toggleDarkMode(bool value) {
    setState(() {
      _isDarkMode = value;
    });
  }

  // Add product to the cart
  void addToCart(Product product) {
    setState(() {
      cart.add(product);
    });
  }

  // Remove product from the cart
  void _removeFromCart(Product product) {
    setState(() {
      cart.remove(product);
    });
  }

  // Calculate total amount of items in the cart
  double _getTotalAmount() {
    return cart.fold(0.0, (sum, product) => sum + product.price);
  }

  // Clear the cart
  void _clearCart() {
    setState(() {
      cart.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Udyojak',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: _isDarkMode ? Brightness.dark : Brightness.light,
        primaryColor: Colors.green,
        hintColor: Colors.white,
        textTheme: TextTheme(
          bodyMedium: GoogleFonts.mcLaren(
            fontSize: 16,
            color: _isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
      home: HomePage(
        isDarkMode: _isDarkMode,
        onDarkModeToggle: _toggleDarkMode,
        cart: cart,
        addToCart: addToCart,
        removeFromCart: _removeFromCart,
        totalAmount: _getTotalAmount(),
        clearCart: _clearCart,
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
    required this.clearCart, // Passing clearCart function
  });

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Dismiss the keyboard when switching tabs
  void _onItemTapped(int index) {
    FocusScope.of(context).unfocus(); // This dismisses the keyboard

    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getPage() {
    switch (_selectedIndex) {
      case 0:
        return HomeSection(
          addToCart: widget.addToCart,
          cart: widget.cart,
        );
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
        return HomeSection(
          addToCart: widget.addToCart,
          cart: widget.cart,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = widget.isDarkMode;
    final selectedColor =
        isDarkMode ? Colors.lightBlueAccent : Colors.deepOrange;
    final unselectedColor = isDarkMode ? Colors.grey : Colors.black45;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        _showExitDialog();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Udyojak',
            style: GoogleFonts.mcLaren(
              fontWeight: FontWeight.bold,
              fontSize: 30, // Larger font size for better visibility
              letterSpacing:
                  1.2, // Adds some space between letters for a more refined look
              shadows: [
                const BoxShadow(
                  color: Colors.black26, // Subtle shadow for better readability
                  offset: Offset(0, 1), // Slight downward shadow
                  blurRadius: 3, // Soft shadow
                ),
              ],
            ),
          ),
          centerTitle: true,
          backgroundColor: isDarkMode
              ? Colors.green[900]
              : Colors.green[600], // Darker shades for more professionalism
          elevation: 5, // Keeps the shadow subtle for a sleek look
          actions: [
            IconButton(
              icon: Icon(
                isDarkMode ? Icons.nightlight_round : Icons.wb_sunny,
                size: 28, // Slightly larger icon size for better visibility
              ),
              onPressed: () {
                widget.onDarkModeToggle(!isDarkMode);
              },
            ),
          ],
        ),
        body: _getPage(),
        bottomNavigationBar: Container(
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.grey[850] : Colors.white,
            // Background color
            borderRadius: BorderRadius.circular(25),
            // Rounded corners
            boxShadow: [
              BoxShadow(
                color: isDarkMode
                    ? Colors.white.withOpacity(0.3)
                    : Colors.black
                        .withOpacity(0.2), // White shadow for dark mode
                blurRadius: 10, // Blur effect for the shadow
                offset: const Offset(0, 4), // Shadow offset (slightly below)
              ),
            ],
          ),
          child: Material(
            elevation: 5,
            // Set elevation to 5 for the card-like effect
            borderRadius: BorderRadius.circular(25),
            // Keep rounded corners for the Material
            child: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              selectedItemColor: selectedColor,
              unselectedItemColor: unselectedColor,
              backgroundColor: Colors.transparent,
              // Make the background transparent
              elevation: 0,
              items: [
                const BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const Icon(Icons.shopping_cart),
                      if (widget.cart.isNotEmpty) ...[
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 18,
                              minHeight: 18,
                            ),
                            child: Text(
                              widget.cart.length.toString(),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  label: 'Cart',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
              type: BottomNavigationBarType.fixed,
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _showExitDialog() async {
    return (await showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text('Exit App'),
            content: Text('Do you really want to exit the app?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                  SystemNavigator.pop();
                },
                child: Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }
}
