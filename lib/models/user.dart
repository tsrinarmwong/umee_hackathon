import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String username;

  @HiveField(2)
  final List<String> savedPostIds;

  @HiveField(3)
  final List<String> likedPostIds; // Add this line

  User({
    required this.id,
    required this.username,
    List<String>? savedPostIds,
    List<String>? likedPostIds, // Add this line
  })  : savedPostIds = savedPostIds ?? [],
        likedPostIds = likedPostIds ?? []; // Add this line
}
