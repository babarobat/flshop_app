import 'package:flutter/material.dart';
import 'package:shop_app/providers/cart_item.dart';

class Order with ChangeNotifier {
  final String id;
  final DateTime date;
  final double total;
  final List<CartItem> items;

  Order({
    required this.id,
    required this.items,
    required this.date,
    required this.total,
  });

  Map toJson() {
    return {
      'date': date.toIso8601String(),
      'total': total,
      'items': items.map((e) => e.toJson()).toList(),
    };
  }

  static Order fromJson(Map<String, dynamic> data, String id) {
    var itemsList = data['items'] ?? [];
    var items = <CartItem>[];
    for (var entry in itemsList) {
      items.add(CartItem.fromJson(entry));
    }


    return Order(
      id: id,
      date: data['date'] == null? DateTime.now():DateTime.parse(data['date']),
      total: data['total'] ?? 0,
      items: items,
    );
  }
}
