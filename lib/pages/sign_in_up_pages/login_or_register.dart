import 'package:flutter/material.dart';
import 'package:macquarie_application/pages/sign_in_up_pages/register_page.dart';
import 'package:macquarie_application/pages/sign_in_up_pages/login_page.dart';

// This StatefulWidget manages the state to toggle between the login and register pages.
class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

// Private State class for handling the logic to switch between login and registration forms.
class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  // Boolean flag to track which page to display, true for login page, false for register page.
  bool logInPage = true;

  // Function to toggle between login and register page views.
  void togglePages() {
    setState(() {
      logInPage = !logInPage;  // Toggle the state between true and false.
    });
  }

  @override
  Widget build(BuildContext context) {
    // Based on the boolean flag 'logInPage', display either the LoginPage or RegisterPage.
    if (logInPage) {
      // If 'logInPage' is true, render the LoginPage and pass the toggle function.
      return LoginPage(
        onTap: togglePages,
      );
    } else {
      // If 'logInPage' is false, render the RegisterPage and also pass the toggle function.
      return RegisterPage(onTap: togglePages);
    }
  }
}
