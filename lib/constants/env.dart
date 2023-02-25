import 'package:flutter_dotenv/flutter_dotenv.dart';

class GLOBAL_ENVARS {
  GLOBAL_ENVARS._();

  static final SHOP_APP_FIREBASE_URL = dotenv.env['SHOP_APP_FIREBASE_URL'];
}
