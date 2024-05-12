import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class OrderHistory {
  static late SharedPreferences _preferences;
  static const _keyOrders = 'orders';

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // Save a new order to the list of all orders
  static Future addOrder(String total, Map<String, int> items, String date,
      String orderNumber, String paymentMethod, String user) async {
    List<dynamic> orders = getOrders(); // Retrieve existing orders
    Map<String, dynamic> newOrder = {
      "total": total,
      "items": items,
      "date": date, // Add date of the order
      "orderNumber": orderNumber, // Add order number
      "paymentMethod": paymentMethod, // Add payment method
      "user": user
    };
    orders.add(newOrder); // Add new order to the list
    String ordersJson = jsonEncode(orders);
    await _preferences.setString(_keyOrders, ordersJson);
  }

  // Retrieve all orders
  static List<Map<String, dynamic>> getOrders() {
    String ordersJson = _preferences.getString(_keyOrders) ?? '[]';
    List<dynamic> ordersList = jsonDecode(ordersJson);
    return List<Map<String, dynamic>>.from(ordersList);
  }

  // Remove an order
  static Future removeOrder(int index) async {
    List<Map<String, dynamic>> orders = getOrders();
    if (index < orders.length) {
      orders.removeAt(index);
      String ordersJson = jsonEncode(orders);
      await _preferences.setString(_keyOrders, ordersJson);
    }
  }

  static Future removeAllOrders() async {
    await _preferences.remove(_keyOrders);
  }
}
