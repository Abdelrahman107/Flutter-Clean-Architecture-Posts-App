import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:posts_app/core/errors/exceptions.dart';
import 'package:posts_app/core/utils/constants.dart';
import 'package:http/http.dart' as http;

import 'package:posts_app/features/posts/data/models/post_model.dart';
import 'package:posts_app/features/posts/domain/entities/post_entity.dart';

abstract class PostsRemoteDataSource {
  Future<List<PostModel>> getAllPosts();
  Future<Unit> addPost(PostModel post);
  Future<Unit> deletePost(int id);
  Future<Unit> updatePost(PostModel post);
}

class PostsRemoteDataSourceImpl implements PostsRemoteDataSource {
  final http.Client client;
  PostsRemoteDataSourceImpl({
    required this.client,
  });

  @override
  Future<List<PostModel>> getAllPosts() async {
    final response =
        await client.get(Uri.parse(Constants.kBaseApiUrl + '/posts'), headers: {
      "Content-Type": "application/json",
    });

    if (response.statusCode == 200) {
      final decodedJson = jsonDecode(response.body) as List;
      final posts = decodedJson
          .map<PostModel>((post) => PostModel.fromJson(post))
          .toList();
      return posts;
    }

    throw ServerException();
  }

  Future<Unit> addPost(PostModel post) async {
    final postToAdd = {
      "title": post.title,
      "body": post.body,
      "id": post.id,
    };
    final response = await client.post(
        Uri.parse(Constants.kBaseApiUrl + '/posts'),
        body: postToAdd,
        headers: {
          "Content-Type": "application/json",
        });

    if (response.statusCode == 201) {
      return Future.value(unit);
    }

    throw ServerException();
  }

  @override
  Future<Unit> deletePost(int id) async {
    final response = await client.delete(
        Uri.parse(Constants.kBaseApiUrl + '/posts/${id.toString()}'),
        headers: {
          "Content-Type": "application/json",
        });

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModel post) async {
    final postToUpdate = {
      "title": post.title,
      "body": post.body,
    };
    final response = await client.put(
        Uri.parse(Constants.kBaseApiUrl + '/posts/${post.id.toString()}'),
        body: postToUpdate,
        headers: {
          "Content-Type": "application/json",
        });

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
