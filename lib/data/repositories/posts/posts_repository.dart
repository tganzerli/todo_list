import 'package:todo_list/core/core.dart';
import 'package:todo_list/domain/entities/posts_entity.dart';
import 'package:todo_list/domain/parameters/post_add_parameter.dart';
import 'package:todo_list/domain/parameters/post_edit_parameter.dart';

abstract interface class PostsRepository {
  AsyncOutput<List<PostsEntity>> getPosts();
  AsyncOutput<PostsEntity> addPost(PostAddParameter param);
  AsyncOutput<PostsEntity> editPost(PostEditParameter param);
  Stream<List<PostsEntity>> postsObserver();

  void dispose();
}
