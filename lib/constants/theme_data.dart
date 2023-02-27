import 'package:flutter/material.dart';
import 'package:shop_app/constants/constants.dart';
import 'package:shop_app/helpers/custom_route.dart';

final myAppThemeData = ThemeData(
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.purple,
  ).copyWith(
    secondary: Colors.deepOrange,
  ),
  fontFamily: FontFamily.lato,
  pageTransitionsTheme: PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CustomPageTransitionBuilder(),
      TargetPlatform.iOS: CustomPageTransitionBuilder(),
    },
  ),
  textTheme: TextTheme(
    titleLarge: TextStyle(
      color: Colors.white,
    ),
    labelLarge: TextStyle(
      color: Colors.white,
    ),
  ),
);
