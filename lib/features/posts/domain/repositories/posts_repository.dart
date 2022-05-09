import 'package:dartz/dartz.dart';
import 'package:posts_app/core/errors/failures.dart';
import 'package:posts_app/features/posts/domain/entities/post_entity.dart';

abstract class PostsRepository {
  Future<Either<Failure, List<PostEntity>>> getPosts();
  Future<Either<Failure, Unit>> deletePost(int id);
  Future<Either<Failure, Unit>> addPost(PostEntity post);
  Future<Either<Failure, Unit>> updatePost(PostEntity post);
}
