import 'package:dartz/dartz.dart';
import 'package:posts_app/features/posts/domain/repositories/posts_repository.dart';

import '../../../../core/error/failures.dart';
import '../entities/posts.dart';

class GetAllPosts{
  final PostsRepository repository;
  GetAllPosts(this.repository);

  Future<Either<Failure,List<Post>>> execute() async{
    return await repository.getAllPosts();
  }
}