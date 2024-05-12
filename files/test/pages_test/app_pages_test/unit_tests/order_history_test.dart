import 'package:flutter_test/flutter_test.dart';
import 'package:macquarie_application/pages/app_pages/order_history.dart';
import 'package:macquarie_application/stored_data/user_history.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await OrderHistory.init(); // Initializes with mocked SharedPreferences
  });

  Widget createOrderHistoryPage() => MaterialApp(
        home: Provider<OrderHistory>(
          create: (_) => OrderHistory(),
          child: const OrderHistoryPage(),
        ),
      );

  group('OrderHistoryPage Tests', () {
    testWidgets('Removing a single order', (WidgetTester tester) async {
      // Add some orders first
      await OrderHistory.addOrder('20.00', {'Coffee': 2}, '2023-04-01',
          '000001', 'Credit Card', 'user@example.com');
      await OrderHistory.addOrder('15.00', {'Tea': 3}, '2023-04-02', '000002',
          'Debit Card', 'user@example.com');

      await tester.pumpWidget(createOrderHistoryPage());
      await tester.pumpAndSettle(); // Allow time for orders to load

      // Simulate deleting the first order
      await tester.tap(find.byIcon(Icons.delete).first);
      await tester.pumpAndSettle(); // Rebuild the widget after state change

      // Check that only one order remains
      final orders = OrderHistory.getOrders();
      expect(orders.length, 1);
      expect(orders.first['orderNumber'],
          '000002'); // Ensure the correct order remains
    });

    testWidgets('Removing all orders', (WidgetTester tester) async {
      // Add some orders first
      await OrderHistory.addOrder('20.00', {'Coffee': 2}, '2023-04-01',
          '000001', 'Credit Card', 'user@example.com');
      await OrderHistory.addOrder('15.00', {'Tea': 3}, '2023-04-02', '000002',
          'Debit Card', 'user@example.com');

      await tester.pumpWidget(createOrderHistoryPage());
      await tester.pumpAndSettle(); // Allow time for orders to load

      // Simulate tapping the delete all button
      await tester.tap(find.byIcon(Icons.delete_forever));
      await tester.pumpAndSettle(); // Rebuild the widget after state change

      // Check that no orders remain
      final orders = OrderHistory.getOrders();
      expect(orders.isEmpty, true);
    });
    testWidgets('Displays the correct number of orders initially',
        (WidgetTester tester) async {
      // Assuming two orders are added
      await OrderHistory.addOrder('10.00', {'Latte': 1}, '2023-04-01', '000001',
          'Cash', 'user1@example.com');
      await OrderHistory.addOrder('15.50', {'Espresso': 2}, '2023-04-02',
          '000002', 'Credit', 'user2@example.com');

      await tester.pumpWidget(createOrderHistoryPage());
      await tester.pumpAndSettle();

      // Verify that two ListTile widgets are present (one for each order)
      expect(find.byType(ListTile), findsNWidgets(2));
    });

    testWidgets('Correct total displayed for orders',
        (WidgetTester tester) async {
      // Add a single order
      await OrderHistory.addOrder('23.75', {'Cappuccino': 3}, '2023-05-01',
          '000003', 'Debit', 'user3@example.com');

      await tester.pumpWidget(createOrderHistoryPage());
      await tester.pumpAndSettle();

      // Verify total price is displayed correctly
      expect(find.text('Order Total is: 23.75'), findsOneWidget);
    });

    testWidgets('Order details are displayed correctly',
        (WidgetTester tester) async {
      // Add an order
      await OrderHistory.addOrder('5.00', {'Tea': 2}, '2023-05-02', '000004',
          'Debit', 'user4@example.com');

      await tester.pumpWidget(createOrderHistoryPage());
      await tester.pumpAndSettle();

      // Verify details like order number and payment method
      expect(find.text('MQ000004'), findsOneWidget);
      expect(find.text('Debit'), findsOneWidget);
    });
  });
}
