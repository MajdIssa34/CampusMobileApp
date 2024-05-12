import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:macquarie_application/data/map_page_data.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dots_indicator/dots_indicator.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final PageController _pageController = PageController();
  double _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentIndex = _pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/MapBackground.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 25, top: 25, right: 25, bottom: 100),
              child: Container(
                decoration: BoxDecoration(
                  color:
                      Theme.of(context).colorScheme.background.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        "MQ University Map",
                        style: GoogleFonts.poppins(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Text(
                      "Zoom in and out as needed.",
                      style: GoogleFonts.poppins(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(25),
                        // InteractiveViewer for zooming and panning the map.
                        child: InteractiveViewer(
                          panEnabled: true, // Allows panning.
                          minScale: 0.5, // Minimum zoom scale.
                          maxScale: 4, // Maximum zoom scale.
                          child: Image.asset(
                            'assets/images/CampusMap.png', // The map image asset.
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "Swipe left and right for more information.",
                      style: GoogleFonts.poppins(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 180,
                      child: PageView(
                        controller: _pageController,
                        children: <Widget>[
                          displayInformation('Hospital'),
                          displayInformation('School of Computing'),
                          displayInformation('Library'),
                          displayInformation('School of Engineering'),
                          displayInformation('School of Natural Science'),
                          displayInformation('Central Courtyard'),
                        ],
                      ),
                    ),
                    DotsIndicator(
                      dotsCount: 6,
                      position: _currentIndex,
                      decorator: DotsDecorator(
                        activeColor: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget displayInformation(String name) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment
              .spaceEvenly, // This will space the children evenly
          children: [
            Text(
              name,
              style: GoogleFonts.poppins(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10,),
            Text(
              "For more information about the MQ $name, please visit the website.",
              style: GoogleFonts.poppins(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              onPressed: () {
                launchUrl(Uri.parse(
                    mapData[name] ?? '')); // Launches the URL for more info.
              },
              child: Text(
                'Visit website',
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.background),
              ),
            )
          ],
        ),
      ),
    );
  }
}
