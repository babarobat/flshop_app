import 'package:flutter/material.dart';

class CartItem with ChangeNotifier {
  final String id;
  final double price;
  late int quantity = 0;

  CartItem(this.id, this.price);

  get total => price * quantity;

  void addQuantity(int i) {
    quantity += i;
    notifyListeners();
  }
}
