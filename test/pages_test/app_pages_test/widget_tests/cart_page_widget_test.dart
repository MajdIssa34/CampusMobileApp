import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:macquarie_application/pages/app_pages/cart_page.dart';
import 'package:provider/provider.dart';
import 'package:macquarie_application/model/cart_model.dart';

void main() {
  Widget createCartPage() => MaterialApp(
        home: ChangeNotifierProvider(
          create: (_) => CartModel(),
          child: const CartPage(),
        ),
      );

  group('CartPage Widget Tests', () {
    testWidgets('App bar title is correct', (WidgetTester tester) async {
      await tester.pumpWidget(createCartPage());
      expect(find.text('Your cart'), findsOneWidget);
    });

    testWidgets('Shows Empty Cart Message when cart is empty',
        (WidgetTester tester) async {
      await tester.pumpWidget(createCartPage());
      expect(find.text('Your shopping cart is empty.'), findsOneWidget);
    });

    testWidgets('Displays cart items when added', (WidgetTester tester) async {
      await tester.pumpWidget(createCartPage());
      CartModel model = Provider.of<CartModel>(
          tester.element(find.byType(CartPage)),
          listen: false);
      model.addItemToCart(0); // Assuming 0 is a valid index for coffeeItems
      await tester.pumpAndSettle();

      expect(find.text('Cappucino x 1'), findsOneWidget);
      expect(find.byType(Image), findsWidgets);
    });

    testWidgets('Can remove item from cart', (WidgetTester tester) async {
      await tester.pumpWidget(createCartPage());
      CartModel model = Provider.of<CartModel>(
          tester.element(find.byType(CartPage)),
          listen: false);
      model.addItemToCart(0); // Add item first
      await tester.pumpAndSettle(); // Wait for the UI to update

      // Remove the item now
      await tester.tap(find.byIcon(Icons.delete));
      await tester.pumpAndSettle();

      expect(find.text('Cappucino x 1'), findsNothing);
      expect(find.text('Your shopping cart is empty.'), findsOneWidget);
    });
  });
}
