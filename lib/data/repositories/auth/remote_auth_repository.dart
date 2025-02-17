import 'package:todo_list/core/core.dart';
import 'package:todo_list/data/datasources/users/user_logged_cache.dart';
import 'package:todo_list/domain/entities/user_logged_entity.dart';

import 'auth_repository.dart';

class RemoteAuthRepository implements AuthRepository {
  final UserLoggedCache userLoggedCache;
  RemoteAuthRepository({
    required this.userLoggedCache,
  });

  @override
  AsyncOutput<UserLoggedEntity> getUser() {
    return userLoggedCache //
        .getUserLogged();
  }

  @override
  AsyncOutput<UserLoggedEntity> login() {
    return userLoggedCache //
        .saveUserLogged();
  }
}
