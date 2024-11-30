
import 'package:own_task_01/features/posts/data/repositories/post_repository.dart';
import 'package:own_task_01/features/posts/domain/entities/posts_entity.dart';

class PostUseCase {
  final PostRepository repository;

  PostUseCase({required this.repository});

  Future<Post> createPost(String title, String body,int userId) async {
    return await repository.createPost(title, body,userId);
  }
  Future<List<Post>> getPostsByUserId(int userId) async {
    return await repository.getPostsByUserId(userId);
  }
}