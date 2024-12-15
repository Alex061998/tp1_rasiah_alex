import '../models/post.dart';

abstract class PostEvent {}

class LoadPostsEvent extends PostEvent {}

class CreatePostEvent extends PostEvent {
  final Post post;
  CreatePostEvent(this.post);
}

class UpdatePostEvent extends PostEvent {
  final Post post;
  UpdatePostEvent(this.post);
}

class DeletePostEvent extends PostEvent {
  final String postId;
  DeletePostEvent({required this.postId});
}
