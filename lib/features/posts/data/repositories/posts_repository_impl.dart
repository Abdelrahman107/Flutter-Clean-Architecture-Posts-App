import 'package:posts_app/features/posts/data/datasources/posts_local_data_source.dart';
import 'package:posts_app/features/posts/data/datasources/posts_remote_data_source.dart';
import 'package:posts_app/features/posts/domain/entities/post_entity.dart';
import 'package:posts_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:posts_app/features/posts/domain/repositories/posts_repository.dart';

class PostsRepositoryImpl implements PostsRepository {
  final PostsLocalDataSource localDataSource;
  final PostsRemoteDataSource remoteDataSource;

  PostsRepositoryImpl(this.localDataSource, this.remoteDataSource);

  @override
  Future<Either<Failure, List<PostEntity>>> getPosts() async {
    await remoteDataSource.getAllPosts();
    await localDataSource.getCachedPosts();
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> addPost(PostEntity post) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int id) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> updatePost(PostEntity post) {
    throw UnimplementedError();
  }
}
