import 'package:flutter/material.dart';

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
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 4,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
          ),
          title: Text(title),
          subtitle: Text(
            'Total: \$${price*quantity}',
          ),
          trailing: Text('$price  x  $quantity'),
        ),
      ),
    );
  }
}
