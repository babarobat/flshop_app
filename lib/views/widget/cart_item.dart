import 'package:flutter/material.dart';
import 'package:shop_app/ext/build_context_extensions.dart';
import 'package:shop_app/providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final double price;
  final String title;
  final String imageUrl;
  final int quantity;

  const CartItem({
    Key? key,
    required this.id,
    required this.price,
    required this.title,
    required this.quantity,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = context.getProvidedAndForget<Cart>();
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        cart.remove(id);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
          ),
          title: Text(title),
          subtitle: Text(
            'Total: \$${price * quantity}',
          ),
          trailing: Text('$price  x  $quantity'),
        ),
      ),
    );
  }
}
