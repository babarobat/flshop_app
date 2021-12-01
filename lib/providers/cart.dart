import 'package:flutter/material.dart';

import 'cart_item.dart';

class Cart with ChangeNotifier{
  final Map<String,CartItem> _items = {};

  int get itemsCount =>_items.values
      .fold(0, (int quantity, cartItem) => cartItem.quantity + quantity);

  double get getTotal => _items.values.fold(0.0, (double total, cartItem) => cartItem.total + total);

  void add(String productId, double price) {
    if (!_items.containsKey(productId)){
      _items[productId] = CartItem(productId, price);
    }
    _items[productId]!.addQuantity(1);
    notifyListeners();
  }
}