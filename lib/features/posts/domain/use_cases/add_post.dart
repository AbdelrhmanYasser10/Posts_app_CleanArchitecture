import 'package:dartz/dartz.dart';
import 'package:posts_app/core/error/failures.dart';
import 'package:posts_app/features/posts/domain/entities/posts.dart';
import 'package:posts_app/features/posts/domain/repositories/posts_repository.dart';

class AddPost{
  PostsRepository repository;
  AddPost(this.repository);

  Future<Either<Failure,Unit>> execute(Post post)async{
    return repository.addPost(post);
  }
}