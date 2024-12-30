class Product {
  final String name;
  final String image;
  final double price;
  final List<Map<String, dynamic>>? reviews;

  Product({
    required this.name,
    required this.image,
    required this.price,
    this.reviews,
  });
}

final List<Map<String, dynamic>> recommendedBusinesses = [
  {
    "name": "Artedea",
    "image": "assets/image/Artdea.png",
    "email": "pratikshankdm@gmail.com",
    "description": "Find the best frames,keychains.",
    "contactNo": "1234567890",
    "address": "123 Fashion Street, City Name",
    "products": [
      Product(
        name: "3D Frames",
        image: "assets/image/3Dframes.jpg",
        price: 799.99,
        reviews: [
          {'name': 'sanjay', 'rating': 5, 'comment': 'Great quality frames!'},
          {
            'name': 'smitha',
            'rating': 4,
            'comment': 'Nice frames, would buy again.'
          },
        ],
      ),
      Product(
        name: "Keychains",
        image: "assets/image/keychain.jpg",
        price: 499.99,
        reviews: [
          {'name': 'zoya', 'rating': 5, 'comment': 'Love the design!'},
        ],
      ),
      Product(
        name: "HandCraft Gifts",
        image: "assets/image/handcraft.jpg",
        price: 899.99,
        reviews: [
          {'name': 'pooja', 'rating': 5, 'comment': 'Amazing quality!'},
        ],
      ),
      Product(
        name: "Paintings",
        image: "assets/image/paintings.jpg",
        price: 1999.99,
        reviews: [
          {'name': 'Alice', 'rating': 5, 'comment': 'Stunning artwork!'},
        ],
      ),
      Product(
          name: "Raisins Frames",
          image: "assets/image/raisins.jpg",
          price: 1999.99,
          reviews: [
          {
          'name': 'Bob',
          'rating': 4,
          'comment': 'Nice frame, a bit overpriced.'
          },
       ],
      ),
    ],
    "reviews": [
    {'name': 'Alice', 'rating': 5, 'comment': 'Great quality frames!'},
    {'name': 'Bob', 'rating': 4, 'comment': 'Nice keychains but pricey.'},
    {'name': 'Charlie', 'rating': 5, 'comment': 'Amazing handcrafted gifts!'},
    ],

  },
  {
    "name": "Dessert Junction",
    "image": "assets/image/dessertjunction.jpg",
    "email": "nandinisharma7577@gmail.com",
    "description":
        "Its a desserts kitchen where I make cakes and desserts, cookies, muffins, cupcakes, and chocolates",
    "contactNo": "9819704760",
    "address": "Malad west",
    "products": [
      Product(
        name: "Chocolate Dutch truffle",
        image: "assets/image/truffle.jpg",
        price: 1350,
        reviews: [
          {
            'name': 'David',
            'rating': 5,
            'comment': 'Delicious chocolate truffle!'
          },
        ],
      ),
      Product(
        name: "Black forest",
        image: "assets/image/blackforest.jpg",
        price: 1200,
        reviews: [
          {
            'name': 'Eva',
            'rating': 4,
            'comment': 'Loved the black forest cake.'
          },
        ],
      ),
      Product(
        name: "Chocolate with caramel",
        image: "assets/image/caramel1.jpg",
        price: 1500,
        reviews: [
          {'name': 'Liam', 'rating': 4, 'comment': 'Good variety of desserts.'},
        ],
      ),
      Product(
        name: "Chocolate with Strawberry",
        image: "assets/image/strawberry.jpg",
        price: 1500,
        reviews: [
          {
            'name': 'Sarah',
            'rating': 5,
            'comment': 'Perfect combination of chocolate and strawberry!'
          },
        ],
      ),
      Product(
        name: "Mix fruit cake",
        image: "assets/image/mixfruit.jpg",
        price: 1250,
        reviews: [
          {
            'name': 'James',
            'rating': 4,
            'comment': 'Tasty, but could be a bit sweeter.'
          },
        ],
      ),
      Product(
        name: "Pineapple cake",
        image: "assets/image/pineapple.jpg",
        price: 1100,
        reviews: [
          {
            'name': 'Olivia',
            'rating': 5,
            'comment': 'Absolutely loved the pineapple flavor!'
          },
        ],
      ),
      Product(
        name: "Butter scotch cake",
        image: "assets/image/butter.jpg",
        price: 990,
        reviews: [
          {
            'name': 'Isla',
            'rating': 4,
            'comment': 'Delicious, but a bit too rich for my taste.'
          },
        ],
      ),
      Product(
        name: "Biscoff cheese",
        image: "assets/image/biscoff.jpg",
        price: 2100,
        reviews: [
          {'name': 'Ethan', 'rating': 5, 'comment': 'Love the biscoff flavor!'},
        ],
      ),
      Product(
        name: "Blueberry cheesecake",
        image: "assets/image/bluecake.jpg",
        price: 1850,
        reviews: [
          {
            'name': 'Sophia',
            'rating': 5,
            'comment': 'One of the best cheesecakes I’ve had!'
          },
        ],
      ),
    ],
    "reviews": [
      {'name': 'David', 'rating': 5, 'comment': 'Delicious chocolate truffle!'},
      {'name': 'Eva', 'rating': 4, 'comment': 'Loved the black forest cake.'},
      {
        'name': 'Liam',
        'rating': 4,
        'comment': 'Good variety of desserts, would love to see more options.'
      },
    ],
  },
  {
    "name": "Modern Heel 2",
    "image": "assets/image/footwear.jpg",
    "email": "danishamaitar6@gmail.com",
    "description":
        "We sell branded women footwear all type of footwear are available in modern heels 2.",
    "contactNo": "9930841181",
    "address": "lokhandwala market",
    "products": [
      Product(
        name: "Fashion Heels",
        image: "assets/image/heels.jpg",
        price: 799.99,
        reviews: [
          {
            'name': 'Maya',
            'rating': 5,
            'comment': 'Comfortable and stylish heels.'
          },
        ],
      ),
      Product(
        name: "Flip Flops",
        image: "assets/image/flips.jpg",
        price: 499.99,
        reviews: [
          {
            'name': 'Sophia',
            'rating': 4,
            'comment': 'Good for casual wear, comfortable.'
          },
        ],
      ),
      Product(
        name: "Block Heels",
        image: "assets/image/blockheel.jpg",
        price: 899.99,
        reviews: [
          {
            'name': 'Zara',
            'rating': 4,
            'comment': 'Great heels, stylish but slightly heavy.'
          },
        ],
      ),
      Product(
        name: "High Heel Boots",
        image: "assets/image/highheel.jpg",
        price: 1299.99,
        reviews: [
          {
            'name': 'Emma',
            'rating': 5,
            'comment': 'Perfect for winter and stylish.'
          },
        ],
      ),
      Product(
        name: "High Cone Heels",
        image: "assets/image/coneheel.jpg",
        price: 1999.99,
        reviews: [
          {
            'name': 'Olivia',
            'rating': 4,
            'comment': 'Elegant, but a bit difficult to walk in.'
          },
        ],
      ),
    ],
    "reviews": [
      {
        'name': 'Maya',
        'rating': 5,
        'comment': 'Comfortable and stylish heels.'
      },
      {
        'name': 'Sophia',
        'rating': 4,
        'comment': 'Nice collection of footwear, but a bit expensive.'
      },
      {
        'name': 'Zara',
        'rating': 4,
        'comment': 'Great for casual wear, will buy again.'
      },
    ],
  },
  {
    "name": "Shiv Shakti Collections",
    "image": "assets/image/ss.jpg",
    "email": "anamikachaurasiya1718@gmail.com",
    "description":
        "Girls fashionable products like scrunchies, light watch, beautiful bracelets, lockets, stylish things are available under us",
    "contactNo": "8591088076",
    "address": "Goregaon West Mumbai",
    "products": [
      Product(
        name: "Scrunchies",
        image: "assets/image/scrunchies.webp",
        price: 30,
        reviews: [
          {
            'name': 'Nina',
            'rating': 5,
            'comment': 'Loved the scrunchies, very cute!'
          },
        ],
      ),
      Product(
        name: "Light Watch",
        image: "assets/image/cloth.jpg",
        price: 250,
        reviews: [
          {
            'name': 'Olivia',
            'rating': 4,
            'comment': 'The light watch is beautiful and affordable.'
          },
        ],
      ),
      Product(
        name: "Bracelets",
        image: "assets/image/bracelets.jpg",
        price: 150,
        reviews: [
          {
            'name': 'Ava',
            'rating': 4,
            'comment': 'Nice bracelet, looks good with all outfits.'
          },
        ],
      ),
      Product(
        name: "Lockets",
        image: "assets/image/locket.jpg",
        price: 160,
        reviews: [
          {
            'name': 'Zara',
            'rating': 5,
            'comment': 'Simple and elegant, perfect for everyday wear.'
          },
        ],
      ),
      Product(
        name: "Decoration of Ganapati Festival (As per Requirement)",
        image: "assets/image/cloth.jpg",
        price: 1000,
        reviews: [
          {
            'name': 'Maya',
            'rating': 5,
            'comment': 'Beautiful decoration, really made the festival special!'
          },

        ],
      ),
    ],
    "reviews": [
      {
        'name': 'Nina',
        'rating': 5,
        'comment': 'Loved the scrunchies, very cute!'
      },
      {
        'name': 'Olivia',
        'rating': 4,
        'comment': 'The light watch is beautiful and affordable.'
      },
      {
        'name': 'Ava',
        'rating': 4,
        'comment': 'Great accessories, will shop again.'
      },
    ],
  },
      {
        "name": "Mauli Enterprise",
        "image": "assets/image/mauli.jpg",
        "email": "2006abhishekyadav@gmail.com",
        "description":"We are seller of dates, Dryfruits, seeds and farsan",
        "contactNo": "8591154842",
        "products": [
          Product(
            name: "Black Dates",
            image: "assets/image/blackdates.jpg",
            price: 130,
            reviews: [
              {
                'name': 'Maya',
                'rating': 5,
                'comment': 'Comfortable and stylish heels.'
              },
            ],
          ),
          Product(
            name: "Dry Fruits",
            image: "assets/image/dryfruits.jpg",
            price: 499.99,
            reviews: [
              {
                'name': 'Sophia',
                'rating': 4,
                'comment': 'Good for casual wear, comfortable.'
              },
            ],
          ),
          Product(
            name: "Farsan",
            image: "assets/image/farsan.jpg",
            price: 899.99,
            reviews: [
              {
                'name': 'Zara',
                'rating': 4,
                'comment': 'Great heels, stylish but slightly heavy.'
              },
            ],
          ),
        ],
        "reviews": [
          {
            'name': 'Maya',
            'rating': 5,
            'comment': 'best dates .'
          },
          {
            'name': 'Sophia',
            'rating': 4,
            'comment': 'good taste but a bit expensive.'
          },
          {
            'name': 'smitha',
            'rating': 4,
            'comment': 'best quality'
          },
        ],
      },
  {
    "name": "Bakers_adda (cakes & chocolates baked)",
    "image": "assets/image/bakes.jpg",
    "email": "rutujaghadi1419@gmail.com",
    "description":
    "My business is completely based on home baking... 100% quality we baked ",
    "contactNo": "7045882771",
    "address": "Goregaon West Mumbai",
    "products": [
      Product(
        name: "Baked Bun",
        image: "assets/image/bun.jpg",
        price: 30,
        reviews: [
          {
            'name': 'Nina',
            'rating': 5,
            'comment': 'Loved the scrunchies, very cute!'
          },
        ],
      ),
      Product(
        name: "Waffles",
        image: "assets/image/waffles.jpg",
        price: 250,
        reviews: [
          {
            'name': 'Olivia',
            'rating': 4,
            'comment': 'The light watch is beautiful and affordable.'
          },
        ],
      ),
      Product(
        name: "Cup Cakes",
        image: "assets/image/cupcake.jpg",
        price: 150,
        reviews: [
          {
            'name': 'Ava',
            'rating': 4,
            'comment': 'Nice bracelet, looks good with all outfits.'
          },
        ],
      ),
      Product(
        name: "Donuts",
        image: "assets/image/donuts.jpg",
        price: 160,
        reviews: [
          {
            'name': 'Zara',
            'rating': 5,
            'comment': 'Simple and elegant, perfect for everyday wear.'
          },
        ],
      ),
    ],
    "reviews": [
      {
        'name': 'Nina',
        'rating': 5,
        'comment': 'Loved the scrunchies, very cute!'
      },
      {
        'name': 'Olivia',
        'rating': 4,
        'comment': 'The light watch is beautiful and affordable.'
      },
      {
        'name': 'Ava',
        'rating': 4,
        'comment': 'Great accessories, will shop again.'
      },
    ],
  },
    ];

///Services Section
final List<Map<String, dynamic>> recommendedServices = [
  {
    "name": "RSA NGO",
    "image": "assets/image/ngo.jpg",
    "email": "@gmail.com",
    "description":
    "Products made by children with special needs. PLEASE NOTE NO RETURN POLICY",
    "contactNo": "",
    'services': [
      {
        'image': 'assets/image/painting.jpg',
        'name': 'Warli Paintings',
        'price': 250,
      },
      {
        'image': 'assets/image/battery.jpg',
        'name': 'Battery operated Christmas tree decoration.',
        'price': 150,
      },
      {
        'image': 'assets/image/crochet.jpg',
        'name': 'Crochet bells for Christmas tree.',
        'price': 130,
      },
      {
        'image': 'assets/image/clothbag.jpg',
        'name': 'Hand painted tote bags',
        'price': 130,
      },

    ],
  },
  {
    "name": "SM Photography",
    "image": "assets/image/photo.jpg",
    "email": "sanchitmenge7039@gmail.com",
    "description":
    "Wedding Photography, Model Shoot, Fashion Photography",
    "contactNo": "8291328975",
    'services': [
      {
        'image': 'assets/image/wedding.jpg',
        'name': 'Wedding Photography',
        'price': 20000,
      },
      {
        'image': 'assets/image/shoot.jpg',
        'name': 'Model Shoot',
        'price': 3000,
      },

    ],
  },
  {
    "name": "Beauty World",
    "image": "assets/image/Bridemakeup.webp",
    "email": "ankitachaurasiya316@gmail.comm",
    "description":
        "We provide good service to the customer by giving our best ",
    "contactNo": "9369103838",
    "address": "lokhandwala market",
    'services': [
      {
        'image': 'assets/image/massage.jpg',
        'name': 'Facial Massage',
        'price': 500.0,
      },
      {
        'image': 'assets/image/bride.jpg',
        'name': 'Bridal Makeup',
        'price': 10000,
      },
      {
        'image': 'assets/image/spa.jpg',
        'name': 'Hair Spa',
        'price': 300.0,
      },
    ],
  },
  {
    "name": "SM Photography",
    "image": "assets/image/photo.jpg",
    "email": "sanchitmenge7039@gmail.com",
    "description":
        "Wedding Photography, Model Shoot, Fashion Photography",
    "contactNo": "8291328975",
    'services': [
      {
        'image': 'assets/image/wedding.jpg',
        'name': 'Wedding Photography',
        'price': 20000,
      },
      {
        'image': 'assets/image/shoot.jpg',
        'name': 'Model Shoot',
        'price': 3000,
      },

    ],
  },
];


