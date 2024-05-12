import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CoffeeItemsTile extends StatelessWidget {
  final String itemName;
  final String itemPrice;
  final String imagePath;
  final String description;
  final VoidCallback onPressed;

  const CoffeeItemsTile({
    super.key,
    required this.itemName,
    required this.description,
    required this.itemPrice,
    required this.imagePath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        height: 140, 
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background.withOpacity(0.7),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            // Image on the left.
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                    14), // Adjust the border radius as needed.
                child: Image.asset(
                  imagePath,
                  width: 100, // Adjust the size accordingly.
                  height: 100, // Adjust the size accordingly.
                  fit: BoxFit
                      .cover, // This is important for maintaining aspect ratio.
                ),
              ),
            ),
            // Texts and button on the right.
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    itemName,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    description,
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    '\$$itemPrice',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,             
                    ),
                  ),
                ],
              ),
            ),
            // Add to cart button.
            IconButton(
              icon:
                  Icon(Icons.add, color: Theme.of(context).colorScheme.primary),
              onPressed: onPressed,
            ),
          ],
        ),
      ),
    );
  }
}
