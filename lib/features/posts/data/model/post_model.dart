// lib/features/post/data/models/post_model.dart

import 'package:equatable/equatable.dart';

class PostModel extends Equatable {
  final int id;
  final int userId;
  final String title;
  final String body;

  PostModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  // From JSON (Map) to PostModel
  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      body: json['body'],
    );
  }

  // To JSON (Map) from PostModel
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'title': title,
      'body': body,
    };
  }

  @override
  List<Object?> get props => [id, title, body];
}
