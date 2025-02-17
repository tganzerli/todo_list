import 'dart:developer';

import 'package:todo_list/core/core.dart';
import 'package:todo_list/domain/entities/posts_entity.dart';

const String _postsKey = 'postsKey';

class PostsCache {
  final Cache cache;

  PostsCache({required this.cache});

  AsyncOutput<List<PostsEntity>> getPosts() async {
    try {
      final List<Map<String, dynamic>> response =
          await cache.getData(_postsKey);

      return success(
          response.map((postMap) => PostsEntity.fromMap(postMap)).toList());
    } on BaseException catch (exception) {
      return failure(exception);
    } catch (e) {
      log(e.toString(), name: 'PostsCache - getPosts');
      return failure(DefaultException(message: e.toString()));
    }
  }

  AsyncOutput<List<PostsEntity>> savePosts(List<PostsEntity> posts) async {
    try {
      await cache.removeData(_postsKey);
      CacheParams params = CacheParams(
          key: _postsKey, value: posts.map((post) => post.toMap()).toList());
      final response = await cache.setData(params: params);
      if (response) {
        return success(posts);
      } else {
        return failure(CacheException(message: 'Posts were not saved'));
      }
    } on BaseException catch (exception) {
      return failure(exception);
    } catch (e) {
      log(e.toString(), name: 'PostsCache - savePosts');
      return failure(DefaultException(message: e.toString()));
    }
  }

  AsyncOutput<PostsEntity> getPost(int postId) async {
    return getPosts() //
        .map((posts) => posts.where((post) => post.id == postId).first);
  }

  AsyncOutput<PostsEntity> savePost(PostsEntity post) async {
    return getPosts() //
        .flatMap((posts) {
      // <== Mock Id post =>>
      posts.sort((a, b) => a.id.compareTo(b.id));
      final newPost = post.changeId(posts.last.id + 1);
      // <== Mock Id post =>>
      posts.add(newPost);
      return savePosts(posts);
    }) //
        .flatMap((posts) => success(posts.last));
  }

  AsyncOutput<PostsEntity> editPost(PostsEntity post) async {
    return getPosts() //
        .flatMap((posts) => savePosts(posts //
            .map((postList) => postList.id == post.id ? post : postList) //
            .toList())) //
        .flatMap((_) => success(post));
  }
}
