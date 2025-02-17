import 'package:todo_list/core/core.dart';
import 'package:todo_list/data/repositories/auth/auth_repository.dart';
import 'package:todo_list/domain/entities/user_logged_entity.dart';

class StartViewModel extends ViewModel<UnitViewState> {
  final AuthRepository authRepository;

  late final Command0<Unit> authEvent;

  StartViewModel({required this.authRepository}) : super(UnitViewState()) {
    authEvent = Command0(_authEvent);
  }

  late UserLoggedEntity _userLogged;

  UserLoggedEntity get userLogged => _userLogged;

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
}
