import 'package:flutter/widgets.dart';
import 'package:todo_list/core/core.dart';
import 'package:todo_list/domain/entities/posts_entity.dart';
import 'package:todo_list/domain/entities/user_logged_entity.dart';

abstract class HomeViewmodelState implements ViewState {
  final List<PostsEntity> posts;
  final UserLoggedEntity? user;
  HomeViewmodelState({required this.posts, required this.user});

  HomeLoading loading() => HomeLoading(posts: posts, user: user);

  HomeSuccess success({
    List<PostsEntity>? posts,
    ValueGetter<UserLoggedEntity?>? user,
  }) {
    return HomeSuccess(
      posts: posts ?? this.posts,
      user: user != null ? user() : this.user,
    );
  }

  HomeError error({required String message}) =>
      HomeError(posts: posts, user: user, message: message);
}

class HomeInitial extends HomeViewmodelState {
  HomeInitial() : super(posts: [], user: null);
}

class HomeLoading extends HomeViewmodelState {
  HomeLoading({required super.posts, required super.user});
}

class HomeSuccess extends HomeViewmodelState {
  HomeSuccess({required super.posts, required super.user});
}

class HomeError extends HomeViewmodelState {
  final String message;
  HomeError({
    required super.posts,
    required super.user,
    required this.message,
  });
}
