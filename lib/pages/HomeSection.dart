import 'package:Udyojak/pages/data/datalists.dart';
import 'package:flutter/material.dart';
import 'ServiceDetailPage.dart';
import 'AllServicePage.dart';
import 'BusinessDetailPage.dart';
import 'AllBusinessesPage.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeSection extends StatefulWidget {
  final Function(Product) addToCart;
  final List<Product> cart;

  HomeSection({super.key, required this.addToCart, required this.cart});

  @override
  State<HomeSection> createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection> {
  bool isAdded = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

          /// Business Section UI
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section Title
                  Text(
                    'Youth Businesses',
                    style: GoogleFonts.mcLaren(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white // White text for dark mode
                          : Colors.black87, // Dark text for light mode
                    ),
                  ),
                  const SizedBox(height: 25), // Spacing between title and content

                  // Horizontal Scrollable Business List
                  SizedBox(
                    height: 180, // Fixed height for cards
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: recommendedBusinesses.length > 4
                          ? 5 // Limit to 4 businesses + 1 "View All" card
                          : recommendedBusinesses.length + 1, // Include "View All" as the last item
                      itemBuilder: (context, index) {
                        if (index == recommendedBusinesses.length || index == 4) {
                          // "View All" Card as the last item
                          return GestureDetector(
                            onTap: () {
                              // Navigate to All Businesses Page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AllBusinessesPage(
                                    businesses: recommendedBusinesses,
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              elevation: 6,
                              margin: const EdgeInsets.symmetric(horizontal: 8.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Container(
                                width: 200, // Match width with business cards
                                height: 125,
                                alignment: Alignment.center,
                                child: Text(
                                  'View All',
                                  style: GoogleFonts.mcLaren(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          );
                        }

                        // Business Card
                        final business = recommendedBusinesses[index];
                        return GestureDetector(
                          onTap: () {
                            // Navigate to Business Detail Page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BusinessDetailPage(business: business),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 6,
                            margin: const EdgeInsets.symmetric(horizontal: 8.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Business Image
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: Image.asset(
                                    business['image'],
                                    width: 200,
                                    height: 125,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 10),

                                // Business Name
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(
                                    business['name'],
                                    style: GoogleFonts.mcLaren(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).brightness == Brightness.dark
                                          ? Colors.white
                                          : Colors.black87,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),


          /// Recommended Services Section UI
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section Title
                Text(
                  'Youth Services',
                  style: GoogleFonts.mcLaren(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),

                // Vertical Scrollable List
                ListView.builder(
                  shrinkWrap: true, // Makes the ListView fit its content
                  physics: const NeverScrollableScrollPhysics(), // Prevents independent scrolling
                  itemCount: recommendedServices.length > 4
                      ? 5 // Show 4 services and 1 "View All" button
                      : recommendedServices.length + 1, // Include "View All" button
                  itemBuilder: (context, index) {
                    if (index == recommendedServices.length || index == 4) {
                      // "View All" Button as the last item
                      return GestureDetector(
                        onTap: () {
                          // Navigate to All Services Page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AllServicesPage(services: recommendedServices),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 6.0,
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Container(
                            height: 60,
                            alignment: Alignment.center,
                            child: Text(
                              'View All',
                              style: GoogleFonts.mcLaren(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      );
                    }

                    // Service Card
                    final service = recommendedServices[index];
                    return GestureDetector(
                      onTap: () {
                        // Navigate to Service Detail Page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ServiceDetailPage(service: service),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 6.0,
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Service Image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.asset(
                                service['image'],
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 16.0),

                            // Service Name
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  service['name'],
                                  style: GoogleFonts.mcLaren(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).brightness == Brightness.dark
                                        ? Colors.white
                                        : Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

        ]
    )
      )
    );
  }
}
