import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// StatefulWidget to handle the dynamic aspects of the parking page, like updating UI based on user interaction.
class ParkingPage extends StatefulWidget {
  const ParkingPage({super.key});

  @override
  State<ParkingPage> createState() => _ParkingPageState();
}

// State class for ParkingPage to manage its state.
class _ParkingPageState extends State<ParkingPage> {
  @override
  Widget build(BuildContext context) {
    // Scaffold provides the high-level structure of the page.
    return Scaffold(
      body: Container(
        // Background decoration with an image.
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/MapBackground.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 25, top: 25, right: 25, bottom: 100),
              // Container for content with a translucent background.
              child: Container(
                height: 1000,
                decoration: BoxDecoration(
                  color:
                      Theme.of(context).colorScheme.background.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        // Header text for the page.
                        Text(
                          "Let's find you a parking space.",
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Row to display parking options (Moto, Car, SUV).
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildParkingOption(
                                  context,
                                  'Moto',
                                  Icons.motorcycle,
                                  Theme.of(context)
                                      .colorScheme
                                      .background
                                      .withOpacity(0.8)),
                              _buildParkingOption(
                                  context,
                                  'Car',
                                  Icons.directions_car,
                                  Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.6)),
                              _buildParkingOption(
                                  context,
                                  'SUV',
                                  Icons.car_rental,
                                  Theme.of(context)
                                      .colorScheme
                                      .background
                                      .withOpacity(0.8)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Image.asset(
                          "assets/images/Car.png",
                          height: 200,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Available Parking Lots:',
                          style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        const SizedBox(height: 20),
                        // Row showing all available parking lots.
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            _buildParkingLot(
                                context,
                                'Lot A',
                                '2.5 km',
                                '5 spots',
                                Icons.location_on,
                                Icons.local_parking),
                            _buildParkingLot(
                                context,
                                'Lot B',
                                '3.1 km',
                                '3 spots',
                                Icons.location_on,
                                Icons.local_parking),
                            _buildParkingLot(
                                context,
                                'Lot C',
                                '1.8 km',
                                '7 spots',
                                Icons.location_on,
                                Icons.local_parking),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget to build individual parking options.
  Widget _buildParkingOption(BuildContext context, String vehicleType,
      IconData iconData, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              iconData,
              size: 40,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 10),
            Text(
              vehicleType,
              style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.primary),
            ),
          ],
        ),
      ),
    );
  }

  // Widget to build individual parking lot information with icons and a button.
  Widget _buildParkingLot(BuildContext context, String lotName, String distance,
      String availableSpaces, IconData locationIcon, IconData parkingIcon) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background.withOpacity(0.8),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Icon(locationIcon, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 4),
            Text(
              lotName,
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.directions_walk,
                    color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 4),
                Text(
                  distance,
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.primary),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(parkingIcon, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 4),
                Text(
                  availableSpaces,
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.primary),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                // No action.
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 8), // Adjusted padding
              ),
              child: Text(
                'Reserve',
                style: GoogleFonts.poppins(
                  fontSize: 12, // Reduced font size
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis, // Prevent text from wrapping
              ),
            ),
          ],
        ),
      ),
    );
  }
}
