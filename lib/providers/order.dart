import 'package:flutter/cupertino.dart';
import 'package:shop_app/providers/order_entry.dart';

class Order with ChangeNotifier {
  final List<OrderEntry> _items = [];

  List<OrderEntry> get items => [..._items];

  void add(OrderEntry order) {
    _items.add(order);
    notifyListeners();
  }
}
