import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:posts_app/core/errors/failures.dart';
import 'package:posts_app/core/utils/constants.dart';
import 'package:posts_app/features/posts/domain/entities/post_entity.dart';
import 'package:posts_app/features/posts/domain/usecases/add_post_usecase.dart';
import 'package:posts_app/features/posts/domain/usecases/delete_post_usecase.dart';
import 'package:posts_app/features/posts/domain/usecases/update_post_usecase.dart';
import 'package:dartz/dartz.dart';
part 'add_update_delete_post_event.dart';
part 'add_update_delete_post_state.dart';

class AddUpdateDeletePostBloc
    extends Bloc<AddUpdateDeletePostEvent, AddUpdateDeletePostState> {
  final AddPostUseCase addPostUseCase;
  final UpdatePostUseCase updatePostUseCase;
  final DeletePostUseCase deletePostUseCase;

  AddUpdateDeletePostBloc(
      {required this.addPostUseCase,
      required this.updatePostUseCase,
      required this.deletePostUseCase})
      : super(AddUpdateDeletePostInitial()) {
    on<AddUpdateDeletePostEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(AddUpdatePostLoading());
        final FailureOrUnit = await addPostUseCase(event.post);
        FailureOrUnit.fold(
          (failure) => emit(AddUpdatePostError(
              message: failure.runtimeType == ServerFailure
                  ? "Server Failure"
                  : failure.runtimeType == CacheFailure
                      ? "Empty Cache Failure"
                      : failure.runtimeType == NoInternetFailure
                          ? "No Internet Failure"
                          : "Unexpected Error, Please Try Again")),
          (unit) =>
              emit(AddUpdatePostMessage(message: Constants.SUCCESS_ADD_ACTION)),
        );
      } else if (event is UpdatePostEvent) {
        emit(AddUpdatePostLoading());
        final FailureOrUnit = await updatePostUseCase(event.post);
        FailureOrUnit.fold(
          (failure) => emit(AddUpdatePostError(
              message: failure.runtimeType == ServerFailure
                  ? "Server Failure"
                  : failure.runtimeType == CacheFailure
                      ? "Empty Cache Failure"
                      : failure.runtimeType == NoInternetFailure
                          ? "No Internet Failure"
                          : "Unexpected Error, Please Try Again")),
          (_) => emit(
              AddUpdatePostMessage(message: Constants.SUCCESS_UPDATE_ACTION)),
        );
      } else if (event is DeletePostEvent) {
        emit(AddUpdatePostLoading());
        final FailureOrUnit = await deletePostUseCase(event.postId);
        FailureOrUnit.fold(
          (failure) => emit(AddUpdatePostError(
              message: failure.runtimeType == ServerFailure
                  ? "Server Failure"
                  : failure.runtimeType == CacheFailure
                      ? "Empty Cache Failure"
                      : failure.runtimeType == NoInternetFailure
                          ? "No Internet Failure"
                          : "Unexpected Error, Please Try Again")),
          (unit) => emit(
              AddUpdatePostMessage(message: Constants.SUCCESS_DELETE_ACTION)),
        );
      }
    });
  }
}
