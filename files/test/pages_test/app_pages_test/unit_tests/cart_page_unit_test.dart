import 'package:flutter_test/flutter_test.dart';
import 'package:macquarie_application/model/cart_model.dart';

void main() {
  group('CartModel Tests', () {
    test('Adding an item increases total quantity', () {
      var cart = CartModel();
      var item = 1;

      cart.addItemToCart(item);
      expect(cart.cartItems.length, 1);
    });

    test('Removing an item decreases total quantity', () {
      var cart = CartModel();
      var item =0;

      cart.addItemToCart(item);
      cart.removeItemFromCart(item);
      expect(cart.cartItems.length, 0);
    });

    test('Total price calculation is correct', () {
      var cart = CartModel();
      cart.addItemToCart(0);
      cart.addItemToCart(1);

      expect(cart.calculateTotal(), '12.50');
    });
    test('Clearing cart removes all items', () {
      var cart = CartModel();
      cart.addItemToCart(0);
      cart.addItemToCart(1);
      cart.addItemToCart(2);

      cart.removeAllItems();
      expect(cart.cartItems.isEmpty, true);
    });

    test('Total recalculates to zero after clearing the cart', () {
      var cart = CartModel();
      cart.addItemToCart(0);
      cart.addItemToCart(1);
      cart.addItemToCart(2);

      cart.removeAllItems();
      expect(cart.calculateTotal(), '0.00');
    });
  });
}
