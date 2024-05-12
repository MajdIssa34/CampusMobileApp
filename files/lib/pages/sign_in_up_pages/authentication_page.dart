import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:macquarie_application/pages/app_pages/main_page.dart';
import 'package:macquarie_application/pages/sign_in_up_pages/login_or_register.dart';

// Stateless widget to determine and display the authentication state-dependent interface.
class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold is the basic layout structure of the page that allows for text, buttons, and other inputs.
    return Scaffold(
      body: StreamBuilder<User?>(
        // Stream provided by FirebaseAuth to listen to the authentication state changes.
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // Conditional content rendering based on Firebase authentication state.
          if (snapshot.hasData) {
            // If snapshot has user data, meaning the user is logged in.
            return const MainPage(); // Navigate to the main page of the app.
          } else {
            // If no user data is present, meaning the user is not logged in.
            return const LoginOrRegisterPage(); // Navigate to the login or registration page.
          }
        }
      ),
    );
  }
}
