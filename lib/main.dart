import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/features/posts/presentation/manager/add_delete_update/add_delete_update_post_bloc.dart';
import 'package:posts_app/features/posts/presentation/manager/posts/posts_bloc.dart';
import 'core/theme/app_theme.dart';
import 'features/posts/presentation/pages/posts_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.sl<PostsBloc>()..add(GetAllPostsEvent()),
        ),
        BlocProvider(
          create: (_) => di.sl<AddDeleteUpdatePostBloc>(),
        )
      ],
      child: MaterialApp(
        title: 'Posts app',
        theme: appTheme,
        home: const PostsPage(),
      ),
    );
  }
}
