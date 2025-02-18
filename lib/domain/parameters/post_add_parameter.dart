import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:todo_list/core/core.dart';
import 'package:todo_list/domain/enums/posts_status_enum.dart';
import 'package:todo_list/domain/validator/body_validator.dart';
import 'package:todo_list/domain/validator/date_validator.dart';
import 'package:todo_list/domain/validator/title_validator.dart';

class PostAddParameter extends Parameters {
  final String title;
  final String body;
  final DateTime date;
  final PostsStatusEnum status;
  final int? userId;
  PostAddParameter({
    required this.title,
    required this.body,
    required this.date,
    required this.status,
    this.userId,
  });

  @override
  Output<PostAddParameter> validate() {
    if (userId != null && userId! <= 0) {
      return failure(ValidationException(message: 'Id do usuario invalido'));
    }

    return TitleValidator.validate(title) //
        .map((_) => BodyValidator.validate(body))
        .map((_) => DateValidator.validate(date))
        .map((_) => this);
  }

  PostAddParameter copyWith({
    String? title,
    String? body,
    DateTime? date,
    PostsStatusEnum? status,
    ValueGetter<int?>? userId,
  }) {
    return PostAddParameter(
      title: title ?? this.title,
      body: body ?? this.body,
      date: date ?? this.date,
      status: status ?? this.status,
      userId: userId != null ? userId() : this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
      'date': date.millisecondsSinceEpoch,
      'status': status.toMap(),
      'userId': userId,
    };
  }

  factory PostAddParameter.fromMap(Map<String, dynamic> map) {
    return PostAddParameter(
      title: map['title'] ?? '',
      body: map['body'] ?? '',
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      status: PostsStatusEnum.fromMap(map['status']),
      userId: map['userId']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory PostAddParameter.fromJson(String source) =>
      PostAddParameter.fromMap(json.decode(source));
}
