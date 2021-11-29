import 'package:flutter/material.dart';
import 'package:shop_app/views/widget/product_item.dart';
import 'package:shop_app/views/widget/products_greed.dart';

import '../../models/product.dart';

class ProductsOverviewScreen extends StatelessWidget {

  ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('shop app'),
      ),
      body:  ProductsGreed(),
    );
  }
}
