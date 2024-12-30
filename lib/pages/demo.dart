// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// import 'package:google_fonts/google_fonts.dart';

// class Product {
//   final String name;
//   final String image;
//   final double price;

//   Product({required this.name, required this.image, required this.price});

//   // Add a factory constructor to create a Product object from Firestore document
//   factory Product.fromFirestore(DocumentSnapshot doc) {
//     return Product(
//       name: doc['name'],
//       image: doc['image'],
//       price: doc['price'].toDouble(),
//     );
//   }
// }

// class HomeSection extends StatefulWidget {
//   final Function(Product) addToCart;
//   final List<Product> cart;

//   HomeSection({super.key, required this.addToCart, required this.cart});

//   @override
//   State<HomeSection> createState() => _HomeSectionState();
// }

// class _HomeSectionState extends State<HomeSection> {
//   late Future<List<Product>> _productsFuture;

//   @override
//   void initState() {
//     super.initState();
//     _productsFuture = fetchProducts();
//   }

//   // Fetch product data from Firestore
//   Future<List<Product>> fetchProducts() async {
//     final snapshot =
//         await FirebaseFirestore.instance.collection('products').get();
//     return snapshot.docs.map((doc) => Product.fromFirestore(doc)).toList();
//   }

//   bool isAdded = false;

//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: false,
//       onPopInvokedWithResult: (didPop, result) {
//         _showExitDialog();
//       },
//       child: FutureBuilder<List<Product>>(
//         future: _productsFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//                 child: CircularProgressIndicator()); // Show loading indicator
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No products available'));
//           }

//           final products = snapshot.data!;

//           return SingleChildScrollView(
//             child:
//                 Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//               ///Featured products
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Text(
//                   'Featured Products',
//                   style: GoogleFonts.mcLaren(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Theme.of(context).brightness == Brightness.dark
//                         ? Colors.white
//                         : Colors.black87,
//                   ),
//                 ),
//               ),
//               ListView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: products.length,
//                 itemBuilder: (context, index) {
//                   final product = products[index];
//                   final isAdded = widget.cart.contains(product);

//                   return GestureDetector(
//                     onTap: () {
//                       widget.addToCart(products[index]);
//                     },
//                     child: Card(
//                       elevation: 5, // Shadow for the card
//                       margin: const EdgeInsets.symmetric(
//                           vertical: 8, horizontal: 10),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           // Product Image
//                           ClipRRect(
//                             borderRadius: BorderRadius.circular(10),
//                             child: Image.network(
//                               product.image, // Use network image URL
//                               width: 80,
//                               height: 80,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                           const SizedBox(
//                               width: 16), // Spacing between image and details
//                           // Product Details
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   product.name,
//                                   style: GoogleFonts.mcLaren(
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.bold,
//                                     color: Theme.of(context).brightness ==
//                                             Brightness.dark
//                                         ? Colors.white
//                                         : Colors.black87,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 5),
//                                 Text(
//                                   '₹${product.price}',
//                                   style: GoogleFonts.mcLaren(
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.w500,
//                                     color: Theme.of(context).brightness ==
//                                             Brightness.dark
//                                         ? Colors.green[300]
//                                         : Colors.green,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           // Add to Cart Button
//                           Padding(
//                             padding: const EdgeInsets.only(right: 8.0),
//                             child: ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.green,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                               ),
//                               onPressed: () {
//                                 widget.addToCart(products[index]);

//                                 // Show a SnackBar with the notification
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   SnackBar(
//                                     content: Text(
//                                       '${products[index].name} added to cart!',
//                                       style:
//                                           const TextStyle(color: Colors.white),
//                                     ),
//                                     backgroundColor: Colors.lightGreen,
//                                     duration: const Duration(seconds: 2),
//                                   ),
//                                 );
//                               },
//                               child: Text(
//                                 isAdded ? "Added" : 'Add to Cart',
//                                 style: GoogleFonts.mcLaren(color: Colors.white),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ]),
//           );
//         },
//       ),
//     );
//   }

//   Future<bool> _showExitDialog() async {
//     return (await showDialog(
//           context: context,
//           builder: (BuildContext context) => AlertDialog(
//             title: Text('Exit App'),
//             content: Text('Do you really want to exit the app?'),
//             actions: <Widget>[
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop(false);
//                 },
//                 child: Text('No'),
//               ),
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop(true);
//                   SystemNavigator.pop();
//                 },
//                 child: Text('Yes'),
//               ),
//             ],
//           ),
//         )) ??
//         false;
//   }
// }
