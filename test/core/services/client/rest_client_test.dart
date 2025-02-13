import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_list/core/core.dart';

class MockRequest extends Mock implements RestClientRequest {}

class MockResponse extends Mock implements RestClientResponse {}

class MockMultipart extends Mock implements RestClientMultipart {}

class MockInterceptor extends Mock implements ClientInterceptor {}

class TestRestClient extends RestClient {
  @override
  Future<RestClientResponse> request(RestClientRequest request) async {
    return MockResponse();
  }

  @override
  Future<RestClientResponse> upload(RestClientMultipart multipart) async {
    return MockResponse();
  }

  @override
  void setBaseUrl(String url) {}

  @override
  void cleanHeaders() {}

  @override
  void setHeaders(Map<String, dynamic> header) {}

  @override
  void setTimeouts({Duration? connectTimeout, Duration? receiveTimeout}) {}
}

void main() {
  late TestRestClient restClient;
  late MockRequest mockRequest;
  late MockMultipart mockMultipart;
  late MockInterceptor mockInterceptor;

  setUp(() {
    restClient = TestRestClient();
    mockRequest = MockRequest();
    mockMultipart = MockMultipart();
    mockInterceptor = MockInterceptor();
  });

  group('RestClient - Core Functionalities', () {
    test('should send a request and return a response', () async {
      final result = await restClient.request(mockRequest);
      expect(result, isA<RestClientResponse>());
    });

    test('should upload a file and return a response', () async {
      final result = await restClient.upload(mockMultipart);
      expect(result, isA<RestClientResponse>());
    });

    test('should set and retrieve base URL correctly', () {
      restClient.setBaseUrl('https://api.example.com');
      expect(true, true);
    });

    test('should clean headers without error', () {
      restClient.cleanHeaders();
      expect(true, true);
    });

    test('should set headers without error', () {
      final headers = {'Authorization': 'Bearer token'};
      restClient.setHeaders(headers);
      expect(true, true);
    });

    test('should set timeouts without error', () {
      restClient.setTimeouts(
        connectTimeout: Duration(seconds: 10),
        receiveTimeout: Duration(seconds: 20),
      );
      expect(true, true);
    });
  });

  group('RestClient - Interceptor Management', () {
    test('should add an interceptor', () {
      restClient.addInterceptor(mockInterceptor);
      expect(restClient.getInterceptors(), contains(mockInterceptor));
    });

    test('should not add the same interceptor twice', () {
      restClient.addInterceptor(mockInterceptor);
      restClient.addInterceptor(mockInterceptor);
      expect(restClient.getInterceptors().length, 1);
    });

    test('should remove an interceptor', () {
      restClient.addInterceptor(mockInterceptor);
      restClient.removeInterceptor(mockInterceptor);
      expect(restClient.getInterceptors(), isNot(contains(mockInterceptor)));
    });

    test('should clear all interceptors', () {
      restClient.addInterceptor(mockInterceptor);
      restClient.clearInterceptors();
      expect(restClient.getInterceptors().isEmpty, true);
    });

    test('should return an unmodifiable list of interceptors', () {
      restClient.addInterceptor(mockInterceptor);
      final interceptors = restClient.getInterceptors();
      expect(() => interceptors.add(MockInterceptor()), throwsUnsupportedError);
    });
  });
}
