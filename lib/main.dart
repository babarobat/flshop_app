import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/views/screen/cart_screen.dart';
import 'package:shop_app/views/screen/edit_product_screen.dart';
import 'package:shop_app/views/screen/order_screen.dart';
import 'package:shop_app/views/screen/product_detail_screen.dart';
import 'package:shop_app/views/screen/user_products_screen.dart';

import 'constants/routs.dart';
import 'providers/cart.dart';
import 'views/screen/products_overview_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var db = FirebaseDatabase();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (c) => Products(db)),
        ChangeNotifierProvider(create: (c) => Orders(db)),
        ChangeNotifierProvider(create: (c) => Cart()),
      ],
      child: MaterialApp(
        title: 'Shop app',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
              .copyWith(secondary: Colors.deepOrange),
          fontFamily: 'Lato',
        ),
        home: const ProductsOverviewScreen(),
        routes: {
          Routs.productsOverview: (ctx) => const ProductsOverviewScreen(),
          Routs.productDetail: (ctx) => const ProductDetailScreen(),
          Routs.cart: (ctx) => const CartScreen(),
          Routs.orders: (ctx) => const OrderScreen(),
          Routs.userProducts: (ctx) => const UserProductScreen(),
          Routs.editProductsScreen: (ctx) => const EditProductScreen(),
        },
      ),
    );
  }
}
