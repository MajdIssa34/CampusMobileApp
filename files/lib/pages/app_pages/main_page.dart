import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:macquarie_application/constants/drawer_and_appbar.dart'; // Custom app bar and drawer configurations.
import 'package:macquarie_application/pages/app_pages/coffee_shops_list.dart'; // Coffee shops list page.
import 'package:macquarie_application/pages/app_pages/home_page.dart'; // Home page of the app.
import 'package:macquarie_application/pages/app_pages/map_page.dart'; // Map page for location services.
import 'package:macquarie_application/pages/app_pages/parking_page.dart'; // Parking information page.
import 'package:url_launcher/url_launcher.dart'; // Package for URL launching.

// Defines the MainPage widget, which acts as the root of the navigation for the app.
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

// State class for MainPage handling the dynamic aspects like tab navigation and page displays.
class _MainPageState extends State<MainPage> {
 
  // List of pages to be shown based on the selected tab in the navigation bar.
  final pages = [
    const HomePage(),
    const MapPage(),
    const CoffeeShopsPage(),
    const ParkingPage(),
  ];

  int selectedIndex = 0;

  // Method to launch URLs, useful for links that might be used within the pages.
  Future<void> launchMyURL(Uri uri) async {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri); // Launches the URL if possible.
    } else {
      throw 'Could not launch'; // Throws an exception if URL cannot be launched.
    }
  }

  List<IconData> navIcons = [
    Icons.home,
    Icons.map_outlined,
    Icons.coffee,
    Icons.local_parking_outlined,
  ];

  List<String> navTitles = ["Home", "Map", "Coffee", "Parking"];

  Widget _navBar() {
    return Container(
      height: 65,
      margin: const EdgeInsets.only(right: 24, left: 24, bottom: 10),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background.withOpacity(0.9),
          borderRadius: BorderRadius.circular(20)),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: navIcons.map((icon) {
            int index = navIcons.indexOf(icon);
            bool isSelected = selectedIndex == index;
            return Material(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment:CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(10),
                        child: Icon(
                          icon,
                          color: isSelected
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.5),
                        ),
                      ),
                      Text(
                        navTitles[index],
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: isSelected
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.5),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }).toList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          pages[selectedIndex],
          Align(alignment: Alignment.bottomCenter, child: _navBar()),
        ],
      ), // Displays the page based on the currently selected tab index.
      appBar: myAppBar(
          context), // Custom app bar defined in a separate constants file.
      drawer: myDrawer(context,
          selectedIndex), // Custom drawer also defined in a separate constants file.
    );
  }
}
