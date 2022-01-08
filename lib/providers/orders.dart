import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shop_app/providers/order.dart';
import 'package:shop_app/providers/products.dart';

class Orders with ChangeNotifier {
  final List<Order> _items = [];
  late DatabaseApi _databaseApi;

  Orders(DatabaseApi db) {
    _databaseApi = db;
  }

  List<Order> get items => [..._items];

  Future add(Order order) async {
    var response = await _databaseApi.addOrder(order);

    var id = json.decode(response.body)['name'];

    var newOrder = Order(
      id: id,
      total: order.total,
      items: order.items,
      date: order.date,
    );

    _items.add(newOrder);
    notifyListeners();
  }

  Future fetch() async {

    var response = await _databaseApi.fetchOrders();
    var decoded = json.decode(response.body);

    _items.clear();

    decoded.forEach((id, data) {
      var newProduct = Order.fromJson(data, id);
      _items.add(newProduct);
    });

    notifyListeners();
  }
}
