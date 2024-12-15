
import 'package:bloc/bloc.dart';

import '../repository/post_repository.dart';
import 'post_event.dart';
import 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostsRepository repository;

  PostBloc(this.repository) : super(PostInitial()) {
    on<LoadPostsEvent>((event, emit) async {
      emit(PostLoading());
      try {
        final posts = await repository.fetchPosts();
        emit(PostLoaded(posts));
      } catch (e) {
        emit(PostError(e.toString()));
      }
    });

    on<CreatePostEvent>((event, emit) async {
      emit(PostLoading());
      try {
        await repository.addPost(event.post);
        final posts = await repository.fetchPosts();
        emit(PostLoaded(posts));
      } catch (e) {
        emit(PostError(e.toString()));
      }
    });

    on<UpdatePostEvent>((event, emit) async {
      emit(PostLoading());
      try {
        await repository.editPost(event.post);
        final posts = await repository.fetchPosts();
        emit(PostLoaded(posts));
      } catch (e) {
        emit(PostError(e.toString()));
      }
    });
    on<DeletePostEvent>((event, emit) async {
      emit(PostLoading());
      try {
        await repository.deletePost(event.postId);
        final posts = await repository.fetchPosts();
        emit(PostLoaded(posts));
      } catch (e) {
        emit(PostError(e.toString()));
      }
    });
  }
}
