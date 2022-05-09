import 'package:flutter/cupertino.dart';
import 'package:posts_app/core/errors/exceptions.dart';
import 'package:posts_app/core/network/network_info.dart';
import 'package:posts_app/features/posts/data/datasources/posts_local_data_source.dart';
import 'package:posts_app/features/posts/data/datasources/posts_remote_data_source.dart';
import 'package:posts_app/features/posts/domain/entities/post_entity.dart';
import 'package:posts_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:posts_app/features/posts/domain/repositories/posts_repository.dart';

class PostsRepositoryImpl implements PostsRepository {
  final PostsLocalDataSource localDataSource;
  final PostsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  PostsRepositoryImpl(
      this.localDataSource, this.remoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, List<PostEntity>>> getPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await remoteDataSource.getAllPosts();
        localDataSource.cachePosts(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await localDataSource.getCachedPosts();
        return Right(localPosts);
      } on EmptyCacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(PostEntity post) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.addPost(post);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NoInternetFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int id) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deletePost(id);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NoInternetFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePost(PostEntity post) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.updatePost(post);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NoInternetFailure());
    }
  }
}
