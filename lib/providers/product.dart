import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  var isFavorite = false;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  void toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'price': price,
      'image_url': imageUrl,
      'is_favorite': isFavorite,
    };
  }

  static Product fromJson(Map<String, dynamic> data, String id) {
    return Product(
      id: id,
      title: data['title']??'',
      description: data['description']??'',
      price: data['price']??0,
      imageUrl: data['image_url']??'',
      isFavorite: data['isFavorite']??false,
    );
  }
}
