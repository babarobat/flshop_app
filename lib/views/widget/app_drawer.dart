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
          const DrawerButton(Icons.shop, 'shop', Routs.productsOverview),
          const Divider(),
          const DrawerButton(Icons.payment, 'orders', Routs.orders),
          const Divider(),
          const DrawerButton(Icons.edit, 'manage products', Routs.userProducts),
          const Divider(),
        ],
      ),
    );
  }
}

class DrawerButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String route;

  const DrawerButton(this.icon, this.title, this.route, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Icon(icon),
        title: Text(title),
        onTap: () => Navigator.pushNamed(context, route));
  }
}
