part of 'add_update_delete_post_bloc.dart';

abstract class AddUpdateDeletePostState extends Equatable {
  const AddUpdateDeletePostState();

  @override
  List<Object> get props => [];
}

class AddUpdateDeletePostInitial extends AddUpdateDeletePostState {}

class AddUpdatePostLoading extends AddUpdateDeletePostState {}

class AddUpdatePostMessage extends AddUpdateDeletePostState {
  final String message;
  AddUpdatePostMessage({
    required this.message,
  });
}

class AddUpdatePostError extends AddUpdateDeletePostState {
  final String message;
  const AddUpdatePostError({required this.message});
}
