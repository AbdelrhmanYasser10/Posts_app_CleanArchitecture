import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:posts_app/core/error/exception.dart';
import 'package:posts_app/features/posts/data/models/post_model.dart';

abstract class PostsRemoteDataSource {

  Future<List<PostModel>> getAllPosts();
  Future<Unit> deletePost(int id);
  Future<Unit> addPost(PostModel post);
  Future<Unit> updatePost(PostModel post);

}


class PostRemoteImpWithDio implements PostsRemoteDataSource{

  final Dio dio;
  PostRemoteImpWithDio({required this.dio});

  @override
  Future<List<PostModel>> getAllPosts() async{
    final response = await dio.get("posts");
    if(response.statusCode == 200){
      final List decodedJson = json.decode(response.data) as List;
      final List<PostModel> postModels = decodedJson.map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel)).toList();
      return postModels;
    }
    else{
      throw ServerException();
    }
  }


  @override
  Future<Unit> addPost(PostModel post) async{
    final body = {
      'title':post.title,
      'body':post.body,
    };
    final response = await dio.post('posts',data: body);
    if(response.statusCode == 201){
      return Future.value(unit);
    }
    else{
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int id) async{
    final response = await dio.delete('posts/$id');
    if(response.statusCode == 200){
      return Future.value(unit);
    }
    else{
      throw ServerException();
    }
  }


  @override
  Future<Unit> updatePost(PostModel post) async{
    final postId = post.id.toString();
    final body = {
      'title':post.title,
      'body':post.body,
    };
    final response = await dio.patch('posts/$postId',data: body);
    if(response.statusCode == 200){
      return Future.value(unit);
    }
    else{
      throw ServerException();
    }
  }

}