import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop_app/model/http_exception.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/utils/utils.dart';

import 'product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [];
  String authToken;
  String userId;

  void update({
    @required String authToken,
    @required List<Product> items,
    @required String userId,
  }) {
    this.authToken = authToken;
    this._items = items;
    this.userId = userId;
  }

  List<Product> get items => [..._items];

  List<Product> get favoriteItems =>
      _items.where((prodItem) => prodItem.isFavorite).toList();

  Product findById(String id) => _items.firstWhere((prod) => prod.id == id);

  Future<void> fetchSetProducts([bool filterByUser = false]) async {
    final url = generateDatabaseUrl(
      path: '/products.json',
      authToken: authToken,
      queryParams: filterByUser
          ? {
              'orderBy': '"creatorId"',
              'equalTo': '"${userId}"',
            }
          : null,
    );
    final favoriteUrl = generateDatabaseUrl(
      path: '/userFavorites/${userId}.json',
      authToken: authToken,
    );

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) return;

      final favoriteResponse = await http.get(favoriteUrl);
      final favoriteData = json.decode(favoriteResponse.body);

      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product.fromJson(
          productId: prodId,
          productData: prodData,
          isFavorite:
              favoriteData == null ? false : favoriteData[prodId] ?? false,
        ));
      });
      _items = loadedProducts;

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addProduct(Product product) async {
    final url = generateDatabaseUrl(
      path: '/products.json',
      authToken: authToken,
    );

    try {
      final response = await http.post(
        url,
        body: json.encode(product.toJsonAdd(userId)),
      );

      final newProduct = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );

      _items.add(newProduct);
      // _items.add(value);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    final url = generateDatabaseUrl(
      path: '/products/${id}.json',
      authToken: authToken,
    );

    if (prodIndex >= 0) {
      await http.patch(url, body: json.encode(newProduct.toJsonUpdate()));
      _items[prodIndex] = newProduct;
    } else {
      print('...');
    }
    notifyListeners();
  }

  Future<void> deleteProduct(String id) async {
    final url = generateDatabaseUrl(
      path: '/products/${id}.json',
      authToken: authToken,
    );
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();

    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    existingProduct = null;
  }
}
