import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'product.dart';

class Products with ChangeNotifier {
  final List<Product> _items = [];
  late DatabaseApi _databaseApi;

  Products(DatabaseApi db){
    _databaseApi = db;
  }

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
      var newProduct = (Product.fromJson(data, id));
      newProduct.addListener(() => _onProductChanged(newProduct));
      _items.add(newProduct);
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
      isFavorite: product.isFavorite,
    );

    newProduct.addListener(() => _onProductChanged(product));

    _items.add(newProduct);
    notifyListeners();
  }

  Future update(Product product) async {
    var index = _items.indexWhere((x) => x.id == product.id);

    await _databaseApi.update(product);
    _items[index] = product;
    notifyListeners();
  }

  void delete(String id) async {
    await _databaseApi.delete(id);

    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void _onProductChanged(Product product) {
    update(product);
  }
}

class FirebaseDatabase with DatabaseApi {
  static const String _domain =
      'https://flutter-shop-app-f9f78-default-rtdb.europe-west1.firebasedatabase.app';
  static const String _products = '/products';
  static const String _definition = '.json';

  @override
  Future<http.Response> add(Product product) async{
    var uri = Uri.parse(_domain + _products + _definition);
    var map = product.toJson();
    var body = json.encode(map);

    try {
      var response = await  http.post(uri, body: body);
      if (response.statusCode >= 400) {
        throw HttpException(response.statusCode, 'http exception');
      }
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<http.Response> fetch() async {
    var uri = Uri.parse(_domain + _products + _definition);

    try {
      var response = await http.get(uri);
      if (response.statusCode >= 400) {
        throw HttpException(response.statusCode, 'http exception');
      }
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<http.Response> update(Product product) async {
    var uri = Uri.parse(_domain + _products + '/${product.id}' + _definition);
    var map = product.toJson();
    var body = json.encode(map);

    try {
      var response = await http.patch(uri, body: body);
      if (response.statusCode >= 400) {
        throw HttpException(response.statusCode, 'http exception');
      }
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<http.Response> delete(String id) async {
    var uri = Uri.parse(_domain + _products + '/$id' + _definition);

    try {
      var response = await http.delete(uri);
      if (response.statusCode >= 400) {
        throw HttpException(response.statusCode, 'http exception');
      }
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

abstract class DatabaseApi {
  Future<http.Response> add(Product product);

  Future<http.Response> fetch();

  Future<http.Response> update(Product product);

  Future<http.Response> delete(String id);
}

class HttpException implements Exception {
  final int statusCode;
  final String message;

  HttpException(this.statusCode, this.message);

  @override
  String toString() {
    return '$message\nstatus code $statusCode\n${super.toString()}';
  }
}
