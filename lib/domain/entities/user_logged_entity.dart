import 'dart:convert';

import 'package:todo_list/core/core.dart';

import 'user_entity.dart';

class UserLoggedEntity extends UserEntity {
  final String token;
  UserLoggedEntity({
    required this.token,
    required super.id,
    required super.name,
    required super.image,
  });

  @override
  Output<UserLoggedEntity> validate() {
    if (token.isEmpty) {
      return failure(ValidationException(message: 'Token invalido'));
    }
    return super.validate().map((_) => this);
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': super.id,
      'name': super.name,
      'image': super.image,
      'token': token,
    };
  }

  factory UserLoggedEntity.fromMap(Map<String, dynamic> map) {
    return UserLoggedEntity(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      token: map['token'] ?? '',
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory UserLoggedEntity.fromJson(String source) =>
      UserLoggedEntity.fromMap(json.decode(source));
}
