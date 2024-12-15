import '../models/post.dart';

abstract class DataSourcePost {
  Future<Post> updatePost(Post post);
  Future<Post> createPost(Post post);
  Future<List<Post>> getAllPosts();
  Future<void> deletePost(String postId);
}
