import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/order.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/views/screen/cart_screen.dart';
import 'package:shop_app/views/screen/order_screen.dart';
import 'package:shop_app/views/screen/product_detail_screen.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (c) => Products()),
        ChangeNotifierProvider(create: (c) => Order()),
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
          Routs.orders: (ctx) => const OrderScreen()
        },
      ),
    );
  }
}
