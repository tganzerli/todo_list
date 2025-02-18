import 'package:todo_list/core/core.dart';
import 'package:todo_list/data/repositories/posts/posts_repository.dart';
import 'package:todo_list/domain/entities/posts_entity.dart';

import 'home_viewmodel_state.dart';

class HomeViewModel extends ViewModel<HomeViewmodelState> {
  final PostsRepository postsRepository;

  late final Command0<List<PostsEntity>> initEvent;

  HomeViewModel({required this.postsRepository}) : super(HomeInitial()) {
    initEvent = Command0(_initEvent);
  }

  AsyncOutput<List<PostsEntity>> _initEvent() async {
    emit(state.loading());
    final response = await postsRepository.getPosts();
    return response.fold(
      (exception) {
        emit(state.error(message: exception.message));
        return failure(exception);
      },
      (posts) {
        emit(state.success(posts: posts));
        return success(posts);
      },
    );
  }
}
