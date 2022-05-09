import 'package:dartz/dartz.dart';
import 'package:posts_app/features/posts/domain/entities/post_entity.dart';

abstract class PostsRemoteDataSource {
  Future<List<PostEntity>> getAllPosts();
  Future<Unit> addPost(PostEntity post);
  Future<Unit> deletePost(int id);
  Future<Unit> updatePost(PostEntity post);
}

class PostsRemoteDataSourceImpl implements PostsRemoteDataSource {
  @override
  Future<Unit> addPost(PostEntity post) {
    // TODO: implement addPost
    throw UnimplementedError();
  }

  @override
  Future<Unit> deletePost(int id) {
    // TODO: implement deletePost
    throw UnimplementedError();
  }

  @override
  Future<List<PostEntity>> getAllPosts() {
    // TODO: implement getAllPosts
    throw UnimplementedError();
  }

  @override
  Future<Unit> updatePost(PostEntity post) {
    // TODO: implement updatePost
    throw UnimplementedError();
  }
}
