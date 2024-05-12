import 'package:flutter_test/flutter_test.dart';
import 'package:macquarie_application/model/cart_model.dart';

void main() {
  group('CartModel Tests', () {
    final cartModel = CartModel();

    test('Adding an item increases total count', () {
      expect(cartModel.cartItems.isEmpty, true);

      cartModel.addItemToCart(0); // Add first coffee item (Cappuccino)
      expect(cartModel.cartItems.length, 1);
      expect(cartModel.cartItems[0], 1);
    });

    test('Adding same item increases quantity', () {
      cartModel.addItemToCart(0);
      expect(cartModel.cartItems[0], 2);
    });

    test('Removing item decreases quantity', () {
      cartModel.removeItemFromCart(0);
      expect(cartModel.cartItems[0], 1);
    });

    test('Removing last item removes it from the cart', () {
      cartModel.removeItemFromCart(0);
      expect(cartModel.cartItems.containsKey(0), false);
    });

    test('Calculating total price', () {
      cartModel.addItemToCart(1); // Add second coffee item (Espresso)
      cartModel.addItemToCart(1);
      // Total should be 2 * Espresso's price
      double price = double.parse(cartModel.coffeeItems[1][2]);
      expect(cartModel.calculateTotal(), (price * 2).toStringAsFixed(2));
    });
  });
}
