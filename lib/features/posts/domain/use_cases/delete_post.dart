import 'package:dartz/dartz.dart';
import 'package:posts_app/core/error/failures.dart';
import 'package:posts_app/features/posts/domain/repositories/posts_repository.dart';

class DeletePost{
  PostsRepository repository;
  DeletePost(this.repository);

  Future<Either<Failure,Unit>> execute(int id) async{
    return repository.deletePost(id);
  }
}