// font family
import '../providers/product.dart';

class PREFS_KEY {
  PREFS_KEY._();

  static const USER_DATA = 'userData';
}

class FontFamily {
  FontFamily._();

  static const anton = 'anton';
  static const lato = 'lato';
}

class AUTH_ERROR_CODE {
  AUTH_ERROR_CODE._();

  static const EMAIL_EXIST = 'EMAIL_EXIST';
  static const INVALID_EMAIL = 'INVALID_EMAIL';
  static const WEAK_PASSWORD = 'WEAK_PASSWORD';
  static const EMAIL_NOT_FOUND = 'EMAIL_NOT_FOUND';
  static const INVALID_PASSWORD = 'INVALID_PASSWORD';
}

final DUMMY_ITEMS = [
  Product(
    id: 'p1',
    title: 'Red Shirt',
    description: 'A red shirt - it is pretty red!',
    price: 29.99,
    imageUrl:
        'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
  ),
  Product(
    id: 'p2',
    title: 'Trousers',
    description: 'A nice pair of trousers.',
    price: 59.99,
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
  ),
  Product(
    id: 'p3',
    title: 'Yellow Scarf',
    description: 'Warm and cozy - exactly what you need for the winter.',
    price: 19.99,
    imageUrl: 'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
  ),
  Product(
    id: 'p4',
    title: 'A Pan',
    description: 'Prepare any meal you want.',
    price: 49.99,
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
  ),
];
