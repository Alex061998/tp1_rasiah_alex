import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp1_rasiah_alex/post_list_screen/post_list_screen.dart';
import 'package:tp1_rasiah_alex/shared/bloc/post_bloc.dart';
import 'package:tp1_rasiah_alex/shared/bloc/post_event.dart';
import 'package:tp1_rasiah_alex/shared/datasource/post_servieces_data.dart';
import 'package:tp1_rasiah_alex/shared/repository/post_repository.dart';


void main() {
  final postsRepository = PostsRepository(PostServiecesData());

  runApp(MyApp(postsRepository: postsRepository));
}

class MyApp extends StatelessWidget {
  final PostsRepository postsRepository;

  const MyApp({super.key, required this.postsRepository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PostBloc(postsRepository)..add(LoadPostsEvent()),
        ),
      ],
      child: MaterialApp(
        title: 'TP1 Alex',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const PostListScreen(),
      ),
    );
  }
}
