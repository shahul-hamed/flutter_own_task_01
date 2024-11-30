
import 'package:own_task_01/features/posts/data/model/post_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class PostLocalDataSource {
  // static final PostLocalDataSource _instance = PostLocalDataSource._init();
  static final PostLocalDataSource _instance = PostLocalDataSource._internal();
  factory PostLocalDataSource() => _instance;
  static const _databaseName = "posts.db";
  static const _tableName = "posts";
  static Database? _database;

  // PostLocalDataSource._init();
  PostLocalDataSource._internal();

  Future<Database> get _db async {
    if (_database != null) return _database!;

    final dir = await getApplicationDocumentsDirectory();
    final path = join(dir.path, _databaseName);

    _database = await openDatabase(path, version: 1, onCreate: _createDb);
    return _database!;
  }

  // Create the database table
  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId INTEGER,
        title TEXT,
        body TEXT
      )
    ''');
  }

  // Insert a post
  Future<int> insertPost(PostModel post) async {
    final db = await _db;
    return await db.insert(
      _tableName,
      post.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Get all posts
  Future<List<PostModel>> getAllPosts() async {
    final db = await _db;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);

    return List.generate(maps.length, (i) {
      return PostModel.fromJson(maps[i]);
    });
  }

  // Update a post
  Future<int> updatePost(PostModel post) async {
    final db = await _db;
    return await db.update(
      _tableName,
      post.toJson(),
      where: 'id = ?',
      whereArgs: [post.id],
    );
  }

  // Delete a post
  Future<int> deletePost(int id) async {
    final db = await _db;
    return await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
