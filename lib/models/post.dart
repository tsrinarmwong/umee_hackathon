import 'package:hive/hive.dart';

part 'post.g.dart';

@HiveType(typeId: 0)
class Post {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String userName;
  
  @HiveField(2)
  final String content;
  
  @HiveField(3)
  final DateTime timestamp;
  
  @HiveField(4)
  int likeCount;

  @HiveField(5)
  final String? imagePath; // Optional image path

  Post({
    required this.id,
    required this.userName,
    required this.content,
    required this.timestamp,
    this.likeCount = 0,
    this.imagePath,
  });
}
