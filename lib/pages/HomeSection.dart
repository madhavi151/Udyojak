import 'package:flutter/material.dart';
import 'ServiceDetailPage.dart';
import 'AllServicePage.dart';
import 'BusinessDetailPage.dart';
import 'AllBusinessesPage.dart';

class Product {
  final String name;
  final String image;
  final double price;

  Product({required this.name, required this.image, required this.price});
}

class HomeSection extends StatelessWidget {
  final Function(Product) addToCart;

  HomeSection({super.key, required this.addToCart});

  ///Categories Section


  ///Products Section
  final List<Product> products = [
    Product(name: "Scrunchies", image: "assets/image/scrunchies.webp", price: 30),
    Product(name: "Paper Quilling", image: "assets/image/paper_quilling.webp",price: 150),
    Product(name: "Waffles", image: "assets/image/waffles.jpg", price: 100),
    Product(name: "Gift", image: "assets/image/handcrafts.webp", price: 300),

  ];

  ///Business Section
  final List<Map<String, dynamic>> recommendedBusinesses = [
    {
      "name": "Arted",
      "image": "assets/image/Artdea.png",
      "email": "pratikshankdm@gmail.com",
      "description": "Find the best frames,keychains.",
      "contactNo": "1234567890",
      "address": "123 Fashion Street, City Name",
      "products": [
        Product(name: "Frames", image: "assets/image/cloth.jpg", price: 799.99),
        Product(
            name: "keychains", image: "assets/image/cloth.jpg", price: 499.99),
        Product(
            name: "HandCraft Gifts",
            image: "assets/image/cloth.jpg",
            price: 899.99),
        Product(
            name: "3D Frames", image: "assets/image/cloth.jpg", price: 1299.99),
        Product(
            name: "Paintings", image: "assets/image/cloth.jpg", price: 1999.99),
        Product(
            name: "Raisins Frames",
            image: "assets/image/cloth.jpg",
            price: 1999.99),
      ],
    },
    {
      "name": "Dessert Junction",
      "image": "assets/image/dessertjunction.jpg",
      "email": "nandinisharma7577@gmail.com",
      "description":  "Its a desserts kitchen where I make cakes and desserts, cookies, muffins, cupcakes,and chocolates",
      "contactNo": "9819704760",
      "address": "Malad west",
      "products": [
        Product(
            name: "Chocolate Dutch truffle",
            image: "assets/image/truffle.jpg",
            price: 1350),
        Product(
            name: "Black forest",
            image: "assets/image/blackforest.jpg",
            price: 1200),
        Product(
            name: "Chocolate with caramel",
            image: "assets/image/caramel1.jpg",
            price: 1500),
        Product(
            name: "Chocolate with Strawberry",
            image: "assets/image/strawberry.jpg",
            price: 1500),
        Product(name: "Mix fruit cake ", image: "assets/image/mixfruit.jpg", price: 1250),
        Product(name: "Pineapple cake ", image: "assets/image/pineapple.jpg", price: 1100),
        Product(name: "Butter scotch cake ", image: "assets/image/butter.jpg", price: 990),
        Product(name: "Biscoff cheese ", image: "assets/image/biscoff.jpg", price: 2100),
        Product(name: "Blueberry cheesecake", image: "assets/image/bluecake.jpg", price: 1850),



      ],
    },
    {
      "name": "Modern Heel 2",
      "image": "assets/image/footwear.jpg",
      "email": "danishamaitar6@gmail.com",
      "description":
      "We sell branded women footwear all type of  footwear are available in modern heels 2.",
      "contactNo": "9930841181",
      "address": "lokhandwala market",
      "products": [
        Product(
            name: "Fashion Heels",
            image: "assets/image/cloth.jpg",
            price: 799.99),
        Product(
            name: "Flip Flops", image: "assets/image/cloth.jpg", price: 499.99),
        Product(
            name: "Block Heels",
            image: "assets/image/cloth.jpg",
            price: 899.99),
        Product(
            name: "High Heel Boots",
            image: "assets/image/cloth.jpg",
            price: 1299.99),
        Product(
            name: "High Cone Heels",
            image: "assets/image/cloth.jpg",
            price: 1999.99),
      ],
    },
    {
      "name": "Shiv Shakti Collections",
      "image": "assets/image/wall_art.jpg",
      "email": "anamikachaurasiya1722@gmail.com",
      "description":
      "Girls fashionable products like scrunchies, light watch, beautiful bracelets, lockets, stylish things are available under us",
      "contactNo": "8591088076",
      "address": "Goregaon West Mumbai ",
      "products": [
        Product(
            name: "Scrunchies",
            image: "assets/image/scrunchies.webp",
            price: 799.99),
        Product(
            name: "Light Watch",
            image: "assets/image/cloth.jpg",
            price: 499.99),
        Product(
            name: "Bracelets", image: "assets/image/bracelets.jpg", price: 250),
        Product(
            name: "Lockets", image: "assets/image/locket.jpg", price: 160),
        Product(
            name: "Decoration of Ganapati Festival",
            image: "assets/image/cloth.jpg",
            price: 1999.99),
      ],
    },
  ];

  ///Services Section
  final List<Map<String, dynamic>> recommendedServices = [
    {
      "name": "Beauty World",
      "image": "assets/image/footwear.jpg",
      "email": "@gmail.com",
      "description":
      "We sell branded women footwear all type of  footwear are available in modern heels 2.",
      "contactNo": "9930841181",
      "address": "lokhandwala market",
      'services': [
        {
          'image': 'assets/image/wall_art.jpg',
          'name': 'Service 1',
          'price': 500.0,
        },
        {
          'image': 'assets/image/wall_art.jpg',
          'name': 'Service 2',
          'price': 300.0,
        },
      ],
    },
    {
      "name": "SM Photography",
      "image": "assets/image/footwear.jpg",
      "email": "@gmail.com",
      "description":
      "We sell branded women footwear all type of  footwear are available in modern heels 2.",
      "contactNo": "9930841181",
      "address": "lokhandwala market",
      'services': [
        {
          'image': 'assets/image/wall_art.jpg',
          'name': 'Service 1',
          'price': 500.0,
        },
        {
          'image': 'assets/image/wall_art.jpg',
          'name': 'Service 2',
          'price': 300.0,
        },
      ],
    },
    {
      "name": "Vrindavan Doodh Viarak",
      "image": "assets/image/footwear.jpg",
      "email": "danishamaitar6@gmail.com",
      "description":
      "We sell branded women footwear all type of  footwear are available in modern heels 2.",
      "contactNo": "9930841181",
      "address": "lokhandwala market",
      'services': [
        {
          'image': 'assets/image/wall_art.jpg',
          'name': 'Service 1',
          'price': 500.0,
        },
        {
          'image': 'assets/image/wall_art.jpg',
          'name': 'Service 2',
          'price': 300.0,
        },
      ],
    },
    {
      "name": "Artworks",
      "image": "assets/image/footwear.jpg",
      "email": "danishamaitar6@gmail.com",
      "description": "Mehndi Designs,Paintings",
      "contactNo": "9930841181",
      "address": "lokhandwala market",
      'services': [
        {
          'image': 'assets/image/wall_art.jpg',
          'name': 'Service 1',
          'price': 500.0,
        },
        {
          'image': 'assets/image/wall_art.jpg',
          'name': 'Service 2',
          'price': 300.0,
        },
      ],
    },
    {
      "name": "Artworks",
      "image": "assets/image/footwear.jpg",
      "email": "danishamaitar6@gmail.com",
      "description": "Mehndi Designs,Paintings",
      "contactNo": "9930841181",
      "address": "lokhandwala market",
      'services': [
        {
          'image': 'assets/image/wall_art.jpg',
          'name': 'Service 1',
          'price': 500.0,
        },
        {
          'image': 'assets/image/wall_art.jpg',
          'name': 'Service 2',
          'price': 300.0,
        },
      ],
    },
    {
      "name": "Artworks",
      "image": "assets/image/footwear.jpg",
      "email": "danishamaitar6@gmail.com",
      "description": "Mehndi Designs,Paintings",
      "contactNo": "9930841181",
      "address": "lokhandwala market",
      'services': [
        {
          'image': 'assets/image/wall_art.jpg',
          'name': 'Service 1',
          'price': 500.0,
        },
        {
          'image': 'assets/image/wall_art.jpg',
          'name': 'Service 2',
          'price': 300.0,
        },
      ],
    },
    {
      "name": "Artworks",
      "image": "assets/image/footwear.jpg",
      "email": "danishamaitar6@gmail.com",
      "description": "Mehndi Designs,Paintings",
      "contactNo": "9930841181",
      "address": "lokhandwala market",
      'services': [
        {
          'image': 'assets/image/wall_art.jpg',
          'name': 'Service 1',
          'price': 500.0,
        },
        {
          'image': 'assets/image/wall_art.jpg',
          'name': 'Service 2',
          'price': 300.0,
        },
      ],
    },
    {
      "name": "Artworks",
      "image": "assets/image/footwear.jpg",
      "email": "danishamaitar6@gmail.com",
      "description": "Mehndi Designs,Paintings",
      "contactNo": "9930841181",
      "address": "lokhandwala market",
      'services': [
        {
          'image': 'assets/image/wall_art.jpg',
          'name': 'Service 1',
          'price': 500.0,
        },
        {
          'image': 'assets/image/wall_art.jpg',
          'name': 'Service 2',
          'price': 300.0,
        },
      ],
    }
  ];


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          ///Categories
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Featured Products',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black87,
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  addToCart(products[index]);
                },
                child: Card(
                  elevation: 5, // Shadow for the card
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Product Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          products[index].image,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 16), // Spacing between image and details
                      // Product Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              products[index].name,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '₹${products[index].price}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).brightness == Brightness.dark
                                    ? Colors.green[300] // Lighter green for dark theme
                                    : Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Add to Cart Button
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green, // Button color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            // Add to cart logic
                            addToCart(products[index]);

                            // Show a SnackBar with the notification
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '${products[index].name} added to cart!',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                backgroundColor: Colors.lightGreen,
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                          child: const Text(
                            'Add to Cart',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          ///business
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Recommended Businesses',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: recommendedBusinesses.length,
                  itemBuilder: (context, index) {
                    final business = recommendedBusinesses[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BusinessDetailPage(business: business),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 5.0,
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              business['image'],
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            business['name'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black87,
                            ),
                          ),
                          subtitle: Text(
                            business['email'],
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? Colors.grey[400]
                                  : Colors.grey[600],
                            ),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.blueAccent,
                            size: 20,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                // View All Button
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextButton(
                    onPressed: () {
                      // Navigate to AllBusinessesPage with the complete list of businesses
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AllBusinessesPage(businesses: recommendedBusinesses),
                        ),
                      );
                    },
                    child: const Text(
                      'View All',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),



          ///Services
    Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text(
    'Recommended Services',
    style: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Theme.of(context).brightness == Brightness.dark
    ? Colors.white
        : Colors.black87, // Text color adjusts to the theme
    ),
    ),
    SizedBox(height: 12),
    // Adds space between the title and the list
    ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: recommendedServices.length > 3
    ? 3
        : recommendedServices.length, // Show only 3 services
    itemBuilder: (context, index) {
    final service = recommendedServices[index];
    return GestureDetector(
    onTap: () {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => ServiceDetailPage(service: service),
    ),
    );
    },
    child: Card(
    elevation: 5.0,
    // Adds a subtle shadow effect for a modern look
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12.0), // Rounded corners for card
    ),
    child: ListTile(
    contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    leading: ClipRRect(
    borderRadius: BorderRadius.circular(8.0),
    child: Image.asset(
    service['image'], // Displaying service image
    width: 60,
    height: 60,
    fit: BoxFit.cover,
    ),
    ),
    title: Text(
    service['name'], // Displaying service name
    style: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Theme.of(context).brightness == Brightness.dark
    ? Colors.white
        : Colors.black87, // Text color based on theme
    ),
    ),
    subtitle: Text(
    service['description'],
    // Displaying service description
    style: TextStyle(
    fontSize: 14,
    color: Theme.of(context).brightness == Brightness.dark
    ? Colors.white70
        : Colors.grey[600], // Adjust subtitle color for readability
    ),
    ),
    trailing: const Icon(
    Icons.arrow_forward_ios,
    color: Colors.blueAccent,
    size: 20,
    ),
    ),
    ),
    );
    },
    ),
    // Add View All button
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextButton(
          onPressed: () {
            // Navigate to AllServicesPage with the full list of services
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AllServicesPage(services: recommendedServices),
              ),
            );
          },
          child: const Text(
            'View All',
            style: TextStyle(
              fontSize: 16,
              color: Colors.green,
    ),
    ),
    ),
    ),
    ],
    ),
    )
    ]
      ),
    );
  }
}

