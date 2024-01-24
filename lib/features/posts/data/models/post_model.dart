import 'package:posts_app/features/posts/domain/entities/posts.dart';

class PostModel extends Post {
  PostModel({required int? id, required String body, required String title})
      : super(id: id, title: title, body: body);

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(id: json['id'], body: json['body'], title: json['title']);
  }

  Map<String,dynamic> toJson(){
    return {
      'id':id,
      'title':title,
      'body':body,
    };
  }
}

