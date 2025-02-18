import 'dart:convert';

import 'package:todo_list/core/core.dart';
import 'package:todo_list/domain/enums/posts_status_enum.dart';
import 'package:todo_list/domain/validator/body_validator.dart';
import 'package:todo_list/domain/validator/title_validator.dart';

class PostEditParameter extends Parameters {
  final int id;
  final String? title;
  final String? body;
  final DateTime? date;
  final PostsStatusEnum? status;
  PostEditParameter({
    required this.id,
    this.title,
    this.body,
    this.date,
    this.status,
  });

  @override
  Output<PostEditParameter> validate() {
    if (id <= 0) {
      return failure(ValidationException(message: 'Id invalido'));
    }
    if (title == null && body == null && status == null && date == null) {
      return failure(
          ValidationException(message: 'Post sem variavel para ser editada'));
    }

    return TitleValidator.validate(title) //
        .map((_) => BodyValidator.validate(body))
        .map((_) => this);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'date': date?.millisecondsSinceEpoch,
      'status': status?.toMap(),
    };
  }

  factory PostEditParameter.fromMap(Map<String, dynamic> map) {
    return PostEditParameter(
      id: map['id']?.toInt() ?? 0,
      title: map['title'],
      body: map['body'],
      date: map['date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['date'])
          : null,
      status:
          map['status'] != null ? PostsStatusEnum.fromMap(map['status']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostEditParameter.fromJson(String source) =>
      PostEditParameter.fromMap(json.decode(source));
}
