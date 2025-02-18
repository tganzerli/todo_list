import 'package:todo_list/core/core.dart';

abstract class AddPostViewmodelState implements ViewState {
  AddPostViewmodelState();

  AddPostLoading loading() => AddPostLoading();

  AddPostSuccess success() => AddPostSuccess();

  AddPostError error({required String message}) =>
      AddPostError(message: message);
}

class AddPostInitial extends AddPostViewmodelState {
  AddPostInitial() : super();
}

class AddPostLoading extends AddPostViewmodelState {}

class AddPostSuccess extends AddPostViewmodelState {}

class AddPostError extends AddPostViewmodelState {
  final String message;
  AddPostError({
    required this.message,
  });
}
