import 'package:flutter/material.dart';

import 'cart_item.dart';

class Cart with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  int get itemsCountWithQuantities => _items.values
      .fold(0, (int quantity, cartItem) => cartItem.quantity + quantity);

  double get getTotal => _items.values
      .fold(0.0, (double total, cartItem) => cartItem.total + total);

  List<CartItem> get items => _items.values.toList();

  void add(String productId, String title, double price, String imageUrl) {
    if (!_items.containsKey(productId)) {
      _items[productId] = CartItem(
        id: productId,
        imageUrl: imageUrl,
        title: title,
        price: price,
      );
    }
    _items[productId]!.addQuantity(1);
    notifyListeners();
  }

  void remove(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
