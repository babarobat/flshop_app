import 'package:flutter/material.dart';

class CartItem with ChangeNotifier {
  final String id;
  final String title;
  final double price;
  final String imageUrl;
  late int quantity = 0;


  CartItem({required this.id, required this.imageUrl, required this.price, required this.title});

  get total => price * quantity;

  void addQuantity(int i) {
    quantity += i;
    notifyListeners();
  }
}
