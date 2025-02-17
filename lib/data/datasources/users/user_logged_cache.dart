import 'dart:developer';

import 'package:todo_list/core/core.dart';
import 'package:todo_list/domain/entities/user_logged_entity.dart';

const String _userLoggedKey = 'userLoggedKey';

class UserLoggedCache {
  final Cache cache;

  UserLoggedCache({required this.cache});

  AsyncOutput<UserLoggedEntity> getUserLogged() async {
    try {
      final Map<String, dynamic> response = await cache.getData(_userLoggedKey);

      return success(UserLoggedEntity.fromMap(response));
    } on BaseException catch (exception) {
      return failure(exception);
    } catch (e) {
      log(e.toString(), name: 'UserLoggedCache - getUserLogged');
      return failure(DefaultException(message: e.toString()));
    }
  }

  AsyncOutput<UserLoggedEntity> saveUserLogged() async {
    try {
      await cache.removeData(_userLoggedKey);
      //Mock UserLogged
      final userLogged = UserLoggedEntity(
          id: 1,
          name: 'Lucas Oliveira',
          image: 'assets/avatar/avatar01.png',
          token: 'jdfnsdjfnskhjdfbasifdbndasfiasj');

      CacheParams params =
          CacheParams(key: _userLoggedKey, value: userLogged.toMap());

      final response = await cache.setData(params: params);
      if (response) {
        return success(userLogged);
      } else {
        return failure(CacheException(message: 'User were not saved'));
      }
    } on BaseException catch (exception) {
      return failure(exception);
    } catch (e) {
      log(e.toString(), name: 'UserLoggedCache - saveUserLogged');
      return failure(DefaultException(message: e.toString()));
    }
  }
}
