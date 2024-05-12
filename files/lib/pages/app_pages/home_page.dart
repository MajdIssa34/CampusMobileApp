import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:macquarie_application/data/news_data.dart';
import 'package:url_launcher/url_launcher.dart';

// Defines a StatefulWidget to handle dynamic content like fetching and displaying news.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// Private State class for HomePage which builds and manages the UI and its state.
class _HomePageState extends State<HomePage> {
  // Widget that builds the container to hold the UI elements for the news list.
  Widget myContainer() {
    return Container(
      // Background image of the container
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/PeopleBackground3.jpeg"),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 25, top: 25, right: 25, bottom: 100),
          // Inner container for padding and rounded borders.
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background.withOpacity(0.9),
                borderRadius: BorderRadius.circular(8.0),),
                // border: Border.all(
                //     color: Theme.of(context).colorScheme.primary, width: 2)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title for the news section.
                Text(
                  'Latest News',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const Divider(thickness: 2.5),
                // Expanded widget that contains a list of news items.
                Expanded(
                  child: ListView.builder(
                    itemCount: latestNews.length, // Number of news items
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          ListTile(
                            title: latestNews[index].title, // News title
                            titleTextStyle: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            subtitle: latestNews[index].description, // News description
                            subtitleTextStyle: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            onTap: () {
                              // On tap, launch the URL associated with the news item.
                              launchMyURL(latestNews[index].link);
                            },
                          ),
                          // Divider between news items, except after the last one.
                          if (index != latestNews.length - 1)
                            const Divider(
                              thickness: 2.5,
                            ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold provides the high-level structure of the page.
    return Scaffold(
      body: myContainer(),
    );
  }
}

// Helper method to launch URLs using the url_launcher package.
Future<void> launchMyURL(Uri uri) async {
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    throw 'Could not launch'; // Exception handling if the URL cannot be launched.
  }
}
