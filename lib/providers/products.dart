import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'product.dart';

class Products with ChangeNotifier {
  final List<Product> _items = [];
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

  Future fetch() async {
    var response = await _databaseApi.fetch();
    var decoded = json.decode(response.body) as Map<String, dynamic>;

    _items.clear();

    decoded.forEach((id, data) {
      _items.add(Product.fromJson(data, id));
    });

    notifyListeners();
  }

  Future add(Product product) async {
    var response = await _databaseApi.add(product);

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

  Future update(Product product) async{
    var index = _items.indexWhere((x) => x.id == product.id);
    if (index < 0) {
      throw Exception('Cant update element. Wrong index');
    }

    await _databaseApi.update(product);
    _items[index] = product;
    notifyListeners();
  }

  void delete(String id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}

class FirebaseDatabase with DatabaseApi {
  static const String _domain =
      'https://flutter-shop-app-f9f78-default-rtdb.europe-west1.firebasedatabase.app';
  static const String _products = '/products';
  static const String _definition = '.json';

  @override
  Future<Response> add(Product product) {
    var uri = Uri.parse(_domain + _products + _definition);
    var map = product.toJson();
    var body = json.encode(map);
    return post(uri, body: body).catchError((error) => print(error));
  }

  @override
  Future<Response> fetch() {
    var uri = Uri.parse(_domain + _products + _definition);
    return get(uri).catchError((error) => print(error));
  }

  @override
  Future<Response> update(Product product) {
    var uri = Uri.parse(_domain + _products + '/${product.id}' + _definition);
    var map = product.toJson();
    var body = json.encode(map);
    return patch(uri, body: body).catchError((error) => print(error));
  }
}

abstract class DatabaseApi {
  Future<Response> add(Product product);
  Future<Response> fetch();
  Future<Response> update(Product product);
//void delete();
}
