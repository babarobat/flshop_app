import 'package:flutter/material.dart';
import 'package:shop_app/constants/routs.dart';
import 'package:shop_app/ext/build_context_extensions.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/views/screen/product_detail_screen_dto.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = context.getProvided<Product>();
    final cart = context.getProvidedAndForget<Cart>();

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(
          context,
          Routs.productDetail,
          arguments: ProductDetailScreenDTO(product.id),
        ),
        child: GridTile(
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            leading: IconButton(
                icon: Icon(product.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border),
                onPressed: product.toggleFavorite,
                color: Theme.of(context).colorScheme.secondary),
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text("Add item to cart"),
                    action: SnackBarAction(
                      label: 'UNDO',
                      onPressed: () {
                        cart.remove(product.id);
                      },
                    ),
                  ));
                  cart.add(product.id, product.title, product.price,
                      product.imageUrl);
                },
                color: Theme.of(context).colorScheme.secondary),
          ),
        ),
      ),
    );
  }
}
