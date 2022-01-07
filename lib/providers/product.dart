import 'package:flutter/material.dart';

class Product with ChangeNotifier{
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
  });

  void toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }


  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'price': price,
    'image_url': imageUrl,
    'is_favorite': isFavorite,
  };
}
