import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    // return Text('testing');
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(EditProductScreen.routeName, arguments: id);
            },
            color: Theme.of(context).colorScheme.primary,
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              Provider.of<ProductsProvider>(context, listen: false)
                  .deleteProduct(id);
            },
            color: Theme.of(context).colorScheme.error,
          ),
        ],
      ),
    );
  }
}
