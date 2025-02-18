import 'package:todo_list/core/core.dart';
import 'package:todo_list/domain/entities/posts_entity.dart';

abstract class HomeViewmodelState implements ViewState {
  final List<PostsEntity> posts;

  HomeViewmodelState({required this.posts});

  HomeLoading loading() => HomeLoading(posts: posts);

  HomeSuccess success({List<PostsEntity>? posts}) =>
      HomeSuccess(posts: posts ?? this.posts);

  HomeError error({required String message}) =>
      HomeError(posts: posts, message: message);
}

class HomeInitial extends HomeViewmodelState {
  HomeInitial() : super(posts: []);
}

class HomeLoading extends HomeViewmodelState {
  HomeLoading({required super.posts});
}

class HomeSuccess extends HomeViewmodelState {
  HomeSuccess({required super.posts});
}

class HomeError extends HomeViewmodelState {
  final String message;
  HomeError({
    required super.posts,
    required this.message,
  });
}
