// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:macquarie_application/pages/app_pages/cart_page.dart';
import 'package:macquarie_application/pages/app_pages/order_history.dart';
import 'package:macquarie_application/themes/theme_provider.dart';
import 'package:provider/provider.dart';

// Function to create a Drawer widget customized for the application's theme and user interface.
Drawer myDrawer(context, int index) {
  return Drawer(
    backgroundColor: Theme.of(context).colorScheme.background,
    elevation: 0,
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: DrawerHeader(
            child: Column(
              children: [
                // Displays the currently logged-in user's email using Firebase Authentication.
                Text(
                  'Logged in as: ${FirebaseAuth.instance.currentUser?.email ?? ""}',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
                // Displays the university's logo
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(
                    'assets/images/Macquarie_University Logo.png',
                    width: 65,
                  ),
                ),
              ],
            ),
          ),
        ),
        // Text tile with a message, used here for inspirational or promotional content.
        Padding(
          padding: const EdgeInsets.all(10),
          child: ListTile(
            title: Text(
              'Together at Macquarie University, we multiply our ability to achieve remarkable things. That\'s YOU to the power of us.',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic,
                color: Theme.of(context).colorScheme.primary,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        // Custom button to toggle the app's theme (dark/light mode).
        _customElevatedButton(Icons.brightness_6, "Switch Themes", () {
          Provider.of<ThemeProvider>(context, listen: false).toggleThemes();
        }, context),
        const SizedBox(
          height: 20,
        ),
        // Navigation button to the Order History page.
        _customElevatedButton(Icons.history, "Order History", () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const OrderHistoryPage()));
        }, context),
        const SizedBox(
          height: 20,
        ),
        // Navigation button to the Shopping Cart page.
        _customElevatedButton(Icons.shopping_cart, "Shopping Cart", () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CartPage()));
        }, context),
        const SizedBox(
          height: 20,
        ),
        // Button to log out the user.
        _customElevatedButton(
            Icons.logout, "Log Out", () => signUserOut(context), context),
      ],
    ),
  );
}

void showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible:
        false, // Prevents the dialog from being dismissed by tapping outside.
    builder: (BuildContext context) {
      return Dialog(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 10),
              Text(
                "Logging out...",
                style: GoogleFonts.poppins(fontSize: 16),
              ),
            ],
          ),
        ),
      );
    },
  );
}

// Function to sign out the user from Firebase.
void signUserOut(BuildContext context) async {
  showLogoutDialog(context); // Show the logout dialog

  // Simulate a network delay or wait for a minimum time before closing the dialog
  await Future.delayed(const Duration(seconds: 2), () async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pop(); // Dismiss the logout dialog
    } catch (error) {
      Navigator.of(context)
          .pop(); // Ensure the dialog is dismissed in case of an error
      // Optionally show an error message to the user
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Failed to log out: $error")));
    }
  });
}

// Custom AppBar for the application.
AppBar myAppBar(context) {
  return AppBar(
    backgroundColor: Theme.of(context).colorScheme.background.withOpacity(0.8),
    //foregroundColor: Theme.of(context).colorScheme.background.withOpacity(0.8),
    title: Text(
      'Macquarie University',
      style: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.primary,
      ),
    ),
    centerTitle: true,
  );
}

// Helper function to create consistently styled ElevatedButton widgets across the app.
Widget _customElevatedButton(
    IconData icon, String text, VoidCallback onPressed, context) {
  return ElevatedButton.icon(
    onPressed: onPressed,
    icon: Icon(icon, color: Theme.of(context).colorScheme.background),
    label: Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        color: Theme.of(context).colorScheme.background,
      ),
    ),
    style: ElevatedButton.styleFrom(
      backgroundColor: Theme.of(context).colorScheme.primary,
      shape: const StadiumBorder(),
      fixedSize: const Size(250, 50),
    ),
  );
}

// error message for email and password
void errorMessage(String str, BuildContext context) {
  if(ScaffoldMessenger.of(context).mounted){
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 4),
      backgroundColor: Colors.transparent,
      content: Container(
        padding: const EdgeInsets.all(5),
        height: 70,
        decoration: const BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                str,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                ),
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
