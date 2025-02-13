import 'package:dio/dio.dart';
import 'package:todo_list/core/core.dart';
import 'dio_adapter.dart';
import 'dio_interceptor_impl.dart';

class DioFactory {
  static Dio dio() {
    final Map<String, dynamic> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Charset': 'utf-8',
    };
    final baseOptions = BaseOptions(
      baseUrl: '',
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 5000),
      headers: headers,
    );
    return Dio(baseOptions);
  }
}

class RestClientDioImpl implements RestClient {
  final Dio _dio;
  final Map<String, dynamic> _defaultHeaders = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Charset': 'utf-8',
  };

  RestClientDioImpl({
    required Dio dio,
  }) : _dio = dio;

  @override
  void setBaseUrl(String url) {
    _dio.options.baseUrl = url;
  }

  @override
  void cleanHeaders() {
    _dio.options.headers.clear();
    _dio.options.headers.addAll(_defaultHeaders);
  }

  @override
  void setHeaders(Map<String, dynamic> headers) {
    _dio.options.headers.addAll(headers);
  }

  @override
  void setTimeouts({Duration? connectTimeout, Duration? receiveTimeout}) {
    if (connectTimeout != null) {
      _dio.options.connectTimeout = connectTimeout;
    }
    if (receiveTimeout != null) {
      _dio.options.receiveTimeout = receiveTimeout;
    }
  }

  @override
  void addInterceptor(ClientInterceptor interceptor) {
    final existingInterceptors =
        _dio.interceptors.whereType<ClientInterceptorDioImpl>();

    final alreadyExists = existingInterceptors
        .any((existing) => existing.interceptor == interceptor);

    if (!alreadyExists) {
      _dio.interceptors.add(ClientInterceptorDioImpl(interceptor: interceptor));
    }
  }

  @override
  void removeInterceptor(ClientInterceptor interceptor) {
    _dio.interceptors.removeWhere((element) =>
        element is ClientInterceptorDioImpl &&
        element.interceptor == interceptor);
  }

  @override
  void clearInterceptors() {
    _dio.interceptors.clear();
  }

  @override
  List<ClientInterceptor> getInterceptors() {
    return _dio.interceptors
        .whereType<ClientInterceptorDioImpl>()
        .map((e) => e.interceptor)
        .toList();
  }

  @override
  Future<RestClientResponse> request(RestClientRequest request) async {
    try {
      if (request.baseUrl.isNotEmpty) {
        setBaseUrl(request.baseUrl);
      }

      return switch (request.method) {
        RestMethod.delete => _delete(request),
        RestMethod.get => _get(request),
        RestMethod.patch => _patch(request),
        RestMethod.post => _post(request),
        RestMethod.put => _put(request),
      };
    } on DioException catch (e) {
      throw DioAdapter.toClientException(e);
    }
  }

  Future<RestClientResponse> _delete(RestClientRequest request) async {
    try {
      final options = DioAdapter.toOptions(request);
      final response = await _dio.delete(
        request.path,
        data: request.data,
        queryParameters: request.queryParameters,
        options: options,
      );
      return DioAdapter.toClientResponse(response);
    } on DioException catch (e) {
      throw DioAdapter.toClientException(e);
    }
  }

  Future<RestClientResponse> _get(RestClientRequest request) async {
    try {
      final options = DioAdapter.toOptions(request);
      final response = await _dio.get(
        request.path,
        queryParameters: request.queryParameters,
        options: options,
      );
      return DioAdapter.toClientResponse(response);
    } on DioException catch (e) {
      throw DioAdapter.toClientException(e);
    }
  }

  Future<RestClientResponse> _patch(RestClientRequest request) async {
    try {
      final options = DioAdapter.toOptions(request);
      final response = await _dio.patch(
        request.path,
        data: request.data,
        queryParameters: request.queryParameters,
        options: options,
      );
      return DioAdapter.toClientResponse(response);
    } on DioException catch (e) {
      throw DioAdapter.toClientException(e);
    }
  }

  Future<RestClientResponse> _post(RestClientRequest request) async {
    try {
      final options = DioAdapter.toOptions(request);
      final response = await _dio.post(
        request.path,
        data: request.data,
        queryParameters: request.queryParameters,
        options: options,
      );
      return DioAdapter.toClientResponse(response);
    } on DioException catch (e) {
      throw DioAdapter.toClientException(e);
    }
  }

  Future<RestClientResponse> _put(RestClientRequest request) async {
    try {
      final options = DioAdapter.toOptions(request);
      final response = await _dio.put(
        request.path,
        data: request.data,
        queryParameters: request.queryParameters,
        options: options,
      );
      return DioAdapter.toClientResponse(response);
    } on DioException catch (e) {
      throw DioAdapter.toClientException(e);
    }
  }

  @override
  Future<RestClientResponse> upload(RestClientMultipart multipart) async {
    if (multipart.path == null) {
      throw ArgumentError('Multipart path cannot be null');
    }
    if (multipart.fileBytes == null) {
      throw ArgumentError('Multipart fileBytes cannot be null');
    }

    try {
      final formData = FormData.fromMap({
        multipart.fileKey: MultipartFile.fromBytes(
          multipart.fileBytes!,
          filename: multipart.fileName,
          contentType: multipart.contentType != null
              ? DioMediaType.parse(multipart.contentType!)
              : null,
        ),
      });

      final response = await _dio.post(
        multipart.path!,
        data: formData,
        options: Options(headers: {'Content-Type': 'multipart/form-data'}),
      );

      return DioAdapter.toClientResponse(response);
    } on DioException catch (e) {
      throw DioAdapter.toClientException(e);
    }
  }
}
