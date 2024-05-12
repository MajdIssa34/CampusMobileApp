import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:macquarie_application/stored_data/user_history.dart';

// StatefulWidget for managing state that may change over time, such as user order history.
class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

// State class for the OrderHistoryPage.
class _OrderHistoryPageState extends State<OrderHistoryPage> {
  List<Map<String, dynamic>> orders = []; // A list to store order data.

  @override
  void initState() {
    super.initState();
    loadOrders(); // Load order data when the widget is initialized.
  }

  // Asynchronous function to fetch orders from storage and update the UI.
  void loadOrders() async {
    orders = OrderHistory.getOrders(); // Fetch all orders stored in history.
    setState(() {}); // Trigger a rebuild of the widget to reflect new data.
  }

  // Function to handle removal of an order and refresh the list.
  void removeOrder(int index) async {
    await OrderHistory.removeOrder(index); // Remove the order asynchronously.
    loadOrders(); // Reload the orders to update the UI.
  }
  // Function to remove all orders.
  void removeAllOrders() async {
    OrderHistory.removeAllOrders; // Remove all orders asynchronously.
    loadOrders(); // Reload the orders to update the UI.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          'Order History', // Title of the page.
          style: GoogleFonts.poppins(
            fontSize: 18,
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.delete_forever),
            color: Colors.red,
            onPressed: () async {
              await OrderHistory.removeAllOrders();
              loadOrders(); // Refresh your UI or state to reflect the change
            },
            tooltip: 'Delete all orders',
          ),
        ],
      ),
      body: orders.isEmpty
          ? Center(
              // Display a message when no orders are present.
              child: Text(
                "No orders yet.",
                style: GoogleFonts.poppins(
                    fontSize: 22, fontWeight: FontWeight.bold),
              ),
            )
          : ListView.builder(
              itemCount: orders.length, // Number of orders to build.
              itemBuilder: (context, index) {
                var order = orders[index];
                return Card(
                  color: Theme.of(context).colorScheme.primary,
                  margin: const EdgeInsets.all(20),
                  child: ListTile(
                    title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'The Study Bean', // Placeholder for shop name.
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color:
                                    Theme.of(context).colorScheme.background),
                          ),
                          Text(
                            '${order['date']}', // Display order date.
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color:
                                    Theme.of(context).colorScheme.background),
                          ),
                        ]),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Order No:',
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.background),
                            ),
                            Text(
                              'Payment Method:',
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.background),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'MQ${order['orderNumber']}', // Display order number.
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  color:
                                      Theme.of(context).colorScheme.background),
                            ),
                            Text(
                              '${order['paymentMethod']}', // Display payment method.
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  color:
                                      Theme.of(context).colorScheme.background),
                            ),
                          ],
                        ),
                        Divider(
                            thickness: 2,
                            color: Theme.of(context).colorScheme.background),
                        Text(
                          'Items:', // Label for listing items in the order.
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.background),
                        ),
                        ListView.builder(
                          physics:
                              const NeverScrollableScrollPhysics(), // Disables scrolling within the embedded ListView.
                          shrinkWrap:
                              true, // Ensures the ListView only occupies necessary space.
                          itemCount: order['items']
                              .length, // Number of items in the order.
                          itemBuilder: (context, itemIndex) {
                            String itemName =
                                order['items'].keys.elementAt(itemIndex);
                            int itemCount = order['items'][itemName];
                            return Text(
                              '$itemName x $itemCount', // Format item name and count.
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  color:
                                      Theme.of(context).colorScheme.background),
                            );
                          },
                        ),
                        Text(
                          'Order Total is: ${order['total']}', // Label for listing items in the order.
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.background),
                        ),
                        Text(
                          'Ordered by:', // Label for listing items in the order.
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.background),
                        ),
                        Text(
                          '${order['user']}', // Label for listing items in the order.
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: Theme.of(context).colorScheme.background),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => removeOrder(
                          index), // Function to remove order when delete icon is pressed.
                    ),
                  ),
                );
              },
            ),
    );
  }
}
