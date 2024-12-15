import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp1_rasiah_alex/post_list_screen/post_create_screen.dart';
import 'package:tp1_rasiah_alex/post_list_screen/post_detail_screen.dart';

import '../shared/bloc/post_bloc.dart';
import '../shared/bloc/post_event.dart';
import '../shared/bloc/post_state.dart';

class PostListScreen extends StatelessWidget {
  const PostListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Posts')),
      body: BlocListener<PostBloc, PostState>(
        listener: (context, state) {
          if (state is PostLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Action réalisée avec succès !')),
            );
          } else if (state is PostError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Erreur : ${state.error}')),
            );
          }
        },
        child: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            if (state is PostLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is PostLoaded) {
              if (state.posts.isEmpty) {
                return const Center(child: Text('Aucun post disponible.'));
              }
              return ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  final post = state.posts[index];
                  return ListTile(
                    title: Text(post.title),
                    subtitle: Text(post.description),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _onRemoveFromList(context, post.id),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PostDetailScreen(post: post),
                        ),
                      );
                    },
                  );
                },
              );
            } else if (state is PostError) {
              return Center(child: Text(state.error));
            }
            return const Center(child: Text('Aucun post disponible.'));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreatePostPage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _onRemoveFromList(BuildContext context, String postId) {
    final postBloc = BlocProvider.of<PostBloc>(context);
    postBloc.add(DeletePostEvent(postId: postId));
  }
}
