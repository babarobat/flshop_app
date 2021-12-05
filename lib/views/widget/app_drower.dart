import 'package:flutter/material.dart';
import 'package:shop_app/constants/routs.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('welcome!'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
           ListTile(
            leading: Icon(Icons.shop),
            title: Text('shop'),
            onTap: (){
              Navigator.pushNamed(context, Routs.productsOverview);
            },
          ),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('orders'),
            onTap: (){
              Navigator.pushNamed(context, Routs.orders);
            },
          ),
        ],
      ),
    );
  }
}
