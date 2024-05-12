import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:macquarie_application/pages/app_pages/coffee_shops_list.dart';
import 'package:macquarie_application/data/coffee_shop_stores.dart';

void main() {
  Widget createCoffeeShopsPage() => const MaterialApp(
        home: CoffeeShopsPage(),
      );

  group('CoffeeShopsPage Widget Tests', () {
    testWidgets('Displays list of coffee shops', (WidgetTester tester) async {
      await tester.pumpWidget(createCoffeeShopsPage());
      await tester.pumpAndSettle(); // Wait for animations to settle

      // Check if coffee shops are displayed
      for (var shop in coffeeShops) {
        expect(find.text(shop['name'].toString()), findsWidgets);
        expect(find.text(shop['isOpen'] == true ? 'Open' : 'Closed'),
            findsWidgets);
      }
    });

    testWidgets('Expanding a coffee shop shows details',
        (WidgetTester tester) async {
      await tester.pumpWidget(createCoffeeShopsPage());
      await tester.pumpAndSettle();

      final shopName = coffeeShops[0]['name'].toString();

      // Tap to expand the first coffee shop
      await tester.tap(find.text(shopName));
      await tester.pumpAndSettle();

      // Check that details are shown
      expect(
          find.text('Address: ${coffeeShops[0]['address']}'), findsOneWidget);
      expect(find.text('Popular Item: ${coffeeShops[0]['popularItem']}'),
          findsOneWidget);
      expect(find.text('Description: ${coffeeShops[0]['description']}'),
          findsOneWidget);
    });

    testWidgets('Check the presence of the "Tap to visit shop page" button',
        (WidgetTester tester) async {
      await tester.pumpWidget(createCoffeeShopsPage());
      await tester.pumpAndSettle();

      final shopName = coffeeShops[2]['name'].toString();

      // Tap to expand the first coffee shop
      await tester.tap(find.text(shopName));
      await tester.pumpAndSettle();

      // Check that the button text is found once
      expect(find.text('Tap to visit shop page'), findsOneWidget);
    });
  });
}
