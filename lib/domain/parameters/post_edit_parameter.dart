import 'dart:convert';

import 'package:todo_list/core/core.dart';
import 'package:todo_list/domain/enums/posts_status_enum.dart';

class PostEditParameter extends Parameters {
  final int id;
  final String? title;
  final String? body;
  final PostsStatusEnum? status;
  PostEditParameter({
    required this.id,
    this.title,
    this.body,
    this.status,
  });

  @override
  Output<PostEditParameter> validate() {
    if (id <= 0) {
      return failure(ValidationException(message: 'Id invalido'));
    }
    if (title == null && body == null && status == null) {
      return failure(
          ValidationException(message: 'Post sem variavel para ser editada'));
    }
    if (title != null && title!.isEmpty) {
      return failure(ValidationException(message: 'Post sem titulo'));
    }
    if (title != null && title!.length > 100) {
      return failure(ValidationException(message: 'Titulo muito grande'));
    }
    if (body != null && body!.isEmpty) {
      return failure(ValidationException(message: 'Post sem Texto'));
    }
    if (body != null && body!.length > 500) {
      return failure(ValidationException(message: 'Texto muito grande'));
    }

    return success(this);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'status': status?.toMap(),
    };
  }

  factory PostEditParameter.fromMap(Map<String, dynamic> map) {
    return PostEditParameter(
      id: map['id']?.toInt() ?? 0,
      title: map['title'],
      body: map['body'],
      status:
          map['status'] != null ? PostsStatusEnum.fromMap(map['status']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostEditParameter.fromJson(String source) =>
      PostEditParameter.fromMap(json.decode(source));
}
