part of 'add_update_delete_post_bloc.dart';

abstract class AddUpdateDeletePostState extends Equatable {
  const AddUpdateDeletePostState();

  @override
  List<Object> get props => [];
}

class AddUpdateDeletePostInitial extends AddUpdateDeletePostState {}

class PostLoading extends AddUpdateDeletePostState {}

class PostLoaded extends AddUpdateDeletePostState {
  final String message;
  const PostLoaded({required this.message});
}

class PostError extends AddUpdateDeletePostState {
  final String message;
  const PostError({required this.message});
}
