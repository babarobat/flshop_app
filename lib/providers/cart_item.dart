import 'package:flutter/material.dart';

class CartItem with ChangeNotifier {
  final String id;
  late int quantity = 0;

  CartItem(this.id);

  void addQuantity(int i) {
    quantity += i;
    notifyListeners();
  }
}
