import 'package:flutter/material.dart';
import 'package:shop_app/constants/routs.dart';
import 'package:shop_app/ext/build_context_extensions.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/providers/order.dart';
import 'package:shop_app/views/widget/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = context.getProvided<Cart>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'total',
                    style: TextStyle(fontSize: 20),
                  ),
                  const Spacer(),
                  Chip(
                      label: Text(
                        '\$${cart.getTotal.toStringAsFixed(2)}',
                        style: TextStyle(
                            color: Theme.of(context)
                                .primaryTextTheme
                                .subtitle1!
                                .color),
                      ),
                      backgroundColor: Theme.of(context).colorScheme.primary),
                  const OrderButton(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (ctx, i) => CartItem(
                id: cart.items[i].id,
                title: cart.items[i].title,
                price: cart.items[i].price,
                imageUrl: cart.items[i].imageUrl,
                quantity: cart.items[i].quantity,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({Key? key}) : super(key: key);

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final cart = context.getProvided<Cart>();
    final orders = context.getProvidedAndForget<Orders>();

    return _isLoading
        ? const Center(child: CircularProgressIndicator(color: Colors.red))
        : TextButton(onPressed: (_isLoading || cart.items.isEmpty)
                ? null
                : () => _order(cart, orders),
            child: const Text('order'),
          );
  }

  void _order(Cart cart, Orders orders) async {
    setState(() {
      _isLoading = true;
    });

    final order = Order(
      id: DateTime.now().toString(),
      date: DateTime.now(),
      total: cart.getTotal,
      items: cart.items,
    );

    await orders.add(order);

    cart.clear();
    Navigator.pushNamed(context, Routs.orders);
  }
}
