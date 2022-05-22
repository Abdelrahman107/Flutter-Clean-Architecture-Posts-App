import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:posts_app/features/posts/presentation/pages/posts_add_update_page.dart';
import 'package:posts_app/features/posts/presentation/widgets/posts_page/loading_widget.dart';
import 'package:posts_app/features/posts/presentation/widgets/posts_page/message_display_widget.dart';
import 'package:posts_app/features/posts/presentation/widgets/posts_page/posts_list_widget.dart';

class PostsHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
        floatingActionButton: _buildFloatingBtn(context));
  }
}

Future<void> _onRefresh(BuildContext context) async {
  BlocProvider.of<PostsBloc>(context).add(RefreshPostsEvent());
}

Widget _buildFloatingBtn(context) {
  return FloatingActionButton(
    onPressed: () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => AddUpdatePostsPage(
            post: null,
            isUpdate: false,
          ),
        ),
      );
    },
    child: Icon(Icons.add),
  );
}

AppBar _buildAppBar() {
  return AppBar(
    title: Text('Posts'),
  );
}

Widget _buildBody() {
  return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state is PostsLoading)
            return LoadingWidget();
          else if (state is PostsLoaded) {
            return RefreshIndicator(
              onRefresh: () => _onRefresh(context),
              child: PostListWidget(
                posts: state.posts,
              ),
            );
          } else if (state is PostsError) {
            return MessageDisplayWidget(
              message: state.message,
            );
          } else
            return LoadingWidget();
        },
      ));
}
