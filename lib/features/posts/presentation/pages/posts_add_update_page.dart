import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/core/utils/snack_bar_messages.dart';

import 'package:posts_app/features/posts/domain/entities/post_entity.dart';
import 'package:posts_app/features/posts/presentation/bloc/posts_add_delete_update/add_update_delete_post_bloc.dart';
import 'package:posts_app/features/posts/presentation/pages/posts_homepage.dart';
import 'package:posts_app/features/posts/presentation/widgets/add_update_posts_page/form_widget.dart';
import 'package:posts_app/features/posts/presentation/widgets/posts_page/loading_widget.dart';

class AddUpdatePostsPage extends StatelessWidget {
  final PostEntity? post;
  final bool isUpdate;
  const AddUpdatePostsPage({
    Key? key,
    this.post,
    required this.isUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(isUpdate ? 'Edit Post' : 'Add Post'),
    );
  }

  Widget _buildBody(context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocConsumer<AddUpdateDeletePostBloc, AddUpdateDeletePostState>(
          listener: (context, state) {
            if (state is AddUpdatePostMessage) {
              SnackBarMessage().showSuccessSnackBar(
                  message: state.message, context: context);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => PostsHomePage()),
                  (route) => false);
            } else if (state is AddUpdatePostError) {
              SnackBarMessage()
                  .showErrorSnackBar(message: state.message, context: context);
            }
          },
          builder: (context, state) {
            if (state is AddUpdatePostLoading) return LoadingWidget();
            return FormWidget(
              post: isUpdate ? post : null,
              isUpdatePost: isUpdate,
            );
          },
        ),
      ),
    );
  }
}
