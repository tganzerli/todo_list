import 'package:todo_list/core/core.dart';
import 'package:todo_list/domain/entities/user_logged_entity.dart';

abstract interface class AuthRepository {
  AsyncOutput<UserLoggedEntity> getUser();
  AsyncOutput<UserLoggedEntity> login();
}
