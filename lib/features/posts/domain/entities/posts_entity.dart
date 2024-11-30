import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final int id;
  final int userId;
  final String title;
  final String body;

  Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}