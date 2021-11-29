import 'package:flutter/material.dart';
import 'package:shop_app/ext/build_context_extensions.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/views/screen/product_detail_screen_dto.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = context.getArgument<ProductDetailScreenDTO>().id;
    final product = context.getProvidedAndForget()<Products>().getById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
    );
  }
}
