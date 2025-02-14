import 'dart:convert';

import 'package:todo_list/core/core.dart';
import 'package:todo_list/domain/enums/posts_status_enum.dart';

class PostsParameter extends Parameters {
  final String title;
  final String body;
  final PostsStatusEnum status;
  final int? userId;
  PostsParameter({
    required this.title,
    required this.body,
    required this.status,
    this.userId,
  });

  @override
  Output<PostsParameter> validate() {
    if (userId != null && userId! <= 0) {
      return failure(ValidationException(message: 'Id do usuario invalido'));
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

    return success(this);
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
      'status': status.toMap(),
      'userId': userId,
    };
  }

  factory PostsParameter.fromMap(Map<String, dynamic> map) {
    return PostsParameter(
      title: map['title'] ?? '',
      body: map['body'] ?? '',
      status: PostsStatusEnum.fromMap(map['status']),
      userId: map['userId']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory PostsParameter.fromJson(String source) =>
      PostsParameter.fromMap(json.decode(source));
}
