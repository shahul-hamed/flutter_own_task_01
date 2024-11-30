import 'package:own_task_01/features/posts/data/model/post_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('posts.db');
    return _database!;
  }

  // Open the database
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE posts(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            userId INTEGER,
            title TEXT,
            body TEXT
          )
        ''');
      },
    );
  }

  // Insert a post
  Future<int> insertPost(PostModel post) async {
    final db = await instance.database;
    return await db.insert('posts', post.toJson());
  }

  // Get all posts
  Future<List<PostModel>> getPosts() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('posts');

    return List.generate(maps.length, (i) {
      return PostModel.fromJson(maps[i]);
    });
  }

  // Update a post
  Future<int> updatePost(PostModel post) async {
    final db = await instance.database;
    return await db.update(
      'posts',
      post.toJson(),
      where: 'id = ?',
      whereArgs: [post.id],
    );
  }

  // Delete a post
  Future<int> deletePost(int id) async {
    final db = await instance.database;
    return await db.delete(
      'posts',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
