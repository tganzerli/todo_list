import 'package:todo_list/core/core.dart';

abstract class RestClient {
  final List<ClientInterceptor> _interceptors = [];
  Future<RestClientResponse> request(RestClientRequest request);
  Future<RestClientResponse> upload(RestClientMultipart multipart);
  void setBaseUrl(String url);
  void cleanHeaders();
  void setHeaders(Map<String, dynamic> header);
  void setTimeouts({Duration? connectTimeout, Duration? receiveTimeout});

  void addInterceptor(ClientInterceptor interceptor) {
    if (!_interceptors.contains(interceptor)) {
      _interceptors.add(interceptor);
    }
  }

  void removeInterceptor(ClientInterceptor interceptor) {
    _interceptors.remove(interceptor);
  }

  void clearInterceptors() {
    _interceptors.clear();
  }

  List<ClientInterceptor> getInterceptors() => List.unmodifiable(_interceptors);
}
