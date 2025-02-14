import 'dart:convert';

import 'package:todo_list/core/core.dart';
import 'package:todo_list/domain/enums/posts_status_enum.dart';

import 'user_entity.dart';

class PostsEntity extends Entity<int> {
  final String title;
  final String body;
  final PostsStatusEnum status;
  final UserEntity user;
  PostsEntity({
    required super.id,
    required this.title,
    required this.body,
    required this.status,
    required this.user,
  });

  @override
  Output<PostsEntity> validate() {
    if (super.id <= 0) {
      return failure(ValidationException(message: 'Id invalido'));
    }
    if (title.isEmpty) {
      return failure(ValidationException(message: 'Post sem titulo'));
    }
    if (title.length > 100) {
      return failure(ValidationException(message: 'Titulo muito grande'));
    }
    if (body.isEmpty) {
      return failure(ValidationException(message: 'Post sem Texto'));
    }
    if (body.length > 500) {
      return failure(ValidationException(message: 'Texto muito grande'));
    }
    if (user.validate().isLeft) {
      return user.validate().map((_) => this);
    }

    return success(this);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': super.id,
      'title': title,
      'body': body,
      'status': status.toMap(),
      'user': user.toMap(),
    };
  }

  factory PostsEntity.fromMap(Map<String, dynamic> map) {
    return PostsEntity(
      id: map['id'] ?? 0,
      title: map['title'] ?? '',
      body: map['body'] ?? '',
      status: PostsStatusEnum.fromMap(map['status']),
      user: UserEntity.fromMap(map['user']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PostsEntity.fromJson(String source) =>
      PostsEntity.fromMap(json.decode(source));
}
