import 'dart:async';

import 'package:todo_list/core/output/async_output.dart';
import 'package:todo_list/data/adapters/posts/posts_adapter.dart';
import 'package:todo_list/data/datasources/posts/posts_cache.dart';
import 'package:todo_list/data/datasources/posts/posts_client_http.dart';
import 'package:todo_list/data/datasources/users/user_logged_cache.dart';
import 'package:todo_list/data/datasources/users/users_client_mock.dart';
import 'package:todo_list/domain/entities/posts_entity.dart';
import 'package:todo_list/domain/parameters/post_add_parameter.dart';
import 'package:todo_list/domain/parameters/post_edit_parameter.dart';

import 'posts_repository.dart';

class RemotePostsRepository implements PostsRepository {
  final PostsCache postsCache;
  final PostsClientHttp postsClientHttp;
  final UserLoggedCache userLoggedCache;
  final UsersClientMock usersClientMock;
  RemotePostsRepository({
    required this.postsCache,
    required this.postsClientHttp,
    required this.userLoggedCache,
    required this.usersClientMock,
  });

  final _streamController = StreamController<List<PostsEntity>>.broadcast();

  @override
  AsyncOutput<PostsEntity> addPost(PostAddParameter param) async {
    return userLoggedCache //
        .getUserLogged() //
        .flatMap((user) => param //
            .copyWith(userId: () => user.id) //
            .validate() //
            .asyncBind((paramValid) => postsClientHttp //
                .addPosts(paramValid.toMap()) //
                .flatMap((data) => PostsAdapter //
                    .addPostData(
                        data: data, param: paramValid, user: user)))) //
        .flatMap((post) => postsCache.savePost(post))
        .onSuccess(
      (_) {
        postsCache
            .getPosts() //
            .onSuccess((posts) => _streamController.add(posts));
      },
    );
  }

  @override
  AsyncOutput<PostsEntity> editPost(PostEditParameter param) async {
    return param //
        .validate() //
        .asyncBind((paramValid) => postsClientHttp //
                .editPosts(paramValid.toMap()) //
                .flatMap((_) => postsCache //
                    .getPost(paramValid.id) //
                    .flatMap((oldPost) => PostsAdapter //
                        .editPostData(oldPost: oldPost, param: param))) //
                .flatMap((post) => postsCache.editPost(post)) //
                .onSuccess(
              (_) {
                postsCache
                    .getPosts() //
                    .onSuccess((posts) => _streamController.add(posts));
              },
            ));
  }

  @override
  AsyncOutput<List<PostsEntity>> getPosts() async {
    return postsClientHttp //
        .getPosts() //
        .flatMap((httpData) => usersClientMock //
            .getUser() //
            .flatMap((users) =>
                PostsAdapter.getPostsData(data: httpData, users: users))) //
        .flatMap((posts) => postsCache.savePosts(posts)) //
        .onSuccess((posts) => _streamController.add(posts));
  }

  @override
  Stream<List<PostsEntity>> postsObserver() {
    return _streamController.stream;
  }

  @override
  void dispose() {
    _streamController.close();
  }
}
