import 'package:flutter/material.dart';
import 'package:shop_app/constants/env.dart';
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

String generateDatabaseUrl({
  @required String path,
  @required String authToken,
  Map<String, dynamic> queryParams,
}) {
  final params = queryParams == null
      ? {
          'auth': authToken,
        }
      : {
          ...queryParams,
          'auth': authToken,
        };
  return Uri.https(GLOBAL_ENVARS.SHOP_APP_FIREBASE_URL, path, params)
      .toString();
}

String generateAuthUrl(String path) {
  return Uri.https(GLOBAL_ENVARS.SHOP_APP_AUTH_URL, path, {
    'key': GLOBAL_ENVARS.SHOP_APP_API_KEY,
  }).toString();
}
