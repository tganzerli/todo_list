import 'dart:async';

import 'package:todo_list/core/core.dart';
import 'package:todo_list/data/repositories/auth/auth_repository.dart';
import 'package:todo_list/data/repositories/posts/posts_repository.dart';
import 'package:todo_list/domain/entities/posts_entity.dart';
import 'package:todo_list/domain/enums/posts_status_enum.dart';

import 'home_viewmodel_state.dart';

class HomeViewModel extends ViewModel<HomeViewmodelState> {
  final AuthRepository authRepository;
  final PostsRepository postsRepository;

  late final Command0<Unit> initEvent;

  HomeViewModel({required this.authRepository, required this.postsRepository})
      : super(HomeInitial()) {
    initEvent = Command0(_initEvent);
  }
  bool wasStarted = false;
  late final StreamSubscription _streamSubscription;

  void license(List<PostsEntity> posts) {
    emit(state.success(posts: posts));
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  List<PostsEntity> userNextsPosts() {
    List<PostsEntity> posts = state.posts
        .where((posts) => posts.user.id == state.user!.id)
        .where(
            (posts) => !posts.date.difference(DateTime.now()).inDays.isNegative)
        .toList();

    posts.sort((a, b) => a.date.compareTo(b.date));
    return posts;
  }

  List<PostsEntity> inProgressPosts() {
    List<PostsEntity> posts = state.posts
        .where((posts) => posts.status == PostsStatusEnum.inProgress)
        .toList();

    posts.sort((a, b) => a.date.compareTo(b.date));
    return posts;
  }

  AsyncOutput<Unit> _initEvent() async {
    if (!wasStarted) {
      wasStarted = true;
      emit(state.loading());
      _streamSubscription = postsRepository.postsObserver().listen(license);
      return authRepository
          .getUser() //
          .onSuccess((user) {
            emit(state.success(user: () => user));
          }) //
          .flatMap((_) => postsRepository.getPosts()) //
          .flatMap((_) => success(unit));
    }
    return success(unit);
  }
}
