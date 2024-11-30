import 'dart:convert';

import 'package:own_task_01/features/posts/app/app_api.dart';
import 'package:own_task_01/features/posts/app/base_client.dart';
import 'package:http/http.dart' as http;
import 'package:own_task_01/features/posts/data/model/post_model.dart';
import 'package:own_task_01/features/posts/domain/entities/posts_entity.dart';

abstract class PostRemoteDataSource {
  Future<PostModel> createPost(PostModel postModel);
  Future<List<PostModel>> getPostsByUserId(int userId);
}
class PostRemoteDataSourceImpl extends PostRemoteDataSource {
  final http.Client client;

  PostRemoteDataSourceImpl({required this.client});

  @override
  Future<PostModel> createPost(PostModel postModel) async{
    // PostModel payload = PostModel(id: 0, userId: userId, title: title, body: body);
     final result =  await client.post(Uri.parse("$postApi${postModel.userId}"),body: jsonEncode(postModel.toJson()));
     print("result${result.statusCode}");
    var responseJson = utf8.decode(result.bodyBytes);
     print("result${responseJson.toString()}");
     final jsonData = json.decode(responseJson.toString());
     jsonData['title'] = postModel.title;
     jsonData['body'] = postModel.body;
     if(result.statusCode == 201) {
       return PostModel.fromJson(jsonData);
     }
     else {
       throw Exception('Failed to create post');
     }

  }

  @override
  Future<List<PostModel>> getPostsByUserId(int userId) async{
    final result =  await client.get(Uri.parse("$postApi$userId"),);
    print("result${result.statusCode}");
    var responseJson = utf8.decode(result.bodyBytes);
    print("result${responseJson.toString()}");
    List jsonData = json.decode(responseJson.toString()) ??[];
    List<PostModel> posts = [];
    if(result.statusCode == 200) {
      posts = jsonData.map((e)=>PostModel.fromJson(e)).toList();
      return posts;
    }
    else {
      throw Exception('Failed to create post');
    }
  }
}