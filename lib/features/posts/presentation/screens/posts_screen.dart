import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:own_task_01/features/posts/data/model/post_model.dart';
import 'package:own_task_01/features/posts/domain/entities/posts_entity.dart';
import 'package:own_task_01/features/posts/domain/usecases/posts_usecase.dart';
import 'package:own_task_01/features/posts/presentation/view_models/post_view_model.dart';

class PostsScreen extends ConsumerWidget {
  // final PostViewModel postViewModel;

   PostsScreen({super.key});
//
//   @override
//   State<PostsScreen> createState() => _PostsScreenState();
// }
//
// class _PostsScreenState extends State<PostsScreen> {

  TextEditingController _titleController =  TextEditingController();
  TextEditingController _bodyController =  TextEditingController();

  bool progress = false;
  // List<Post> posts = [];
  //  getPosts() async{
  //    progress =true;
  //    setState(() {
  //
  //    });
  //   try {
  //     posts = await widget.postViewModel.getPostsByUserId();
  //     print("data${posts.length}");
  //   } catch (e) {
  //     debugPrint("error${e.toString()}");
  //   }
  //   finally{
  //     progress =false;
  //     setState(() {});
  //   }
  // }
  // Future<void> _createPost() async {
  //   loading = true;
  //   final title = _titleController.text;
  //   final body = _bodyController.text;
  //   print("inp$title");
  //   print("inp$body");
  //  setState(() {});
  //   try {
  //     final Post post = await widget.postViewModel.createPost(title, body);
  //     print("data${post.title}");
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Post created with ID: ${post.id}')),
  //     );
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Failed to create post error - ${e.toString()}')),
  //     );
  //   }
  //   finally{
  //     loading = false;
  //     setState(() {});
  //   }
  // }

  // @override
  // void initState() {
  //   // getPosts();
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final postsAsyncValue = ref.watch(postsStateProvider);
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text("Create Post"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(controller: _titleController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Title',
                  hintText: 'Enter title here',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(controller: _bodyController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Content',
                  hintText: 'Enter content here',
                ),
              ),
            ),
            SizedBox(height: 20,),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
               ElevatedButton(
                    onPressed: () async{
                      ref.read(createPostStateProvider.notifier).createPosts(_titleController.text, _bodyController.text);
                      _titleController.clear();
                      _bodyController.clear();
                    // await _createPost();
                }, child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 10),
                  child: Text("Save",style: TextStyle(fontSize: 20),),
                )),
              ],
            ),
            SizedBox(height: 20,),
            // Text("Available posts",style: TextStyle(fontSize: 21,fontWeight: FontWeight.w500),),
            SizedBox(height: 10,),
            Expanded(child:
                postsAsyncValue.when(data: (posts)=>ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context,index) {
                      final post = posts[index];
                      return Card(
                        child: ListTile(
                          title: Text(post.id.toString(),style: TextStyle(fontSize: 14),),
                          subtitle: Text(post.title,style: TextStyle(fontSize: 13),),
                        ),
                      );
                    }), loading: () => Center(child: const CircularProgressIndicator()),
                  error: (error, stack) => Text('Error: $error'),)
            )

          ],
        ),
      ),
    ));
  }
}

