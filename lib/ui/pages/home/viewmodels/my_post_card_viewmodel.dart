import 'package:todo_list/core/core.dart';
import 'package:todo_list/data/repositories/posts/posts_repository.dart';
import 'package:todo_list/domain/entities/posts_entity.dart';
import 'package:todo_list/domain/enums/posts_status_enum.dart';
import 'package:todo_list/domain/parameters/post_edit_parameter.dart';

class MyPostCardViewModel extends ViewModel<UnitViewState> {
  final PostsRepository postsRepository;
  late final Command1<Unit, PostsEntity> updatePostEvent;

  MyPostCardViewModel({required this.postsRepository})
      : super(UnitViewState()) {
    updatePostEvent = Command1(_updatePostEvent);
  }

  AsyncOutput<Unit> _updatePostEvent(PostsEntity post) async {
    PostsStatusEnum newStatus() {
      return switch (post.status) {
        PostsStatusEnum.todo => PostsStatusEnum.inProgress,
        PostsStatusEnum.inProgress => PostsStatusEnum.complete,
        _ => PostsStatusEnum.complete,
      };
    }

    final PostEditParameter param =
        PostEditParameter(id: post.id, status: newStatus());

    return postsRepository.editPost(param).flatMap((_) => success(unit));
  }
}
