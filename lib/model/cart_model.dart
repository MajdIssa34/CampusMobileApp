import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  // List of available items.
  final List _coffeeItems = [
    [
      'Cappucino',
      'Indulge in the balanced and velvety experience of our cappuccino.',
      '7.00',
      'assets/images/Cappucino.jpg'
    ],
    [
      'Espresso',
      'Savor the rich, intense flavor and creamy texture of our espresso.',
      '5.50',
      'assets/images/Espresso.jpg'
    ],
    [
      'Iced Coffee',
      'Refresh with our iced coffee, perfect for warm weather.',
      '7.50',
      'assets/images/IcedCoffee.jpg'
    ],
    [
      'Americano',
      'Enjoy the bold taste of our Americano, a diluted espresso drink.',
      '6.25',
      'assets/images/Americano.jpg'
    ],
    [
      'Latte',
      'Immerse in the creamy goodness of our latte.',
      '6.60',
      'assets/images/Latte.jpg'
    ],
  ];

  // Map to store items in the cart and their quantities.
  final Map<int, int> _cartItems = {};

  // Get all items.
  List get coffeeItems => _coffeeItems;

  // Get all cart items.
  Map<int, int> get cartItems => _cartItems;

  // Add an item to cart.
  void addItemToCart(int index) {
    if (_cartItems.containsKey(index) && _cartItems[index] != null) {
      _cartItems[index] = _cartItems[index]! + 1;
    } else {
      _cartItems[index] = 1;
    }
    notifyListeners();
  }

  // Remove an item from the cart.
  void removeItemFromCart(int index) {
    if (_cartItems.containsKey(index) && _cartItems[index] != null) {
      if (_cartItems[index]! > 1) {
        _cartItems[index] = _cartItems[index]! - 1;
      } else {
        _cartItems.remove(index);
      }
    }
    notifyListeners();
  }

  // Calculate cart total.
  String calculateTotal() {
    double total = 0.0;
    _cartItems.forEach((index, quantity) {
      double price = double.parse(_coffeeItems[index][2]);
      total += price * quantity;
    });
    return total.toStringAsFixed(2);
  }

  // Return cart item names with quantities.
  Map<String, int> getItemNames() {
    Map<String, int> nameQuantities = {};
    _cartItems.forEach((index, quantity) {
      String name = _coffeeItems[index]
          [0]; // Get the item name from the coffee items listm
      nameQuantities[name] = quantity; // Map the name to its quantity.
    });
    return nameQuantities;
  }

  // Remove all items from the cart.
  void removeAllItems() {
    _cartItems.clear();
    notifyListeners();
  }
}
