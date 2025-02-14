import 'dart:convert';

import 'package:todo_list/core/core.dart';

class UserEntity extends Entity<int> {
  final String name;
  final String image;
  UserEntity({
    required super.id,
    required this.name,
    required this.image,
  });

  @override
  Output<UserEntity> validate() {
    if (super.id <= 0) {
      return failure(ValidationException(message: 'Id invalido'));
    }
    if (name.isEmpty) {
      return failure(ValidationException(message: 'Usuario sem nome'));
    }
    if (image.isEmpty) {
      return failure(ValidationException(message: 'Não contem imagem'));
    }
    return success(this);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': super.id,
      'name': name,
      'image': image,
    };
  }

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      image: map['image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserEntity.fromJson(String source) =>
      UserEntity.fromMap(json.decode(source));
}
