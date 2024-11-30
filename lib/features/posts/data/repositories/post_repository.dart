
import 'package:own_task_01/features/posts/data/datasources/post_local_data_source.dart';
import 'package:own_task_01/features/posts/data/datasources/post_remote_data_source.dart';
import 'package:own_task_01/features/posts/data/model/post_model.dart';
import 'package:own_task_01/features/posts/domain/entities/posts_entity.dart';
import 'package:own_task_01/features/posts/helper/utility/utility.dart';

abstract class PostRepository {
  Future<Post> createPost(String title, String body,int userId);
  Future<List<Post>> getPostsByUserId(int userId);
}

class PostRepositoryImpl extends PostRepository {
  final PostRemoteDataSource remoteDataSource;
  final PostLocalDataSource localDataSource;
  PostRepositoryImpl({required this.remoteDataSource,required this.localDataSource});
  @override
  Future<Post> createPost(String title, String body, int userId) async {
    print("modleval${title}");
    PostModel postModel =  PostModel(id: 0, title: title, body:body,userId: userId);
    if(!await Utility.isInternet()) {
      /// save data to local
      int postId = await localDataSource.insertPost(postModel);
      print("createdId in local : $postId");
      print("added-data${(await localDataSource.getAllPosts()).last.toJson()}");
      postModel = PostModel(id: postId, title: title, body: body,userId: userId);
      // postModel.title = title;
      // postModel.body = body;
    }
    else {
       postModel = await remoteDataSource.createPost(postModel);
    }
    return Post(id: postModel.id, title: postModel.title, body: postModel.body, userId: userId) ;
  }

  @override
  Future<List<Post>> getPostsByUserId(int userId) async{
    List<PostModel> postModel = await remoteDataSource.getPostsByUserId(userId);
    return postModel.map((e)=>Post(userId:userId , id: e.id, body: e.body, title: e.title)).toList();
  }

}