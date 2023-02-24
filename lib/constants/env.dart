import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class _DotEnv {
  final String SHOP_APP_FIREBASE_URL;

  _DotEnv({
    @required this.SHOP_APP_FIREBASE_URL,
  });
}

final _DotEnv GLOBAL_ENVARS = _DotEnv(
  SHOP_APP_FIREBASE_URL: dotenv.env['SHOP_APP_FIREBASE_URL'],
);
