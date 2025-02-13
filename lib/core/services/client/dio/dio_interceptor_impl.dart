import 'package:dio/dio.dart';
import 'package:todo_list/core/core.dart';

import 'dio_adapter.dart';

class ClientInterceptorDioImpl implements Interceptor {
  final ClientInterceptor interceptor;

  ClientInterceptorDioImpl({required this.interceptor});

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    try {
      final restClientException = DioAdapter.toClientException(err);
      final response = await interceptor.onError(restClientException);

      if (response is RestClientException) {
        handler.reject(DioAdapter.toDioException(response));
      } else if (response is RestClientResponse) {
        handler.resolve(DioAdapter.toResponse(response));
      } else {
        handler.reject(err);
      }
    } catch (e) {
      handler.reject(err);
    }
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      final restRequest = DioAdapter.toClientRequest(options);
      final response = await interceptor.onRequest(restRequest);

      if (response is RestClientException) {
        handler.reject(DioAdapter.toDioException(response));
      } else if (response is RestClientRequest) {
        handler.next(DioAdapter.toRequestOptions(response));
      } else if (response is RestClientResponse) {
        handler.resolve(DioAdapter.toResponse(response));
      } else {
        handler.next(options);
      }
    } catch (e) {
      handler.next(options);
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    try {
      final restResponse = DioAdapter.toClientResponse(response);
      final updatedResponse = await interceptor.onResponse(restResponse);

      if (updatedResponse is RestClientException) {
        handler.reject(DioAdapter.toDioException(updatedResponse));
      } else if (updatedResponse is RestClientResponse) {
        handler.next(DioAdapter.toResponse(updatedResponse));
      } else {
        handler.next(response);
      }
    } catch (e) {
      handler.next(response);
    }
  }
}
