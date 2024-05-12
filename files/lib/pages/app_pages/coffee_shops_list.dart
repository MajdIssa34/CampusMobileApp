import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:macquarie_application/constants/login_button.dart';
import 'package:macquarie_application/data/coffee_shop_stores.dart';
import 'package:macquarie_application/pages/app_pages/coffee_page.dart';

// Defines a stateless widget for displaying a list of coffee shops.
class CoffeeShopsPage extends StatelessWidget {
  const CoffeeShopsPage({super.key});

  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible:
          false, // User must not close the dialog by tapping outside of it
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 10),
                Text(
                  "Directing you to \"The Study Bean\"...",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold provides the high-level structure of the page.
    return Scaffold(
      body: Container(
        // Background decoration with an image.
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/CoffeListBackground.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 25, top: 25, right: 25, bottom: 100),
              // Container for the content of the page.
              child: Container(
                decoration: BoxDecoration(
                  color:
                      Theme.of(context).colorScheme.background.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(8),
                  
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  // Column layout for the contents inside the container.
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Displays the heading "PICK UP".
                      Text(
                        'PICK UP',
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      // Row for the location icon and text.
                      Row(
                        children: [
                          Icon(Icons.pin_drop_outlined,
                              color: Theme.of(context).colorScheme.primary),
                          const SizedBox(width: 8),
                          Text(
                            'Choose one of our available locations!',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      // Divider to visually separate sections.
                      Divider(
                          thickness: 2,
                          color: Theme.of(context).colorScheme.primary),
                      // Expanded widget to hold a list of coffee shops.
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          // ListView to display each coffee shop as an expandable tile.
                          child: ListView.builder(
                            itemCount: coffeeShops.length,
                            itemBuilder: (context, index) {
                              final shop = coffeeShops[index];
                              return ExpansionTile(
                                // Title of the shop.
                                title: Text(
                                  shop['name'].toString(),
                                  style: GoogleFonts.poppins(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                // Subtitle shows whether the shop is open or closed.
                                subtitle: Text(
                                  shop['isOpen'] == true ? 'Open' : 'Closed',
                                  style: GoogleFonts.poppins(
                                    color: shop['isOpen'] == true
                                        ? Colors.green
                                        : Colors.red,
                                    fontSize: 16,
                                  ),
                                ),
                                // Additional details about the shop displayed when the tile is expanded.
                                children: [
                                  ListTile(
                                    title: Text(
                                      'Address: ${shop['address']}',
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      'Popular Item: ${shop['popularItem']}',
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      'Description: ${shop['description']}',
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                  ),
                                  // Button to visit the coffee shop page, shown only when the shop is open.
                                  if (shop['isOpen'] == true)
                                    Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: MyButton(
                                        onTap: () {
                                          showLoadingDialog(
                                              context); // Show the dialog
                                          Future.delayed(const Duration(seconds: 2),
                                              () {
                                            Navigator.of(context)
                                                .pop(); // Dismiss the dialog
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (_) => CoffeePage(
                                                        coffeeShopName:
                                                            shop['name'].toString()))); // Navigate to CoffeePage
                                          });
                                        },
                                        str: 'Tap to visit shop page',
                                      ),
                                    )
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
