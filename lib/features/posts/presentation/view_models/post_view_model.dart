import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:own_task_01/features/posts/data/datasources/post_local_data_source.dart';
import 'package:own_task_01/features/posts/data/datasources/post_remote_data_source.dart';
import 'package:own_task_01/features/posts/data/repositories/post_repository.dart';
import 'package:own_task_01/features/posts/di/injenction.dart';
import 'package:own_task_01/features/posts/domain/entities/posts_entity.dart';
import 'package:own_task_01/features/posts/domain/usecases/posts_usecase.dart';
import 'package:http/http.dart' as http;

// class PostViewModel  {
//   final PostUseCase useCase;
//   PostViewModel({required this.useCase});
//
//
//   Future<Post> createPost(String title, String body) async{
//     return useCase.createPost(title, body, 1);
//   }
//   Future<List<Post>> getPostsByUserId() async{
//     return useCase.getPostsByUserId(1);
//   }
// }

// Providers
final remoteAPIServiceProvider = Provider<PostRemoteDataSource>((ref) => PostRemoteDataSourceImpl(client: http.Client()));
final localAPIServiceProvider = Provider<PostLocalDataSource>((ref) => PostLocalDataSource());
final postRepositoryProvider = Provider<PostRepository>((ref) => PostRepositoryImpl(remoteDataSource: ref.read(remoteAPIServiceProvider),localDataSource: ref.read(localAPIServiceProvider)));
final getPostsProvider = Provider<PostUseCase>((ref) => PostUseCase(repository: ref.read(postRepositoryProvider)));

// State Notifier for Posts (GET request)
final postsStateProvider = FutureProvider<List<Post>>((ref) {
  final getPosts = ref.read(getPostsProvider);
  return getPosts.getPostsByUserId(1);
});
// State Notifier for Create Posts (POST request)
final createPostStateProvider = StateNotifierProvider<CreatePostModel, AsyncValue<Post>>((ref) {
  final createPost = ref.read(getPostsProvider);
  return CreatePostModel(createPost);
});


// class PostsViewModel extends StateNotifier<AsyncValue<List<Post>>> {
//   final PostUseCase useCase;
//
//   PostsViewModel(this.useCase) : super(const AsyncValue.loading());
//
//   Future<void> fetchPosts() async {
//     try {
//       final posts = await useCase.getPostsByUserId(1);
//       print("returnedposts${posts.length}");
//       state = AsyncValue.data(posts);
//     } catch (e,s) {
//       state = AsyncValue.error(e,s);
//     }
//   }
// }
class CreatePostModel extends StateNotifier<AsyncValue<Post>> {
  final PostUseCase useCase;

  CreatePostModel(this.useCase) : super(const AsyncValue.loading());

  Future<void> createPosts(String title,String body) async {
    try {
      final posts = await useCase.createPost(title,body,1);
      print("created-post${posts.body}");
      state = AsyncValue.data(posts);
    } catch (e,s) {
      state = AsyncValue.error(e,s);
    }
  }
}