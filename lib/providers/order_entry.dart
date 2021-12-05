import 'package:flutter/material.dart';
import 'package:shop_app/providers/cart_item.dart';

class OrderEntry with ChangeNotifier {
  final DateTime date;
  final double total;
  final List<CartItem> items;

  OrderEntry({
    required this.items,
    required this.date,
    required this.total,
  });
}
