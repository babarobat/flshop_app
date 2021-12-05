import 'package:flutter/material.dart';

class Order with ChangeNotifier {
  final String productId;

  Order({
    required this.productId,
  });
}
