import 'package:flutter/material.dart';
import 'package:shop_app/constants/theme_data.dart';
import 'package:shop_app/screens/products_overview_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyShop',
      theme: myAppThemeData,
      home: ProductsOverviewScreen(),
    );
  }
}
