import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:macquarie_application/pages/app_pages/map_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  // Enables use of Google Fonts in tests
  GoogleFonts.config.allowRuntimeFetching = false;

  group('MapPage Tests', () {
    testWidgets('Initial UI is correct', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: MapPage()));
      expect(find.byType(Image), findsOneWidget); // Check for background image
      expect(find.text('MQ University Map'), findsOneWidget);
      expect(
          find.byType(ElevatedButton), findsNWidgets(1)); // Number of buttons
    });

    testWidgets('MapPage builds correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: MapPage()));

    // Verify that the key elements are present.
    expect(find.text('MQ University Map'), findsOneWidget);
    expect(find.byType(PageView), findsOneWidget);
    expect(find.text('Visit website'), findsWidgets); // Checks if the button text is present in each tile
  });

  testWidgets('PageView scrolls and updates dot indicator', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: MapPage()));

    // Initial state of the dots indicator
    expect(find.byWidgetPredicate((Widget widget) => widget is DotsIndicator && widget.position == 0), findsOneWidget);

    // Perform a drag gesture to scroll to the next page
    await tester.drag(find.byType(PageView), const Offset(-400.0, 0.0));
    await tester.pumpAndSettle(); // Finish the animation

    // After scroll, check the position of the dots indicator
    expect(find.byWidgetPredicate((Widget widget) => widget is DotsIndicator && widget.position == 1), findsOneWidget);
  });
  });
}
