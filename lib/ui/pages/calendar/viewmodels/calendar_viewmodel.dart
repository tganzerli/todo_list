import 'package:todo_list/core/core.dart';
import 'package:todo_list/data/repositories/posts/posts_repository.dart';
import 'package:todo_list/domain/entities/posts_entity.dart';
import 'package:todo_list/domain/enums/posts_status_enum.dart';

import 'calendar_viewmodel_state.dart';

class CalendarViewModel extends ViewModel<CalendarViewmodelState> {
  final PostsRepository postsRepository;

  late final Command0<Unit> initEvent;
  late final Command1<List<PostsEntity>, List<PostsStatusEnum>> filterEvent;

  CalendarViewModel({required this.postsRepository})
      : super(CalendarInitial()) {
    initEvent = Command0(_initEvent);
    filterEvent = Command1(_filterEvent);
  }

  AsyncOutput<Unit> _initEvent() async {
    return postsRepository
        .getPosts()
        .onSuccess((posts) => emit(state.success(posts: posts)))
        .onFailure((exception) => emit(state.error(message: exception.message)))
        .flatMap((_) => success(unit));
  }

  AsyncOutput<List<PostsEntity>> _filterEvent(
      List<PostsStatusEnum> status) async {
    final list =
        state.posts.where((post) => status.contains(post.status)).toList();
    return success(list);
  }
}
