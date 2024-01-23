import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:posts_app/core/error/exception.dart';
import 'package:posts_app/features/posts/data/models/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PostLocalDataSource{

  Future<List<PostModel>> getCachedPosts();
  Future<Unit> cachePosts(List<PostModel> posts);

}

const CACHED_POSTS = 'CACHED POSTS';

class PostLocalDataSourceImpWithSharedPreferences implements PostLocalDataSource{

  final SharedPreferences sharedPreferences;
  PostLocalDataSourceImpWithSharedPreferences({required this.sharedPreferences});

  @override
  Future<Unit> cachePosts(List<PostModel> posts) {
    List postModelsToJson = posts.map<Map<String,dynamic>>((postModel) => postModel.toJson()).toList();
    sharedPreferences.setString(CACHED_POSTS, json.encode(postModelsToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    final jsonString = sharedPreferences.getString(CACHED_POSTS);
    if(jsonString != null){
      List decodedJsonData = json.decode(jsonString);
      List<PostModel> json2PostModels = decodedJsonData.map<PostModel>((post) =>PostModel.fromJson(post)).toList();
      return Future.value(json2PostModels);
    }
    else{
      throw EmptyCacheException();
    }
  }

}