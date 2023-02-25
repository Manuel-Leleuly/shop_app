import 'package:shop_app/providers/product.dart';

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
