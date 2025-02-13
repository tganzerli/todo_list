import 'package:todo_list/core/core.dart';

abstract interface class RestClient {
  Future<RestClientResponse> request(RestClientRequest request);
  Future<RestClientResponse> upload(RestClientMultipart multipart);
  void setBaseUrl(String url);
  void cleanHeaders();
  void setHeaders(Map<String, dynamic> header);
  void setTimeouts({Duration? connectTimeout, Duration? receiveTimeout});
  void addInterceptor(ClientInterceptor interceptor);
  void removeInterceptor(ClientInterceptor interceptor);
  void clearInterceptors();
  List<ClientInterceptor> getInterceptors();
}
