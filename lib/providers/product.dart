import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shop_app/constants/env.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  void _setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus() async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();

    final url = '${GLOBAL_ENVARS.SHOP_APP_FIREBASE_URL}/products/${id}.json';

    try {
      final response = await http.patch(
        url,
        body: json.encode({
          'isFavorite': isFavorite,
        }),
      );

      if (response.statusCode >= 400) {
        _setFavValue(oldStatus);
      }
    } catch (error) {
      _setFavValue(oldStatus);
    }
  }

  Map<String, dynamic> toJsonAdd() => {
        'title': title,
        'description': description,
        'price': price,
        'imageUrl': imageUrl,
        'isFavorite': isFavorite,
      };

  Map<String, dynamic> toJsonUpdate() => {
        'title': title,
        'description': description,
        'price': price,
        'imageUrl': imageUrl,
      };

  factory Product.fromJson({
    String productId,
    Map<String, dynamic> productData,
  }) =>
      Product(
        id: productId,
        title: productData['title'],
        description: productData['description'],
        price: productData['price'],
        imageUrl: productData['imageUrl'],
      );
}
