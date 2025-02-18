import 'package:todo_list/core/core.dart';
import 'package:todo_list/data/repositories/auth/auth_repository.dart';
import 'package:todo_list/domain/entities/user_logged_entity.dart';

class StartViewModel extends ViewModel<UnitViewState> {
  final Cache cache;
  final AuthRepository authRepository;

  late final Command0<Unit> cleanCacheEvent;
  late final Command0<Unit> authEvent;
  late final Command1<String, String> routeEvent;

  StartViewModel({required this.authRepository, required this.cache})
      : super(UnitViewState()) {
    cleanCacheEvent = Command0(_cleanCacheEvent);
    authEvent = Command0(_authEvent);
    routeEvent = Command1(_routeEvent);
  }

  late UserLoggedEntity _userLogged;

  UserLoggedEntity get userLogged => _userLogged;

  AsyncOutput<Unit> _cleanCacheEvent() async {
    await cache.clearAll();

    return success(unit);
  }

  AsyncOutput<Unit> _authEvent() async {
    await Future.delayed(Duration(seconds: 2));
    return await authRepository.getUser().fold(
      (exception) async {
        return authRepository //
            .login()
            .flatMap((user) {
          _userLogged = user;
          return success(unit);
        });
      },
      (user) {
        _userLogged = user;
        return success(unit);
      },
    );
  }

  AsyncOutput<String> _routeEvent(String route) async {
    return success(route);
  }
}
