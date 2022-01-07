import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/constants/routs.dart';
import 'package:shop_app/ext/build_context_extensions.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/views/widget/app_drawer.dart';
import 'package:shop_app/views/widget/products_greed.dart';
import 'package:shop_app/views/widget/badge.dart';

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var isShowFavorites = false;
  var _isLoading = false;
  var _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_isInit) {
      _isInit = false;
      _fetchData();
    }
  }

  void _fetchData() {
    var products = context.getProvidedAndForget<Products>();

    setState(() {
      _isLoading = true;
    });

    products.fetch().then((value) {
      setState(() {
        _isLoading = false;
      });
    }).catchError((e) {
      print(e);
      setState(() {
        _isLoading = false;
      });
    });
  }

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
          Consumer<Cart>(
            builder: (ctx, cart, ch) => Badge(
              value: cart.itemsCountWithQuantities.toString(),
              child: ch!,
            ),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.pushNamed(context, Routs.cart);
              },
            ),
          ),
        ],
        title: const Text('shop app'),
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(
                color: Colors.red,
              ))
            : ProductsGreed(isShowFavorites: isShowFavorites),
      ),
    );
  }
}
