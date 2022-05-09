import 'package:dartz/dartz.dart';
import 'package:posts_app/core/errors/failures.dart';
import 'package:posts_app/features/posts/domain/repositories/posts_repository.dart';

class DeletePostUseCase {
  final PostsRepository postsRepository;
  DeletePostUseCase(this.postsRepository);

  Future<Either<Failure, Unit>> call(int id) async {
    return await postsRepository.deletePost(id);
  }
}
