// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:macquarie_application/constants/drawer_and_appbar.dart';
class AuthService {

  signInWithGoogle(BuildContext context) async {
    if (kIsWeb || !Platform.isAndroid) {
      // Show error message if the platform is web or not Android
      errorMessage("Google Sign-In is only available on Android devices.", context);
      return;
    }

    errorMessage("Signing In With Google.", context);

    try {
      // Step 1: Perform sign-in using Google Sign-In.
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
  
      if (gUser != null) {
        // Step 2: After successfully signing in, retrieve the authentication details of the user.
        final GoogleSignInAuthentication gAuth = await gUser.authentication;

        // Step 3: Create a new credential for Firebase, using the token details retrieved.
        final credential = GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken,
          idToken: gAuth.idToken,
        );

        // Step 4: Use the created credential to sign in with Firebase and return the resulting UserCredential.
        UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
        ScaffoldMessenger.of(context).hideCurrentSnackBar();        
        return userCredential;
      }
    } catch (e) {
      errorMessage("Failed to Sign In With Google: ${e.toString()}", context);
    }
  }
}
