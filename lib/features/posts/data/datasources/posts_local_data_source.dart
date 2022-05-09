import 'package:dartz/dartz.dart';
import 'package:posts_app/features/posts/domain/entities/post_entity.dart';

abstract class PostsLocalDataSource {
  Future<List<PostEntity>> getCachedPosts();
  Future<Unit> cachePosts(List<PostEntity> posts);
}

class PostsLocalDataSourceImpl implements PostsLocalDataSource {
  @override
  Future<Unit> cachePosts(List<PostEntity> posts) {
    // TODO: implement cachePosts
    throw UnimplementedError();
  }

  @override
  Future<List<PostEntity>> getCachedPosts() {
    // TODO: implement getCachedPosts
    throw UnimplementedError();
  }
}
