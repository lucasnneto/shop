import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/auth.dart';
import '../providers/product.dart';
import '../providers/cart.dart';
import '../utils/App_routes.dart';

class ProductGridItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Product product = Provider.of(context, listen: false);
    final Cart cart = Provider.of(context, listen: false);
    final Auth auth = Provider.of(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.PRODUCT_DETAIL,
              arguments: product,
            );
          },
          child: Hero(
            tag: product.id!,
            child: FadeInImage(
              placeholder: AssetImage('assets/images/product-placeholder.png'),
              image: NetworkImage(
                product.imageUrl,
              ),
              fit: BoxFit.cover,
            ),
          ),
          // Image.network(
          //   product.imageUrl,
          //   fit: BoxFit.cover,
          // ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder: (ctx, product, _) => IconButton(
              icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border),
              color: Theme.of(context).accentColor,
              onPressed: () {
                product.toggleFavorite(auth.token!, auth.userId!);
              },
            ),
          ),
          title: Text(product.title, textAlign: TextAlign.center),
          trailing: IconButton(
            color: Theme.of(context).accentColor,
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text("Produto adicionado com sucesso!"),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'CANCELAR',
                    onPressed: () {
                      cart.removeSingleItem(product.id);
                    },
                  ),
                ),
              );
              //NOT DEPRECATED
              // ScaffoldMessenger.of(context).hideCurrentSnackBar();
              // ScaffoldMessenger.of(context)
              //     .showSnackBar(SnackBar(content: Text("Teste")));
              cart.addItem(product);
            },
          ),
        ),
      ),
    );
  }
}
