import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:macquarie_application/pages/app_pages/parking_page.dart';

void main() {
  testWidgets('ParkingPage loads with correct layout',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: ParkingPage()));

    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.text("Let's find you a parking space."), findsOneWidget);
    expect(find.byType(Icon), findsNWidgets(12));
  });
  testWidgets('Interactive elements render correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: ParkingPage()));

    // Check for interactive buttons
    final motoButton = find.byIcon(Icons.motorcycle);
    final carButton = find.byIcon(Icons.directions_car);
    final suvButton = find.byIcon(Icons.car_rental);

    expect(motoButton, findsOneWidget);
    expect(carButton, findsOneWidget);
    expect(suvButton, findsOneWidget);

    // Check for text on buttons
    expect(find.text('Moto'), findsOneWidget);
    expect(find.text('Car'), findsOneWidget);
    expect(find.text('SUV'), findsOneWidget);
  });
}
