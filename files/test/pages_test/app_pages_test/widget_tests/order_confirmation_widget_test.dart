import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:macquarie_application/model/cart_model.dart';
import 'package:macquarie_application/pages/app_pages/order_confirmation_page.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('OrderConfirmation displays correct info', (WidgetTester tester) async {
    // Create an instance of CartModel
    final cartModel = CartModel();
    cartModel.addItemToCart(0);
    cartModel.addItemToCart(1);

    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<CartModel>.value(
          value: cartModel,
          child: const OrderConfirmation(
            total: '\$7.00',
            items: {'Coffee': 1},
            date: '2022-01-01',
            orderNumber: '123456',
            paymentMethod: 'Credit Card',
            user: '',
          ),
        ),
      ),
    );

    // Verify that all provided info is displayed correctly
    expect(find.text('Order Summary'), findsOneWidget);
    expect(find.text('2022-01-01'), findsOneWidget);
    expect(find.text('MQ123456'), findsOneWidget);
    expect(find.text('Credit Card'), findsOneWidget);
    expect(find.text('Quantity: 1'), findsWidgets);

    // Verify the display of item prices and total calculations
    expect(find.text('\$7.00'), findsOneWidget); // Total including GST
  });
}
