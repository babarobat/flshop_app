import 'package:flutter/material.dart';
import 'package:shop_app/providers/order_entry.dart';

class OrderItem extends StatefulWidget {
  final OrderEntry entry;

  const OrderItem({
    Key? key,
    required this.entry,
  }) : super(key: key);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.entry.total}'),
            subtitle: Text('\$${widget.entry.date}'),
            trailing: IconButton(
              icon: const Icon(Icons.expand_more),
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
            ),
          ),
          if (_isExpanded)
            Column(
              children: widget.entry.items
                  .map(
                    (e) => Container(
                      padding: EdgeInsets.all(4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(e.title),
                          Text('${e.price}x${e.quantity} = ${e.total}'),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
        ],
      ),
    );
  }
}
