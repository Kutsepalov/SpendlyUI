class ClientURLs {
  // static const String base = 'http://77.121.149.250:8000/api';
  static const String base = 'http://localhost:8080/api';
  static const String registration = '$base/v1/auth/registration';
  static const String authentication = '$base/v1/auth/login';

  static const String account = '$base/v1/accounts';

  static const String getUserInfo = '$base/v1/user';

  static const String records = '$base/v1/records';
  static const String categories = '$base/v1/categories';
}

const String jwtKey = 'jwt';
