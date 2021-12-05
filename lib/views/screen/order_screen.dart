import 'package:flutter/material.dart';
import 'package:shop_app/ext/build_context_extensions.dart';
import 'package:shop_app/providers/order.dart';
import 'package:shop_app/views/widget/app_drower.dart';
import 'package:shop_app/views/widget/order_item.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var order = context.getProvided<Order>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      drawer: const AppDrawer(),
      body: ListView.builder(
        itemCount: order.items.length,
        itemBuilder: (ctx, i) => OrderItem(entry: order.items[i]),
      ),
    );
  }
}
