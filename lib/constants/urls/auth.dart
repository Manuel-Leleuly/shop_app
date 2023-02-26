class AUTH_URL {
  AUTH_URL._();

  static const signUpWithEmailPass = '/v1/accounts:signUp';
  static const signInWithEmailPass = '/v1/accounts:signInWithPassword';
  static String authenticate(String urlSegment) => '/v1/accounts:${urlSegment}';
}
