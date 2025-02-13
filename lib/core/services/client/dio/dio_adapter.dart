import 'package:dio/dio.dart';
import 'package:todo_list/core/core.dart';

class DioAdapter {
  static RestClientException toClientException(DioException dioException) {
    final response = dioException.response;
    final errorData = response?.data is Map ? response?.data : {};

    return RestClientException(
      error: dioException.error ?? 'Erro desconhecido',
      message: errorData['message']?.toString() ??
          dioException.message ??
          'Erro desconhecido',
      data: errorData,
      response: response != null ? toClientResponse(response) : null,
      statusCode: response?.statusCode,
    );
  }

  static DioException toDioException(RestClientException restClientException) {
    return DioException(
      requestOptions: RequestOptions(
        path: restClientException.response?.request.path ?? '',
        method:
            restClientException.response?.request.method.toString() ?? 'GET',
        headers: restClientException.response?.request.headers,
        queryParameters: restClientException.response?.request.queryParameters,
        baseUrl: restClientException.response?.request.baseUrl ?? '',
      ),
      error: restClientException.error,
      message: restClientException.message,
      response: restClientException.response != null
          ? toResponse(restClientException.response!)
          : null,
    );
  }

  static RestClientRequest toClientRequest(RequestOptions request) {
    return RestClientRequest(
      path: request.path,
      method: RestMethod.fromString(request.method),
      headers: request.headers,
      queryParameters: request.queryParameters,
      data: request.data,
      baseUrl: request.baseUrl,
      sendTimeout: request.sendTimeout,
      receiveTimeout: request.receiveTimeout,
    );
  }

  static RequestOptions toRequestOptions(RestClientRequest restClientRequest) {
    return RequestOptions(
      path: restClientRequest.path,
      data: restClientRequest.data,
      method: restClientRequest.method.toString(),
      queryParameters: restClientRequest.queryParameters ?? {},
      headers: restClientRequest.headers ?? {},
      baseUrl: restClientRequest.baseUrl,
      sendTimeout: restClientRequest.sendTimeout,
      receiveTimeout: restClientRequest.receiveTimeout,
    );
  }

  static RestClientResponse toClientResponse(Response response) {
    return RestClientResponse(
      request: toClientRequest(response.requestOptions),
      message: response.statusMessage ?? '',
      data: response.data,
      statusCode: response.statusCode,
    );
  }

  static Response toResponse(RestClientResponse restClientResponse) {
    final headers = restClientResponse.request.headers ?? {};
    final dioHeaders = Headers();

    headers.forEach((key, value) {
      if (value is List<String>) {
        dioHeaders.set(key, value);
      } else {
        dioHeaders.set(key, [value.toString()]);
      }
    });

    return Response(
      requestOptions: toRequestOptions(restClientResponse.request),
      data: restClientResponse.data,
      headers: dioHeaders,
      statusCode: restClientResponse.statusCode,
      statusMessage: restClientResponse.message,
    );
  }

  static Options toOptions(RestClientRequest request) {
    return Options(
      method: request.method.toString(),
      headers: request.headers,
      sendTimeout: request.sendTimeout,
      receiveTimeout: request.receiveTimeout,
    );
  }
}
