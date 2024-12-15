import '../datasource/data_source_post.dart';
import '../models/post.dart';

class PostServiecesData implements DataSourcePost {
  final List<Post> _posts = [
    Post(id: '1', title: 'Post 1', description: 'Description 1'),
    Post(id: '2', title: 'Post 2', description: 'Description 2'),
    Post(id: '3', title: 'Post 3', description: 'Description 3'),
  ];

  @override
  Future<List<Post>> getAllPosts() async {
    await Future.delayed(const Duration(seconds: 1));
    return _posts;
  }

  @override
  Future<Post> createPost(Post post) async {
    await Future.delayed(const Duration(seconds: 1));
    _posts.add(post);
    return post;
  }

  @override
  Future<Post> updatePost(Post post) async {
    await Future.delayed(const Duration(seconds: 1));
    int index = _posts.indexWhere((p) => p.id == post.id);
    if (index != -1) _posts[index] = post;
    return post;
  }

  @override
  Future<void> deletePost(String postId) async {
    await Future.delayed(const Duration(seconds: 1));
    _posts.removeWhere((post) => post.id == postId);
  }
}
