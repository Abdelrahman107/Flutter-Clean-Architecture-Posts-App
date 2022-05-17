import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:posts_app/core/errors/failures.dart';

import 'package:posts_app/features/posts/domain/entities/post_entity.dart';
import 'package:posts_app/features/posts/domain/usecases/get_all_posts_usecase.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUseCase getAllPostsUseCase;

  PostsBloc({required this.getAllPostsUseCase}) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent || event is RefreshPostsEvent) {
        emit(PostsLoading());
        final response = await getAllPostsUseCase.call();
        response.fold(
          (failure) => emit(PostsError(
              message: failure.runtimeType == ServerFailure
                  ? "Server Failure"
                  : failure.runtimeType == CacheFailure
                      ? "Empty Cache Failure"
                      : failure.runtimeType == NoInternetFailure
                          ? "No Internet Failure"
                          : "Unexpected Error, Please Try Again")),
          (posts) => emit(PostsLoaded(posts: posts)),
        );
      }
    });
  }
}
