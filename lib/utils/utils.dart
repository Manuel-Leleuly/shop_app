import 'package:shop_app/providers/product.dart';

import '../providers/cart_provider.dart';
import '../providers/orders_provider.dart';

Product convertProductResponseToProduct(
  String productId,
  Map<String, dynamic> productData,
) {
  return Product(
    id: productId,
    title: productData['title'],
    description: productData['description'],
    price: productData['price'],
    imageUrl: productData['imageUrl'],
  );
}

OrderItem convertOrderResponseToOrderItem(
    String orderId, Map<String, dynamic> orderData) {
  return OrderItem(
    id: orderId,
    amount: orderData['amount'],
    dateTime: DateTime.parse(orderData['dateTime']),
    products: (orderData['products'] as List<dynamic>)
        .map((item) => CartItem(
              id: item['id'],
              price: item['price'],
              quantity: item['quantity'],
              title: item['title'],
            ))
        .toList(),
  );
}
