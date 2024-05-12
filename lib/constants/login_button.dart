
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String str;
  const MyButton({super.key, required this.onTap, required this.str});

  // Re-using some code for Login page and register page.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            str,
            style: GoogleFonts.lora(
              fontSize:16,
              color: Colors.white,
              ),
            ),
          ),
        ),
      );
  }
}