import 'dart:math';

import 'package:todo_list/core/core.dart';
import 'package:todo_list/domain/entities/posts_entity.dart';
import 'package:todo_list/domain/entities/user_entity.dart';
import 'package:todo_list/domain/enums/posts_status_enum.dart';
import 'package:todo_list/domain/parameters/post_add_parameter.dart';
import 'package:todo_list/domain/parameters/post_edit_parameter.dart';

class PostsAdapter {
  static Output<PostsEntity> addPostData(
      {required Map<String, dynamic> data,
      required PostAddParameter param,
      required UserEntity user}) {
    try {
      return success(PostsEntity(
        id: data['id'] ?? 0,
        title: param.title,
        body: param.body,
        date: param.date,
        status: param.status,
        user: user,
      ));
    } on BaseException catch (e) {
      return failure(e);
    } catch (e) {
      return failure(
          FormatedException(message: 'PostsAdapter - addPostData: $e'));
    }
  }

  static Output<PostsEntity> editPostData({
    required PostsEntity oldPost,
    required PostEditParameter param,
  }) {
    try {
      return success(PostsEntity(
        id: oldPost.id,
        title: param.title ?? oldPost.title,
        body: param.body ?? oldPost.body,
        date: param.date ?? oldPost.date,
        status: param.status ?? oldPost.status,
        user: oldPost.user,
      ));
    } on BaseException catch (e) {
      return failure(e);
    } catch (e) {
      return failure(
          FormatedException(message: 'PostsAdapter - editPostData: $e'));
    }
  }

  static Output<List<PostsEntity>> getPostsData({
    required List<Map<String, dynamic>> data,
    required List<UserEntity> users,
  }) {
    try {
      dayGenerator() {
        int num = Random().nextInt(10);
        if (num < 3) {
          return num * -1;
        } else {
          return num - 3;
        }
      }

      PostsStatusEnum statusGenerator(DateTime date) {
        DateTime now = DateTime.now();
        if (date.isAfter(now)) {
          return PostsStatusEnum.complete;
        } else if (now.difference(date).inDays == 0) {
          return PostsStatusEnum.inProgress;
        }
        return PostsStatusEnum.todo;
      }

      return success(data.map((postMap) {
        final date = DateTime.now().add(Duration(days: dayGenerator()));
        return PostsEntity(
          id: postMap['id'],
          title: postMap['title'],
          body: postMap['body'],
          date: date,
          status: statusGenerator(date),
          user: users.where((user) => user.id == postMap['userId']).first,
        );
      }).toList());
    } on BaseException catch (e) {
      return failure(e);
    } catch (e) {
      return failure(
          FormatedException(message: 'PostsAdapter - addPostData: $e'));
    }
  }
}
