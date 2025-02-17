import 'package:todo_list/core/core.dart';
import 'package:todo_list/domain/entities/user_entity.dart';

class UsersClientMock {
  AsyncOutput<List<UserEntity>> getUser() async {
    return success([
      UserEntity(
          id: 1, name: 'Lucas Oliveira', image: 'assets/avatar/avatar01.png'),
      UserEntity(
          id: 2, name: 'Mariana Souza', image: 'assets/avatar/avatar02.png'),
      UserEntity(
          id: 3, name: 'Felipe Santos', image: 'assets/avatar/avatar03.png'),
      UserEntity(
          id: 4, name: 'Camila Ferreira', image: 'assets/avatar/avatar04.png'),
      UserEntity(
          id: 5, name: 'Gabriel Almeida', image: 'assets/avatar/avatar05.png'),
      UserEntity(
          id: 6, name: 'Ana Beatriz Lima', image: 'assets/avatar/avatar06.png'),
      UserEntity(
          id: 7, name: 'Rafael Costa', image: 'assets/avatar/avatar07.png'),
      UserEntity(
          id: 8, name: 'Juliana Mendes', image: 'assets/avatar/avatar08.png'),
      UserEntity(
          id: 9, name: 'Thiago Rodrigues', image: 'assets/avatar/avatar09.png'),
      UserEntity(
          id: 10, name: 'Isabela Pereira', image: 'assets/avatar/avatar10.png'),
    ]);
  }
}
