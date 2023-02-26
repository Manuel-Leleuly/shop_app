import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shop_app/constants/env.dart';
import 'package:http/http.dart' as http;

import '../utils/utils.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final String creatorId;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.creatorId,
    this.isFavorite = false,
  });

  void _setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(String token, String userId) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();

    final url = generateDatabaseUrl(
      path: '/userFavorites/${userId}/${id}.json',
      authToken: token,
    );

    try {
      final response = await http.put(
        url,
        body: json.encode(isFavorite),
      );

      if (response.statusCode >= 400) {
        _setFavValue(oldStatus);
      }
    } catch (error) {
      _setFavValue(oldStatus);
    }
  }

  Map<String, dynamic> toJsonAdd(String creatorId) => {
        'title': title,
        'description': description,
        'price': price,
        'imageUrl': imageUrl,
        'creatorId': creatorId,
      };

  Map<String, dynamic> toJsonUpdate() => {
        'title': title,
        'description': description,
        'price': price,
        'imageUrl': imageUrl,
      };

  factory Product.fromJson({
    @required String productId,
    @required Map<String, dynamic> productData,
    @required bool isFavorite,
  }) =>
      Product(
        id: productId,
        title: productData['title'],
        description: productData['description'],
        price: productData['price'],
        imageUrl: productData['imageUrl'],
        isFavorite: isFavorite,
      );
}
