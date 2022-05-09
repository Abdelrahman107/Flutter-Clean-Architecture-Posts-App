import 'package:dartz/dartz.dart';
import 'package:posts_app/core/errors/failures.dart';
import 'package:posts_app/features/posts/domain/entities/post_entity.dart';
import 'package:posts_app/features/posts/domain/repositories/posts_repository.dart';

class AddPostUseCase {
  final PostsRepository postsRepository;
  AddPostUseCase(this.postsRepository);

  Future<Either<Failure, Unit>> call(PostEntity post) async {
    return await postsRepository.addPost(post);
  }
}
