import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:posts_app/core/errors/exceptions.dart';
import 'package:posts_app/features/posts/data/models/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:posts_app/core/utils/constants.dart';
import 'package:posts_app/features/posts/domain/entities/post_entity.dart';

abstract class PostsLocalDataSource {
  Future<List<PostModel>> getCachedPosts();
  Future<Unit> cachePosts(List<PostModel> posts);
}

class PostsLocalDataSourceImpl implements PostsLocalDataSource {
  final SharedPreferences sharedPreferences;
  PostsLocalDataSourceImpl({
    required this.sharedPreferences,
  });

  @override
  Future<Unit> cachePosts(List<PostModel> posts) {
    // save posts to shared preferences
    final postsJson =
        posts.map<Map<String, dynamic>>((post) => post.toJson()).toList();
    sharedPreferences.setString(Constants.kPostsKey, json.encode(postsJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    // get posts from shared preferences
    final jsonString = sharedPreferences.getString(Constants.kPostsKey);
    if (jsonString == null) {
      final decodedPosts = json.decode(jsonString!);
      final posts = decodedPosts
          .map<PostModel>((post) => PostModel.fromJson(post))
          .toList();
      return Future.value(posts);
    } else {
      throw EmptyCacheException();
    }
  }
}
