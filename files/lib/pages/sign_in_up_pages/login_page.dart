// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:macquarie_application/constants/drawer_and_appbar.dart';
import 'package:macquarie_application/constants/login_button.dart';
import 'package:macquarie_application/constants/login_textfield.dart';
import 'package:macquarie_application/services/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //email controller
  final emailController = TextEditingController();

  //password controller
  final passwordController = TextEditingController();

  void signUserIn() async {
    // Show loading circle
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Check if the widget is still mounted before navigating or showing error messages
      if (mounted) {
        // Pop the loading circle
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      // Check if the widget is still mounted before navigating or showing error messages
      if (!mounted) return;

      // Pop the loading circle
      Navigator.pop(context);

      // Error messages
      if (e.code == 'invalid-email') {
        errorMessage(
            "Email not found. Please enter a valid email, or register as a new account.",
            context);
      } else if (e.code == 'invalid-credential') {
        errorMessage(
            "The password you have entered is wrong. Please try again.",
            context);
      } else if (e.code == 'too-many-requests') {
        errorMessage(
            'You have tried too many time. Please try again later.', context);
      } else if (e.code == 'missing-password') {
        errorMessage("You have not added a password. Please add your password.",
            context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/PeopleBackground2.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // Fit the content size
                    children: [
                      // mq logo
                      Image.asset(
                        'assets/images/Macquarie_University Logo2.png',
                        width: 400,
                      ),
                      //welcome text
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          'Welcome to Macquarie University\'s Application!',
                          style: GoogleFonts.poppins(
                              fontSize: 18,
                              letterSpacing: 2.5,
                              color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      //email textfield
                      MyTextField(
                        controller: emailController,
                        hintText: Text(
                          'Your Email Goes Here.',
                          style: GoogleFonts.poppins(),
                        ),
                        obscureText: false,
                      ),

                      const SizedBox(
                        height: 25,
                      ),

                      //password textfield
                      MyTextField(
                        controller: passwordController,
                        hintText: Text(
                          'Your Password Goes Here.',
                          style: GoogleFonts.poppins(),
                        ),
                        obscureText: true,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Forgot Password?",
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      //sign in button
                      MyButton(
                        onTap: signUserIn,
                        str: "Sign In",
                      ),

                      const SizedBox(
                        height: 25,
                      ),

                      //my divider
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          children: [
                            const Expanded(
                              child: Divider(
                                thickness: 0.5,
                                color: Colors.black,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(
                                'Or continue with',
                                style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color:
                                        Colors.black),
                              ),
                            ),
                            const Expanded(
                              child: Divider(
                                thickness: 0.5,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),

                      //continue with Google Account
                      GestureDetector(
                        onTap: () => AuthService().signInWithGoogle(context),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(8.0),
                              border:
                                  Border.all(color: Colors.black, width: 0.5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Image.asset(
                                'assets/images/Google_Logo.png',
                                width: 40,
                              ),
                            ),
                          ),
                        ),
                      ),

                      //Not a memebr, register now
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Not a member?',
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Colors.black),
                            ),
                            const SizedBox(width: 4),
                            GestureDetector(
                              onTap: widget.onTap,
                              child: Text(
                                'Register now',
                                style: GoogleFonts.poppins(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
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
