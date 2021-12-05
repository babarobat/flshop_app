import 'package:flutter/material.dart';

import 'order.dart';

class Orders with ChangeNotifier{
  final List<Order> _items = [];

  void add(List<Order> items) {
    _items.addAll(items);
  }
}