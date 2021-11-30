import 'package:flutter/material.dart';

import 'cart_item.dart';

class Cart with ChangeNotifier{
  final Map<String,CartItem> _items = {};

  get itemsCount =>_items.values
      .fold(0, (int quantity, cartItem) => cartItem.quantity + quantity);

  void add(String productId) {
    if (!_items.containsKey(productId)){
      _items[productId] = CartItem(productId);
    }
    _items[productId]!.addQuantity(1);
    notifyListeners();
  }
}