import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_list/core/core.dart';
import 'package:todo_list/core/services/client/dio/dio_impl.dart';

class MockDio extends Mock implements DioForNative {}

class MockResponse extends Mock implements Response {}

class MockInterceptor extends Mock implements ClientInterceptor {}

void main() {
  late MockDio mockDio;
  late RestClient client;
  late Interceptors interceptors;
  late BaseOptions options;

  setUp(() {
    mockDio = MockDio();
    interceptors = Interceptors();

    options = BaseOptions(
      baseUrl: '',
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 5000),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Charset': 'utf-8',
      },
    );

    when(() => mockDio.options).thenReturn(options);

    when(() => mockDio.interceptors).thenReturn(interceptors);

    client = RestClientDioImpl(dio: mockDio);
  });

  group('RestClientDioImpl Sets', () {
    test('Should set base URL correctly', () async {
      const url = 'https://api.example.com';
      client.setBaseUrl(url);

      expect(mockDio.options.baseUrl, equals(url));
    });

    test('Should set headers correctly', () {
      final headers = {'Authorization': 'Bearer token'};
      client.setHeaders(headers);
      expect(mockDio.options.headers['Authorization'], equals('Bearer token'));
      expect(mockDio.options.headers, contains('Content-Type'));
      expect(mockDio.options.headers, contains('Charset'));
    });

    test('Should clean headers correctly', () {
      mockDio.options.headers['Authorization'] = 'Bearer token';
      client.cleanHeaders();
      expect(mockDio.options.headers, contains('Content-Type'));
      expect(mockDio.options.headers, contains('Charset'));
      expect(mockDio.options.headers, isNot(contains('Authorization')));
    });

    test('Should set timeouts correctly', () {
      final time = Duration(milliseconds: 10000);
      client.setTimeouts(connectTimeout: time, receiveTimeout: time);
      expect(mockDio.options.connectTimeout, equals(time));
      expect(mockDio.options.receiveTimeout, equals(time));
    });
  });
  group('Interceptors Sets', () {
    test('Should add multiple interceptors correctly', () {
      final interceptor1 = MockInterceptor();
      final interceptor2 = MockInterceptor();

      client.addInterceptor(interceptor1);
      client.addInterceptor(interceptor2);

      final interceptors = client.getInterceptors();

      expect(interceptors, containsAll([interceptor1, interceptor2]));
      expect(interceptors.length, equals(2));
    });

    test('Should not add duplicate interceptors', () {
      final interceptor = MockInterceptor();

      client.addInterceptor(interceptor);
      client.addInterceptor(interceptor);

      final interceptors = client.getInterceptors();

      expect(interceptors.length, equals(1));
    });

    test('Should remove interceptor correctly', () {
      final interceptor1 = MockInterceptor();
      final interceptor2 = MockInterceptor();

      client.addInterceptor(interceptor1);
      client.addInterceptor(interceptor2);

      client.removeInterceptor(interceptor1);

      final interceptors = client.getInterceptors();

      expect(interceptors.length, equals(1));
      expect(interceptors.contains(interceptor1), isFalse);
      expect(interceptors.contains(interceptor2), isTrue);
    });

    test('Should clear interceptors correctly', () {
      final interceptor1 = MockInterceptor();
      final interceptor2 = MockInterceptor();

      client.addInterceptor(interceptor1);
      client.addInterceptor(interceptor2);

      client.clearInterceptors();

      final interceptors = client.getInterceptors();

      expect(interceptors, isEmpty);
    });
  });

  group('Request tests', () {
    test('Should handle GET request correctly', () async {
      final request = RestClientRequest(
        path: '/test',
        method: RestMethod.get,
      );

      when(() =>
          mockDio.get(any(),
              queryParameters: any(named: 'queryParameters'),
              options: any(named: 'options'))).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: request.path),
            data: {'message': 'success'},
            statusCode: 200,
          ));

      final response = await client.request(request);

      expect(response.statusCode, equals(200));
      expect(response.data, equals({'message': 'success'}));
    });

    test('Should handle POST request correctly', () async {
      final request = RestClientRequest(
        path: '/post',
        method: RestMethod.post,
        data: {'key': 'value'},
      );

      when(() =>
          mockDio.post(any(),
              data: any(named: 'data'),
              queryParameters: any(named: 'queryParameters'),
              options: any(named: 'options'))).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: request.path),
            data: {'message': 'created'},
            statusCode: 201,
          ));

      final response = await client.request(request);

      expect(response.statusCode, equals(201));
      expect(response.data, equals({'message': 'created'}));
    });

    test('Should handle request errors correctly', () async {
      final request = RestClientRequest(
        path: '/error',
        method: RestMethod.get,
      );

      final dioException = DioException(
        requestOptions: RequestOptions(path: request.path),
        response: Response(
          requestOptions: RequestOptions(path: request.path),
          statusCode: 500,
          data: {'error': 'Internal Server Error'},
        ),
        type: DioExceptionType.badResponse,
      );

      when(() => mockDio.get(any(),
          queryParameters: any(named: 'queryParameters'),
          options: any(named: 'options'))).thenThrow(dioException);

      expect(
        () async => await client.request(request),
        throwsA(isA<RestClientException>()
            .having((e) => e.statusCode, 'status code', equals(500))),
      );
    });

    test('Should handle file upload correctly', () async {
      final multipart = RestClientMultipart(
        fileKey: 'file',
        fileName: 'test.jpg',
        fileBytes: Uint8List.fromList([0, 1, 2, 3]),
        contentType: 'image/jpeg',
        path: '/upload',
      );

      when(() => mockDio.post(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          )).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: '/upload'),
            data: {'message': 'uploaded'},
            statusCode: 200,
          ));

      final response = await client.upload(multipart);

      expect(response.statusCode, equals(200));
      expect(response.data, equals({'message': 'uploaded'}));
    });
  });
}
