import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:macquarie_application/model/cart_model.dart';
import 'package:provider/provider.dart';

// Stateless widget to display order confirmation details.
class OrderConfirmation extends StatelessWidget {
  // Parameters passed to the widget to display order details.
  final String total;
  final Map<String, int> items;
  final String date;
  final String orderNumber;
  final String paymentMethod;
  final String user;

  // Constructor for the widget.
  const OrderConfirmation({
    super.key,
    required this.total,
    required this.items,
    required this.date,
    required this.orderNumber,
    required this.paymentMethod,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          'Order Confirmation', // Title for the app bar.
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer<CartModel>(  // Uses Provider to access cart model.
        builder: (context, cart, child) {
          return Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Order Summary', // Section title.
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
                const SizedBox(height: 15),
                const Divider(thickness: 2),
                const SizedBox(height: 15),
                // Displays order date, number, and payment method using rows and columns.
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Date", // Label for the date.
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                        Text(
                          date, // Displays the date.
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 35,
                      width: 1,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Order No.", // Label for the order number.
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                        Text(
                          "MQ$orderNumber", // Displays the order number.
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 30,
                      width: 1,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Payment Method", // Label for payment method.
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                        Text(
                          paymentMethod, // Displays the payment method.
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                const Divider(thickness: 2),
                const SizedBox(height: 15),
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.cartItems.length,
                    itemBuilder: (context, index) {
                      int productIndex = cart.cartItems.keys.elementAt(index);
                      int quantity = cart.cartItems.values.elementAt(index);
                      var item = cart.coffeeItems[productIndex];
                      return ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),  // Image with rounded corners.
                          child: Image.asset(
                            item[3],
                            width: 56,
                            height: 56,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          item[0], // Item name.
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          'Quantity: $quantity', // Quantity of the item ordered.
                          style: GoogleFonts.poppins(fontSize: 14),
                        ),
                        trailing: Text(
                          '\$${item[2]}', // Price of the item.
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const Divider(thickness: 2),
                // Displays total price, excluding and including tax.
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Item Price (excl. GST):',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            )),
                        Text(() {
                          double total = double.parse(cart.calculateTotal());
                          return '\$${(total - total * 0.1).toStringAsFixed(2)}';  // Calculates price excluding GST.
                        }(),
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.primary,
                            )),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('GST:',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            )),
                        Text(() {
                          double total = double.parse(cart.calculateTotal());
                          return '\$${(total * 0.1).toStringAsFixed(2)}';  // Calculates GST.
                        }(),
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.primary,
                            )),
                      ],
                    ),
                    const Divider(thickness: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Order Total:',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            )),
                        Text('\$${cart.calculateTotal()}',  // Displays total price.
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              color: Theme.of(context).colorScheme.primary,
                            )),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
