import 'package:flutter/material.dart';
import 'package:shop_app/ext/build_context_extensions.dart';
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/views/widget/app_drawer.dart';
import 'package:shop_app/views/widget/order_item.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() async{
    super.didChangeDependencies();

    if (_isInit) {
      _isInit = false;

      try {
        setState(() {_isLoading = true;});

        var orders = context.getProvidedAndForget<Orders>();
        await orders.fetch();

      } catch (e) {
        setState(() {_isLoading = false;});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var orders = context.getProvided<Orders>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      drawer: const AppDrawer(),
      body: ListView.builder(
        itemCount: orders.items.length,
        itemBuilder: (ctx, i) => OrderItem(entry: orders.items[i]),
      ),
    );
  }
}
