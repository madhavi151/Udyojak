import 'package:Udyojak/pages/data/datalists.dart';
import 'package:flutter/material.dart';


class SearchSection extends StatefulWidget {
  final Function(Product) addToCart;
  final List<Product> cart;

  const SearchSection({super.key, required this.addToCart, required this.cart});

  @override
  _SearchSectionState createState() => _SearchSectionState();
}

class _SearchSectionState extends State<SearchSection> {
  final TextEditingController _searchController = TextEditingController();
  List<Product> filteredProducts = [];

  final List<Product> allProducts = [
    Product(
        name: "Scrunchies",
        image: "assets/image/scrunchies.webp",
        price: 299.99),
    Product(
        name: "Paper Quilling",
        image: "assets/image/paper_quilling.webp",
        price: 150.00),
    Product(name: "Waffles", image: "assets/image/waffles.jpg", price: 100.00),
    Product(name: "Gift", image: "assets/image/handcrafts.webp", price: 249.99),
  ];

  @override
  void initState() {
    super.initState();
    filteredProducts = allProducts;
  }

  void _filterProducts(String query) {
    setState(() {
      filteredProducts = query.isEmpty
          ? allProducts
          : allProducts
              .where((product) =>
                  product.name.toLowerCase().contains(query.toLowerCase()))
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search products',
                labelStyle: TextStyle(
                    color: isDarkMode ? Colors.white70 : Colors.black54),
                prefixIcon: Icon(Icons.search,
                    color: isDarkMode ? Colors.white70 : Colors.black54),
                filled: true,
                fillColor: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
              onChanged: _filterProducts,
            ),
          ),
          Expanded(
            child: filteredProducts.isEmpty
                ? Center(
                    child: Text(
                      'No products found!',
                      style: TextStyle(
                        fontSize: 18,
                        color: isDarkMode ? Colors.white70 : Colors.grey[700],
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      final isAdded = widget.cart.contains(product);

                      return Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        color: isDarkMode ? Colors.grey[850] : Colors.white,
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(10),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              product.image,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            product.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                          subtitle: Text(
                            '₹${product.price.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: isDarkMode
                                  ? Colors.white70
                                  : Colors.grey[700],
                              fontSize: 14,
                            ),
                          ),
                          trailing: ElevatedButton(
                            onPressed: () {
                              if (!isAdded) {
                                widget.addToCart(product);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text('${product.name} added to cart!'),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor: isAdded
                                  ? (isDarkMode
                                      ? Colors.green[700]
                                      : Colors.lightGreen)
                                  : (isDarkMode
                                      ? Colors.green[700]
                                      : Colors.lightGreen),
                            ),
                            child: Text(
                              isAdded ? 'Added' : 'Add to Cart',
                              style: TextStyle(
                                fontSize: 14,
                                color: isDarkMode ? Colors.white : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
