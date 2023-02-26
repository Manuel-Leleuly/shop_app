import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/utils/utils.dart';

import 'cart_provider.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });

  Map<String, dynamic> toJsonAdd() => {
        'amount': amount,
        'dateTime': dateTime.toIso8601String(),
        'products': products.map((prod) => prod.toJson()).toList(),
      };

  factory OrderItem.fromJson({
    String orderId,
    Map<String, dynamic> orderData,
  }) =>
      OrderItem(
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

class OrdersProvider with ChangeNotifier {
  List<OrderItem> _orders = [];
  String authToken;
  String userId;

  void update({
    @required String authToken,
    @required List<OrderItem> orders,
    @required String userId,
  }) {
    this._orders = orders;
    this.authToken = authToken;
    this.userId = userId;
  }

  List<OrderItem> get orders => [..._orders];

  Future<void> fetchAndSetOrders() async {
    final url = generateDatabaseUrl(
      path: '/orders/${userId}.json',
      authToken: authToken,
    );
    final response = await http.get(url);

    final List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) return;

    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(OrderItem.fromJson(
        orderId: orderId,
        orderData: orderData,
      ));
    });

    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = generateDatabaseUrl(
      path: '/orders/${userId}.json',
      authToken: authToken,
    );
    final timestamp = DateTime.now();
    final selectedOrderItem = OrderItem(
      id: DateTime.now().toString(),
      amount: total,
      products: cartProducts,
      dateTime: timestamp,
    );

    final response = await http.post(
      url,
      body: json.encode(
        selectedOrderItem.toJsonAdd(),
      ),
    );

    _orders.insert(
      0,
      OrderItem(
        id: json.decode(response.body)['name'],
        amount: total,
        products: cartProducts,
        dateTime: timestamp,
      ),
    );
    notifyListeners();
  }
}
