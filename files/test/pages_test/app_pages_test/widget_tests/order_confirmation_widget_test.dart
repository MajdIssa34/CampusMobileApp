import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:macquarie_application/pages/app_pages/order_confirmation_page.dart';

void main() {
  group('OrderConfirmation Widget Tests', () {
    testWidgets('displays correct texts and calculates totals properly', (WidgetTester tester) async {
      // Providing mock data for the test
      const String testTotal = "90.00";
      final Map<String, int> testItems = {'Cappucino': 2, 'Espresso': 1};
      final Map<String, Map<String, dynamic>> testItemDetails = {
        'Cappucino': {'quantity': 2, 'price': '7.00', 'imagePath': 'assets/images/Cappucino.jpg'},
        'Espresso': {'quantity': 1, 'price': '5.50', 'imagePath': 'assets/images/Espresso.jpg'}
      };
      const String testDate = '2024-05-12';
      const String testOrderNumber = '001234';
      const String testPaymentMethod = 'Credit Card';
      const String testUser = 'user@example.com';

      // Creating the widget
      await tester.pumpWidget(MaterialApp(
        home: OrderConfirmation(
          total: testTotal,
          items: testItems,
          date: testDate,
          orderNumber: testOrderNumber,
          paymentMethod: testPaymentMethod,
          user: testUser,
          itemsDetails: testItemDetails,
        ),
      ));

      // Checking for the Date, Order No., Payment Method, and Total
      expect(find.text('Date'), findsOneWidget);
      expect(find.text(testDate), findsOneWidget);
      expect(find.text('Order No.'), findsOneWidget);
      expect(find.text('MQ001234'), findsOneWidget);
      expect(find.text('Payment Method'), findsOneWidget);
      expect(find.text(testPaymentMethod), findsOneWidget);
      expect(find.text('\$90.00'), findsOneWidget); // Total

      // Check for item names, quantities, and prices
      expect(find.text('Cappucino'), findsOneWidget);
      expect(find.text('Espresso'), findsOneWidget);
      expect(find.text('Quantity: 2'), findsOneWidget);
      expect(find.text('Quantity: 1'), findsOneWidget);
      expect(find.text('\$7.00'), findsOneWidget);
      expect(find.text('\$5.50'), findsOneWidget);

      // Check images are loaded with correct paths
      final Image image = tester.widget(find.byType(Image).first) as Image;
      expect(image.image, isA<AssetImage>());
      expect((image.image as AssetImage).assetName, 'assets/images/Cappucino.jpg');
    });
  });
}
