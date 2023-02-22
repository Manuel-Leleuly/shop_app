import 'package:flutter/material.dart';

class CartItemCard extends StatelessWidget {
  final String id;
  final double price;
  final int quantity;
  final String title;

  CartItemCard(this.id, this.price, this.quantity, this.title);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 4,
      ),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: ListTile(
          leading: CircleAvatar(
            child: FittedBox(
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  '\$${price}',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.titleLarge.color,
                  ),
                ),
              ),
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          title: Text(title),
          subtitle: Text('Total: \$${price * quantity}'),
          trailing: Text('${quantity} x'),
        ),
      ),
    );
  }
}
