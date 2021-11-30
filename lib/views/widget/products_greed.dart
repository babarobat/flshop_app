import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/ext/build_context_extensions.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/views/widget/product_item.dart';

class ProductsGreed extends StatelessWidget {
  final bool isShowFavorites;

  const ProductsGreed({
    Key? key,
    required this.isShowFavorites,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Product> products = getProducts(context);
    return GridView.builder(
      itemCount: products.length,
      padding: const EdgeInsets.all(10),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: products[i],
        child: const ProductItem(),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }

  List<Product> getProducts(BuildContext context) {
    return isShowFavorites
        ? context.getProvided<Products>().getFavorites()
        : context.getProvided<Products>().getAll();
  }
}
