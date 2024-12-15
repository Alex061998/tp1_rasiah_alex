import '../../models/post.dart';
import '../datasource/data_source_post.dart';

class PostsRepository {
  final DataSourcePost dataSource;

  PostsRepository(this.dataSource);

  Future<List<Post>> fetchPosts() => dataSource.getAllPosts();

  Future<Post> addPost(Post post) => dataSource.createPost(post);

  Future<Post> editPost(Post post) => dataSource.updatePost(post);

  Future<void> deletePost(String postId) async {
    await dataSource.deletePost(postId);
  }
}
