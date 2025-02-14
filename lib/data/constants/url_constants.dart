class UrlConstants {
  static Api api = Api();
}

class Api {
  String base = const String.fromEnvironment('BASE_URL');
  String posts = '/posts';
}
