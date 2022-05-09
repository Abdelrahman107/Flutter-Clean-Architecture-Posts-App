import 'package:dartz/dartz.dart';
import 'package:posts_app/core/errors/failures.dart';
import 'package:posts_app/features/posts/domain/entities/post_entity.dart';
import 'package:posts_app/features/posts/domain/repositories/posts_repository.dart';

class GetAllPostsUseCase {
  final PostsRepository repository;
  GetAllPostsUseCase(this.repository);

  Future<Either<Failure, List<PostEntity>>> call() async {
    return await repository.getPosts();
  }
}
