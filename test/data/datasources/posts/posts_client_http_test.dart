import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:todo_list/core/core.dart';
import 'package:todo_list/data/datasources/posts/posts_client_http.dart';

import '../../../mock/posts_mock.dart';

class MockRestClient extends Mock implements RestClient {}

class MockRestClientResponse extends Mock implements RestClientResponse {
  final dynamic date;
  MockRestClientResponse({
    required this.date,
  });

  @override
  get data => date;
}

class FakeRestClientRequest extends Fake implements RestClientRequest {}

void main() {
  late List<Map<String, dynamic>> postsMock;
  late PostsClientHttp postsClientHttp;
  late MockRestClient mockRestClient;

  setUpAll(() {
    registerFallbackValue(FakeRestClientRequest());
  });

  setUp(() {
    postsMock = PostsMock.posts;
    mockRestClient = MockRestClient();
    postsClientHttp = PostsClientHttp(restClient: mockRestClient);
  });

  group('PostsClientHttp - getPosts', () {
    late RestClientResponse restClientResponse;
    test('should return a list of posts when request is successful', () async {
      restClientResponse = MockRestClientResponse(date: postsMock);
      when(() => mockRestClient.request(any())).thenAnswer(
        (_) async => restClientResponse,
      );

      final result = await postsClientHttp.getPosts();

      expect(result.isRight, true);
      expect(result.getOrNull(), postsMock);
    });

    test(
        'should return failure when response is not a List<Map<String, dynamic>>',
        () async {
      restClientResponse = MockRestClientResponse(date: "Invalid Data");
      when(() => mockRestClient.request(any())).thenAnswer(
        (_) async => restClientResponse,
      );

      final result = await postsClientHttp.getPosts();

      expect(result.isRight, false);
      expect(result.getLeftOrNull(), isA<FormatedException>());
    });

    test('should return failure when an exception occurs', () async {
      when(() => mockRestClient.request(any()))
          .thenThrow(Exception("API Error"));

      final result = await postsClientHttp.getPosts();

      expect(result.isRight, false);
      expect(result.getLeftOrNull(), isA<DefaultException>());
    });
  });

  group('PostsClientHttp - addPosts', () {
    final postData = {"title": "New Post", "body": "New Body", "userId": 1};

    test('should return added post data when request is successful', () async {
      final mockResponse = {"id": 101};

      when(() => mockRestClient.request(any())).thenAnswer(
        (_) async => MockRestClientResponse(date: mockResponse),
      );

      final result = await postsClientHttp.addPosts(postData);

      expect(result.isRight, true);
      expect(result.getOrNull(), mockResponse);
    });

    test('should return failure when response is not a Map<String, dynamic>',
        () async {
      when(() => mockRestClient.request(any())).thenAnswer(
        (_) async => MockRestClientResponse(date: "Invalid Data"),
      );

      final result = await postsClientHttp.addPosts(postData);

      expect(result.isRight, false);
      expect(result.getLeftOrNull(), isA<FormatedException>());
    });

    test('should return failure when an exception occurs', () async {
      when(() => mockRestClient.request(any()))
          .thenThrow(Exception("API Error"));

      final result = await postsClientHttp.addPosts(postData);

      expect(result.isRight, false);
      expect(result.getLeftOrNull(), isA<DefaultException>());
    });
  });
}
