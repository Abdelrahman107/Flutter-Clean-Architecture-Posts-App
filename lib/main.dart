import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/core/utils/app_theme.dart';
import 'package:posts_app/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:posts_app/features/posts/presentation/bloc/posts_add_delete_update/add_update_delete_post_bloc.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // multi bloc provider with dl
    return MultiBlocProvider(
        providers: [
          BlocProvider<PostsBloc>(
            create: (_) => di.sl<PostsBloc>(),
          ),
          BlocProvider<AddUpdateDeletePostBloc>(
            create: (_) => di.sl<AddUpdateDeletePostBloc>(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: appTheme,
          title: 'Posts App',
          home: Scaffold(
            appBar: AppBar(
              title: Text('Posts'),
            ),
            body: Center(
              child: Container(
                child: Text('Hello World'),
              ),
            ),
          ),
        ));
  }
}
