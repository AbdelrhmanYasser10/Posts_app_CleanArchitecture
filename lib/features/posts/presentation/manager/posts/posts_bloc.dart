import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:posts_app/core/error/failures.dart';
import 'package:posts_app/core/strings/app_strings.dart';

import '../../../domain/entities/posts.dart';
import '../../../domain/use_cases/get_all_posts.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPosts getAllPosts;
  PostsBloc({required this.getAllPosts}) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent) {
        emit(LoadingPostsState());
        final posts = await getAllPosts.execute();
        emit(_mapFailureOrPostsToState(posts));
      } else if (event is RefreshPostsEvent) {
        final posts = await getAllPosts.execute();
        emit(_mapFailureOrPostsToState(posts));
      }
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error, Please try again later';
    }
  }

  PostsState _mapFailureOrPostsToState(Either<Failure, List<Post>> either) {
    return either.fold(
      (failure) {
        return ErrorPostsState(message: _mapFailureToMessage(failure));
      },
      (posts) {
        return LoadedPostsState(posts: posts);
      },
    );
  }
}
