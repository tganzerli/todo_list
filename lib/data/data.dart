import 'package:todo_list/core/config/injector.dart';

import 'datasources/posts/posts_cache.dart';
import 'datasources/posts/posts_client_http.dart';
import 'datasources/users/user_logged_cache.dart';
import 'datasources/users/users_client_mock.dart';
import 'repositories/auth/auth_repository.dart';
import 'repositories/auth/remote_auth_repository.dart';
import 'repositories/posts/posts_repository.dart';
import 'repositories/posts/remote_posts_repository.dart';

void dataInjector() {
  injector.add<PostsCache>(PostsCache.new);
  injector.add<PostsClientHttp>(PostsClientHttp.new);
  injector.add<UserLoggedCache>(UserLoggedCache.new);
  injector.add<UsersClientMock>(UsersClientMock.new);

  injector.add<AuthRepository>(RemoteAuthRepository.new);
  injector.addSingleton<PostsRepository>(RemotePostsRepository.new);
}
