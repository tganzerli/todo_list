import 'package:todo_list/core/core.dart';
import 'package:todo_list/domain/entities/posts_entity.dart';

abstract class CalendarViewmodelState implements ViewState {
  final List<PostsEntity> posts;
  CalendarViewmodelState({
    required this.posts,
  });

  CalendarLoading loading() => CalendarLoading(
        posts: posts,
      );

  CalendarSuccess success({
    List<PostsEntity>? posts,
  }) {
    return CalendarSuccess(
      posts: posts ?? this.posts,
    );
  }

  CalendarError error({required String message}) =>
      CalendarError(posts: posts, message: message);
}

class CalendarInitial extends CalendarViewmodelState {
  CalendarInitial() : super(posts: []);
}

class CalendarLoading extends CalendarViewmodelState {
  CalendarLoading({
    required super.posts,
  });
}

class CalendarSuccess extends CalendarViewmodelState {
  CalendarSuccess({
    required super.posts,
  });
}

class CalendarError extends CalendarViewmodelState {
  final String message;
  CalendarError({
    required super.posts,
    required this.message,
  });
}
