// ignore_for_file: use_build_context_synchronously

import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:macquarie_application/model/cart_model.dart';
import 'package:macquarie_application/stored_data/user_history.dart';
import 'package:macquarie_application/pages/app_pages/order_confirmation_page.dart';

// Defines the CartPage widget, which displays the user's shopping cart.
class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold provides the high-level structure of the page.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          'Your cart', // Title of the AppBar
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.delete_forever),
            color: Colors.red,
            onPressed: () {
              // Retrieve the cart model and clear all items.
              Provider.of<CartModel>(context, listen: false).removeAllItems();
            },
            tooltip: 'Empty Shopping Cart.',
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage(
              "assets/images/CartBackground.jpg"), // Background image for the cart page
          fit: BoxFit.cover,
        )),
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background.withOpacity(
                  0.7), // Semi-transparent background for the container
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Consumer<CartModel>(
              // Consumes CartModel to listen for changes
              builder: (context, cart, child) {
                if (cart.cartItems.isEmpty) {
                  // Conditionally displays if the cart is empty
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Your shopping cart is empty.', // Message displayed when cart is empty
                          style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Icon(Icons.remove_shopping_cart, size: 200),
                      ],
                    ),
                  );
                }
                // Builds a list of cart items if the cart is not empty
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: cart
                            .cartItems.length, // Number of items in the cart
                        itemBuilder: (context, index) {
                          int productIndex =
                              cart.cartItems.keys.elementAt(index);
                          int quantity = cart.cartItems.values.elementAt(index);
                          var item = cart.coffeeItems[
                              productIndex]; // Retrieves item details from the cart model
                          return Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Container(
                              height: 140,
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .background
                                    .withOpacity(0.7),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          14), // Rounded corners for the image
                                      child: Image.asset(
                                        item[3], // Image of the item
                                        width: 120,
                                        height: 120,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${item[0]} x $quantity', // Display item name and quantity
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        '\$${item[2]}', // Display item price
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () => cart.removeItemFromCart(
                                        productIndex), // Removes the item from the cart
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red.shade800,
                                      size: 40,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        final String currentDate =
                            DateFormat('yyyy-MM-dd').format(DateTime.now());
                        final String orderNumber =
                            Random().nextInt(999999).toString().padLeft(6, '0');
                        const String paymentMethod = 'Credit Card';
                        String total = cart.calculateTotal();
                        Map<String, int> getItemNames = cart.getItemNames();
                        var itemDetails = cart.getItemDetails(); // Get detailed item info
                        // Add order history before clearing the cart
                        await OrderHistory.addOrder(
                            total,
                            getItemNames,
                            currentDate,
                            orderNumber,
                            paymentMethod,
                            '${FirebaseAuth.instance.currentUser?.email}');

                        // Clear the cart
                        Provider.of<CartModel>(context, listen: false).removeAllItems();

                        // Navigate to the order confirmation page
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OrderConfirmation(
                                      total: total,
                                      items: getItemNames,
                                      itemsDetails: itemDetails,
                                      date: currentDate,
                                      orderNumber: orderNumber,
                                      paymentMethod: paymentMethod,
                                      user:
                                          '${FirebaseAuth.instance.currentUser?.email}',
                                    )));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(35),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .background
                                .withOpacity(0.7),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Theme.of(context).colorScheme.primary,
                              width: 2,
                            ),
                          ),
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Your total is',
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '\$${cart.calculateTotal()}',
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                              Text(
                                'Confirm Order',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Icon(Icons.navigate_next_rounded, size: 38)
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
