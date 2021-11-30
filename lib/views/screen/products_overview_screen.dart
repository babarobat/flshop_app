import 'package:flutter/material.dart';
import 'package:shop_app/views/widget/products_greed.dart';

class ProductsOverviewScreen extends StatefulWidget {

  ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var isShowFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            onSelected: (int i) => {
              setState(() {
                isShowFavorites = i == 0;
              })
            },
            itemBuilder: (_) => [
              const PopupMenuItem(
                child: Text('Only favorites'),
                value: 0,
              ),
              const PopupMenuItem(
                child: Text('All'),
                value: 1,
              ),
            ],
          ),
        ],
        title: const Text('shop app'),
      ),
      body:  ProductsGreed(isShowFavorites: isShowFavorites),
    );
  }
}
