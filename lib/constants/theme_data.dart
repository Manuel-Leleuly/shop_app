import 'package:flutter/material.dart';
import 'package:shop_app/constants/constants.dart';

final myAppThemeData = ThemeData(
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.purple,
  ).copyWith(
    secondary: Colors.deepOrange,
  ),
  fontFamily: latoFontFamily,
  textTheme: TextTheme(
    titleLarge: TextStyle(
      color: Colors.white,
    ),
  ),
);
