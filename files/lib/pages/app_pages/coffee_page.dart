import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:macquarie_application/data/coffe_shop_data.dart';
import 'package:macquarie_application/model/cart_model.dart';
import 'package:macquarie_application/pages/app_pages/cart_page.dart';
import 'package:provider/provider.dart';

class CoffeePage extends StatefulWidget {
  final String coffeeShopName; // Add a field to store the coffee shop name

  const CoffeePage({super.key, required this.coffeeShopName});

  @override
  State<CoffeePage> createState() => _CoffeePageState();
}

class _CoffeePageState extends State<CoffeePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          widget.coffeeShopName,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        centerTitle: true,
      ),
      // Shopping cart
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const CartPage();
        })),
        backgroundColor:
            Theme.of(context).colorScheme.background.withOpacity(0.9),
        child: Icon(
          Icons.shopping_cart,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      body: Container(
        // Set background
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/CoffeeBackground.jpeg"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black26, BlendMode.darken)),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .background
                          .withOpacity(0.6),
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                          width: 1)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 35,
                      ),
                      // Top text
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          "Hi there!",
                          style: GoogleFonts.poppins(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      // Top text
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          "Let's get you some coffee.",
                          style: GoogleFonts.poppins(
                              fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Divider(
                          thickness: 5,
                        ),
                      ),
                      Consumer<CartModel>(
                        builder: (context, value, child) {
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: value.coffeeItems.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:
                                  1, // We use 1 to simulate a ListView
                              childAspectRatio:
                                  3, // Adjust the ratio according to your item design
                            ),
                            itemBuilder: ((context, index) {
                              return CoffeeItemsTile(
                                itemName: value.coffeeItems[index][0],
                                description: value.coffeeItems[index][1],
                                itemPrice: value.coffeeItems[index][2],
                                imagePath: value.coffeeItems[index][3],
                                onPressed: () {
                                  Provider.of<CartModel>(context, listen: false)
                                      .addItemToCart(index);

                                  // Dismiss any currently showing snack bar.
                                  ScaffoldMessenger.of(context)
                                      .removeCurrentSnackBar();

                                  // Show a new snack bar.
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor:
                                          Theme.of(context).colorScheme.primary,
                                      content: Text(
                                        '${value.coffeeItems[index][0]} added to cart',
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .background,
                                        ),
                                      ),
                                      duration: const Duration(seconds: 2),
                                      action: SnackBarAction(
                                        label: 'UNDO',
                                        onPressed: () {
                                          Provider.of<CartModel>(context,
                                                  listen: false)
                                              .removeItemFromCart(index);
                                        },
                                      ),
                                    ),
                                  );
                                },
                              );
                            }),
                          );
                        },
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
