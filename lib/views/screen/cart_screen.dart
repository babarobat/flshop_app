import 'package:flutter/material.dart';
import 'package:shop_app/ext/build_context_extensions.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/views/widget/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = context.getProvidedAndForget<Cart>();
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
                        '\$${cart.getTotal.toString()}',
                        style: TextStyle(
                            color: Theme.of(context)
                                .primaryTextTheme
                                .subtitle1!
                                .color),
                      ),
                      backgroundColor: Theme.of(context).colorScheme.primary),
                  TextButton(
                    onPressed: () {},
                    child: const Text('order'),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (ctx,i) => CartItem(
                id: cart.items[i].id,
                title: cart.items[i].title,
                price:  cart.items[i].price,
                imageUrl: cart.items[i].imageUrl,
                quantity:  cart.items[i].quantity,
              ),
            ),
          ),
        ],
      ),
    );
  }
}