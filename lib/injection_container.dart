import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:posts_app/core/network/network_info.dart';
import 'package:posts_app/features/posts/data/data_sources/post_local_data_source.dart';
import 'package:posts_app/features/posts/data/data_sources/post_remote_data_source.dart';
import 'package:posts_app/features/posts/data/repositories/post_repository_imp.dart';
import 'package:posts_app/features/posts/domain/use_cases/delete_post.dart';
import 'package:posts_app/features/posts/domain/use_cases/get_all_posts.dart';
import 'package:posts_app/features/posts/domain/use_cases/update_post.dart';
import 'package:posts_app/features/posts/presentation/manager/add_delete_update/add_delete_update_post_bloc.dart';
import 'package:posts_app/features/posts/presentation/manager/posts/posts_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/posts/domain/use_cases/add_post.dart';

final sl = GetIt.instance;


Future<void> init() async{
  /// Features : posts


  //BloC

  sl.registerFactory(
          () => PostsBloc(getAllPosts: sl()),
  );

  sl.registerFactory(
        () => AddDeleteUpdatePostBloc(
          addPost: sl(),
          deletePost: sl(),
          updatePost: sl(),
        ),
  );

  //Use Cases

  sl.registerLazySingleton(() => GetAllPosts(sl()));
  sl.registerLazySingleton(() => AddPost(sl()));
  sl.registerLazySingleton(() => DeletePost(sl()));
  sl.registerLazySingleton(() => UpdatePost(sl()));


  //Repository
  sl.registerLazySingleton(() => PostRepositoryImp(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
  ),
  );

  //Data sources
  sl.registerLazySingleton<PostRemoteImpWithDio>(() => PostRemoteImpWithDio(dio: sl()));
  sl.registerLazySingleton<PostLocalDataSourceImpWithSharedPreferences>(() => PostLocalDataSourceImpWithSharedPreferences(sharedPreferences: sl()));
  /// Core
  sl.registerLazySingleton(() => NetworkInfoImpl(sl()));
  /// External
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://jsonplaceholder.typicode.com/",
      contentType: 'Content-Type : application/json'
    ),
  );
  sl.registerLazySingleton(() => dio);
  sl.registerLazySingleton(() => InternetConnectionChecker());
}