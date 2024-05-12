// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:macquarie_application/constants/drawer_and_appbar.dart';
import 'package:macquarie_application/constants/login_button.dart';
import 'package:macquarie_application/constants/login_textfield.dart';
import 'package:macquarie_application/services/google_sign_in.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Email text controller.
  final emailController = TextEditingController();
  // Password text controller.
  final passwordController = TextEditingController();
  // Password confirmation controller.
  final confirmPasswordController = TextEditingController();

  // Sign user up.
  void signUserUp() async {
    // Show loading circle.
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    // Try creating a user.
    try {
      // Check if passwords match.
      if(passwordController.text == confirmPasswordController.text){
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Navigator.pop(context);
      }
      else{
        errorMessage('Passwords Do Not Match.', context);
      }
      // Pop the loading circle.
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // Pop the loading circle.
      Navigator.pop(context);
      // Error messages.
     if (e.code == 'invalid-email') {
        errorMessage(
            "Email not found. Please enter a valid email, or register as a new account.", context);
      } else if (e.code == 'invalid-credential') {
        errorMessage(
            "The password you have entered is wrong. Please try again.", context);
      } else if (e.code == 'too-many-requests') {
        errorMessage('You have tried too many time. Please try again later.', context);
      } else if (e.code == 'missing-password') {
        errorMessage(
            "You have not added a password. Please add your password.", context);
      }
      else if(e.code == 'email-already-in-use'){
        errorMessage('The email address is already in use by another account. Please use a new email, or Sign in.', context);
      }
      else if(e.code == 'weak-password'){
        errorMessage('Your password is weak, add a more robust passowrd.', context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Add a background.
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
                // Add a transparent white colored frame in front of the background for clearer text and info.
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Mq logo.
                      Image.asset(
                        'assets/images/Macquarie_University Logo2.png',
                        width: 400,
                      ),
                      // Welcome text.
                      Text(
                        'Welcome to Macquarie University\'s Application!',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          letterSpacing: 2.5,
                          color: Colors.black
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      // Email textfield.
                      MyTextField(
                        controller: emailController,
                        hintText: Text('Your Email Goes Here.',
                        style: GoogleFonts.poppins(
                          color: Colors.grey
                        ),),
                        obscureText: false,
                      ),

                      const SizedBox(
                        height: 15,
                      ),

                      // Password textfield.
                      MyTextField(
                        controller: passwordController,
                        hintText: Text('Your Password Goes Here.',
                        style: GoogleFonts.poppins(
                          color: Colors.grey
                        ),),
                        obscureText: true,
                      ),

                      const SizedBox(
                        height: 15,
                      ),

                      // Confirm password.
                      MyTextField(
                        controller: confirmPasswordController,
                        hintText: Text('Confirm Your Password.',
                        style: GoogleFonts.poppins(
                          color: Colors.grey
                        ),),
                        obscureText: true,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      // Sign up button.
                      MyButton(
                        onTap: signUserUp,
                        str: "Sign Up",
                      ),

                      const SizedBox(
                        height: 15,
                      ),

                      // My divider.
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
                                style: GoogleFonts.poppins(fontSize: 16,
                                color: Colors.black),
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

                      // Continue with Google Account.
                      GestureDetector(
                        onTap: () => AuthService().signInWithGoogle(context),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                  color: Colors.black,
                                  width: 0.5),
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

                      // Not a memebr, register now.
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account?',
                              style: GoogleFonts.poppins(fontSize: 16,
                              color: Colors.black),
                            ),
                            const SizedBox(width: 4),
                            GestureDetector(
                              onTap: widget.onTap,
                              child: Text(
                                'Log In Now',
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
