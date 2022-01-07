import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'product.dart';

class Products with ChangeNotifier {
  final List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  final DatabaseApi _databaseApi = FirebaseDatabase();

  int get count => _items.length;

  List<Product> getAll() => [..._items];

  List<Product> getFavorites() =>
      _items.where((element) => element.isFavorite).toList();

  Product? getById(String id) {
    if (_items.any((element) => element.id == id)) {
      return _items.firstWhere((x) => x.id == id);
    }
    return null;
  }

  Future add(Product product) {
    return _databaseApi.add(product).then((response) => _onAddResponse(product, response));
  }

  void update(String id, Product newProduct) {
    var index = _items.indexWhere((x) => x.id == id);
    if (index < 0) {
      throw Exception('Cant update element. Wrong index');
    }

    _items[index] = newProduct;
    notifyListeners();
  }

  void delete(String id) {
    _items.removeWhere((element) => element.id == id);

    notifyListeners();
  }

  void _onAddResponse(Product product, Response response) {
    var id = json.decode(response.body)['name'];

    var newProduct = Product(
      id: id,
      title: product.title,
      price: product.price,
      description: product.description,
      imageUrl: product.imageUrl,
    );

    _items.add(newProduct);
    notifyListeners();
  }
}

class FirebaseDatabase with DatabaseApi {
  static const String _domain =
      'flutter-shop-app-f9f78-default-rtdb.europe-west1.firebasedatabase.app';
  static const String _databaseId = '/products.json';

  @override
  Future<Response> add(Product product) {
    var uri = Uri.https(_domain, _databaseId);
    var body = json.encode(product.toJson());

    return post(uri, body: body);
  }
}

abstract class DatabaseApi {
  Future<Response> add(Product product);
//void update();
//void delete();
}
