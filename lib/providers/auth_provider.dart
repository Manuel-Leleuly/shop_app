import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/constants/env.dart';

import '../constants/urls/auth.dart';

String getAuthUrl(String path) {
  return Uri.https(GLOBAL_ENVARS.SHOP_APP_AUTH_URL, path, {
    'key': GLOBAL_ENVARS.SHOP_APP_API_KEY,
  }).toString();
}

class AuthProvider with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  Future<void> _authenticate(
    String email,
    String password,
    String urlSegment,
  ) async {
    final url = getAuthUrl(AUTH_URL.authenticate(urlSegment));
    final response = await http.post(
      url,
      body: json.encode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );
    print(json.decode(response.body));
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }
}
