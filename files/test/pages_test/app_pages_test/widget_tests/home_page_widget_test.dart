import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:macquarie_application/pages/app_pages/home_page.dart';
void main() {
  testWidgets('Renders HomePage widget', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: HomePage()));

    // Verify if HomePage renders.
    expect(find.byType(HomePage), findsOneWidget);
  });

  testWidgets('Displays Latest News section', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomePage()));

    // Check if "Latest News" title is present
    expect(find.text('Latest News'), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget); // Ensures ListView is present
  });
}
