import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_list/core/core.dart';
import 'package:todo_list/data/datasources/posts/posts_cache.dart';
import 'package:todo_list/domain/entities/posts_entity.dart';
import 'package:todo_list/domain/entities/user_entity.dart';
import 'package:todo_list/domain/enums/posts_status_enum.dart';

class MockCache extends Mock implements Cache {}

class MockUserEntity extends Mock implements UserEntity {
  @override
  Map<String, dynamic> toMap() {
    return {};
  }
}

class FakeCacheParams extends Fake implements CacheParams {}

void main() {
  late PostsCache postsCache;
  late MockCache mockCache;
  late List<PostsEntity> posts;

  setUpAll(() {
    registerFallbackValue(FakeCacheParams());
  });

  setUp(() {
    mockCache = MockCache();
    postsCache = PostsCache(cache: mockCache);

    posts = [
      PostsEntity(
          id: 1,
          title: 'Test Post 1',
          body: 'Content 1',
          date: DateTime.now(),
          status: PostsStatusEnum.todo,
          user: MockUserEntity()),
      PostsEntity(
          id: 2,
          title: 'Test Post 2',
          body: 'Content 2',
          date: DateTime.now(),
          status: PostsStatusEnum.todo,
          user: MockUserEntity())
    ];
  });

  group('PostsCache - getPosts', () {
    test('should return list of PostsEntity when cache returns data', () async {
      final mockData = posts.map((post) => post.toMap()).toList();
      when(() => mockCache.getData(any())).thenAnswer((_) async => mockData);

      final result = await postsCache.getPosts();

      expect(result.isRight, true);
      expect(result.getOrNull(), isA<List<PostsEntity>>());
      expect(result.getOrNull()!.length, 2);
    });

    test('should return failure when cache throws an exception', () async {
      when(() => mockCache.getData(any()))
          .thenThrow(CacheException(message: 'Error fetching data'));

      final result = await postsCache.getPosts();

      expect(result.isLeft, true);
      expect(result.getLeftOrNull(), isA<CacheException>());
    });
  });

  group('PostsCache - savePosts', () {
    test('should save posts and return success', () async {
      when(() => mockCache.removeData(any())).thenAnswer((_) async => true);
      when(() => mockCache.setData(params: any(named: 'params')))
          .thenAnswer((_) async => true);

      final result = await postsCache.savePosts(posts);

      expect(result.isRight, true);
      expect(result.getOrNull(), posts);
    });

    test('should return failure when cache fails to save data', () async {
      when(() => mockCache.removeData(any())).thenAnswer((_) async => true);
      when(() => mockCache.setData(params: any(named: 'params')))
          .thenAnswer((_) async => false);

      final result = await postsCache.savePosts([]);

      expect(result.isLeft, true);
      expect(result.getLeftOrNull(), isA<CacheException>());
    });
  });

  group('PostsCache - getPost', () {
    test('should get a post and return it', () async {
      when(() => mockCache.getData(any()))
          .thenAnswer((_) async => posts.map((post) => post.toMap()).toList());

      final result = await postsCache.getPost(2);

      expect(result.isRight, true);
      expect(result.getOrNull()!.id, 2);
    });

    test('should return failure when getPosts fails', () async {
      when(() => mockCache.getData(any()))
          .thenThrow(CacheException(message: 'Error fetching posts'));

      final result = await postsCache.getPost(2);

      expect(result.isLeft, true);
      expect(result.getLeftOrNull(), isA<CacheException>());
    });
  });

  group('PostsCache - savePost', () {
    final newPost = PostsEntity(
        id: 2,
        title: 'New Post',
        body: 'New Content',
        date: DateTime.now(),
        status: PostsStatusEnum.todo,
        user: MockUserEntity());
    test('should save a new post and return it', () async {
      final expectedNewPost = newPost.changeId(3);

      when(() => mockCache.getData(any()))
          .thenAnswer((_) async => posts.map((post) => post.toMap()).toList());
      when(() => mockCache.removeData(any())).thenAnswer((_) async => true);
      when(() => mockCache.setData(params: any(named: 'params')))
          .thenAnswer((_) async => true);

      final result = await postsCache.savePost(newPost);

      expect(result.isRight, true);
      expect(result.getOrNull()!.id, expectedNewPost.id);
    });

    test('should return failure when getPosts fails', () async {
      when(() => mockCache.getData(any()))
          .thenThrow(CacheException(message: 'Error fetching posts'));

      final result = await postsCache.savePost(newPost);

      expect(result.isLeft, true);
      expect(result.getLeftOrNull(), isA<CacheException>());
    });
  });

  group('PostsCache - editPost', () {
    final updatedPost = PostsEntity(
        id: 2,
        title: 'New Title',
        body: 'New Content',
        date: DateTime.now(),
        status: PostsStatusEnum.todo,
        user: MockUserEntity());
    test('should update an existing post', () async {
      when(() => mockCache.getData(any()))
          .thenAnswer((_) async => posts.map((post) => post.toMap()).toList());
      when(() => mockCache.removeData(any())).thenAnswer((_) async => true);
      when(() => mockCache.setData(params: any(named: 'params')))
          .thenAnswer((_) async => true);

      final result = await postsCache.editPost(updatedPost);

      expect(result.isRight, true);
      expect(result.getOrNull(), updatedPost);
    });

    test('should return failure when getPosts fails', () async {
      when(() => mockCache.getData(any()))
          .thenThrow(CacheException(message: 'Error fetching posts'));

      final result = await postsCache.editPost(updatedPost);

      expect(result.isLeft, true);
      expect(result.getLeftOrNull(), isA<CacheException>());
    });
  });
}
