import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/ext/build_context_extensions.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/views/widget/product_item.dart';

class ProductsGreed extends StatelessWidget {
  const ProductsGreed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final products = context.getProvided<Products>().items;
    return GridView.builder(
      itemCount: products.length,
      padding: const EdgeInsets.all(10),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: products[i],
        child: ProductItem(),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
