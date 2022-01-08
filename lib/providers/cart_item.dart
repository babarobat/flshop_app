import 'package:flutter/material.dart';

class CartItem with ChangeNotifier {
  final String id;
  final String title;
  final double price;
  final String imageUrl;
  late int quantity = 0;

  CartItem(
      {required this.id,
      required this.imageUrl,
      required this.price,
      required this.title,
      this.quantity = 0});

  get total => price * quantity;

  void addQuantity(int i) {
    quantity += i;
    notifyListeners();
  }

  void removeQuantity(int i) {
    quantity -= i;
    notifyListeners();
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'price': price,
      'imageUrl': imageUrl,
      'quantity': quantity,
    };
  }

  static CartItem fromJson(Map<String, dynamic> data) {
    return CartItem(
      id: data['id']??'',
      title: data['title']??'',
      price: data['price']??0,
      imageUrl: data['imageUrl']??'',
      quantity: data['quantity']??0,
    );
  }
}
