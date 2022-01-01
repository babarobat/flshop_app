import 'package:flutter/material.dart';
import 'package:shop_app/ext/build_context_extensions.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/views/widget/app_drower.dart';
import 'package:shop_app/views/widget/user_product_item.dart';

class UserProductScreen extends StatelessWidget {
  const UserProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final products = context.getProvided<Products>().getAll();

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Your products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (BuildContext ctx, int i) {
            final product = products[i];
            return UserProductItem(
              title: product.title,
              imageUrl: product.imageUrl,
            );
          },
        ),
      ),
    );
  }
}
