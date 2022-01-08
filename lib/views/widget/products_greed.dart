import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/constants/routs.dart';
import 'package:shop_app/ext/build_context_extensions.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/views/screen/product_detail_screen_dto.dart';
import 'package:flutter/widgets.dart';

class ProductsGreed extends StatelessWidget {
  final bool isShowFavorites;

  const ProductsGreed({
    Key? key,
    required this.isShowFavorites,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Product> products = getProducts(context);
    return MasonryGridView.count(
        itemCount: products.length,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        crossAxisCount: 2,
        itemBuilder: (BuildContext ctx, int i) {
          return ChangeNotifierProvider.value(
            value: products[i],
            child: const ProductItemMasonry(),
          );
        });
  }

  List<Product> getProducts(BuildContext context) {
    return isShowFavorites
        ? context.getProvided<Products>().getFavorites()
        : context.getProvided<Products>().getAll();
  }
}

class ProductItemMasonry extends StatelessWidget {
  const ProductItemMasonry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = context.getProvided<Cart>();
    final product = context.getProvided<Product>();

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () =>
            Navigator.pushNamed(
              context,
              Routs.productDetail,
              arguments: ProductDetailScreenDTO(product.id),
            ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            product.imageUrl.isNotEmpty
                ? Image.network(product.imageUrl, fit: BoxFit.cover)
                : const Icon(
              Icons.image,
              size: 150,
            ),
            SizedBox(
              child: DecoratedBox(
                decoration: const BoxDecoration(color: Colors.black54),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        icon: Icon(product.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border),
                        onPressed: ()  {
                        product.toggleFavorite();
                    },
                        color: Theme
                            .of(context)
                            .colorScheme
                            .secondary),
                    Text(
                      product.title,
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    IconButton(
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
                        color: Theme
                            .of(context)
                            .colorScheme
                            .secondary),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
