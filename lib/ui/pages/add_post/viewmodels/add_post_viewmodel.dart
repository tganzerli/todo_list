import 'package:todo_list/core/core.dart';
import 'package:todo_list/data/repositories/posts/posts_repository.dart';
import 'package:todo_list/domain/parameters/post_add_parameter.dart';

import 'add_post_viewmodel_state.dart';

class AddPostViewModel extends ViewModel<AddPostViewmodelState> {
  final PostsRepository postsRepository;

  late final Command1<Unit, PostAddParameter> addEvent;

  AddPostViewModel({required this.postsRepository}) : super(AddPostInitial()) {
    addEvent = Command1(_addEvent);
  }

  AsyncOutput<Unit> _addEvent(PostAddParameter param) async {
    emit(state.loading());
    return param
        .validate() //
        .asyncBind((paramValid) => postsRepository //
            .addPost(paramValid)
            .flatMap((_) => success(unit))
            .onSuccess((_) => emit(state.success()))
            .onFailure(
                (exception) => emit(state.error(message: exception.message))))
        .onFailure(
            (exception) => emit(state.error(message: exception.message)));
  }
}
