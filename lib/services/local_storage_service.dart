import 'package:hive/hive.dart';
import '../models/post.dart';
import '../models/user.dart';

class LocalStorageService {
  final String _postBox = 'postsBox';
  final String _savedPostBox = 'savedPostsBox';
  final String _userBox = 'userBox';

  Box<Post>? _postBoxInstance;
  Box<Post>? _savedPostBoxInstance;
  Box<User>? _userBoxInstance;

  final List<Post> _mockPosts = [
    Post(
      id: '1',
      userName: 'Alice',
      content: 'This is the first mock post',
      timestamp: DateTime.now(),
      likeCount: 10,
    ),
    Post(
      id: '2',
      userName: 'Bob',
      content: 'Here is another mock post for testing',
      timestamp: DateTime.now(),
      likeCount: 5,
    ),
    Post(
      id: '3',
      userName: 'Charlie',
      content: 'Adding more mock posts to the list',
      timestamp: DateTime.now(),
      likeCount: 8,
    ),
    Post(
      id: '4',
      userName: 'Diana',
      content: 'Mock post number four',
      timestamp: DateTime.now(),
      likeCount: 12,
    ),
    Post(
      id: '5',
      userName: 'Eve',
      content: 'Final mock post for testing purposes',
      timestamp: DateTime.now(),
      likeCount: 3,
    ),
  ];

  Future<void> _openPostBox() async {
    if (_postBoxInstance == null || !_postBoxInstance!.isOpen) {
      _postBoxInstance = await Hive.openBox<Post>(_postBox);
    }
  }

  Future<void> _openSavedPostBox() async {
    if (_savedPostBoxInstance == null || !_savedPostBoxInstance!.isOpen) {
      _savedPostBoxInstance = await Hive.openBox<Post>(_savedPostBox);
    }
  }

  Future<void> _openUserBox() async {
    if (_userBoxInstance == null || !_userBoxInstance!.isOpen) {
      _userBoxInstance = await Hive.openBox<User>(_userBox);
    }
  }

  Future<void> populateMockData() async {
    await _openPostBox();
    for (var post in _mockPosts) {
      await _postBoxInstance!.put(post.id, post);
    }
  }

  Future<void> addPost(Post post) async {
    await _openPostBox();
    await _postBoxInstance!.put(post.id, post);
  }

  Future<Post?> getPost(String id) async {
    await _openPostBox();
    return _postBoxInstance!.get(id);
  }

  Future<void> deletePost(String id) async {
    await _openPostBox();
    await _postBoxInstance!.delete(id);
  }

  Future<List<Post>> getAllPosts() async {
    await _openPostBox();
    return _postBoxInstance!.values.toList();
  }

  Future<void> updateLikeCount(String id, int newCount) async {
    await _openPostBox();
    Post? post = _postBoxInstance!.get(id);
    if (post != null) {
      post.likeCount = newCount;
      await _postBoxInstance!.put(id, post);
    }
  }

  Future<void> savePost(Post post, String userId) async {
    await _openSavedPostBox();
    await _savedPostBoxInstance!.put(post.id, post);

    await _openUserBox();
    User? user = _userBoxInstance!.get(userId);
    if (user != null) {
      user.savedPostIds.add(post.id);
      await _userBoxInstance!.put(userId, user);
    }
  }

  Future<void> unsavePost(String id, String userId) async {
    await _openSavedPostBox();
    await _savedPostBoxInstance!.delete(id);

    await _openUserBox();
    User? user = _userBoxInstance!.get(userId);
    if (user != null) {
      user.savedPostIds.remove(id);
      await _userBoxInstance!.put(userId, user);
    }
  }

  Future<List<Post>> getAllSavedPosts(String userId) async {
    await _openSavedPostBox();
    return _savedPostBoxInstance!.values.toList();
  }

  Future<void> likePost(String postId, String userId) async {
    await _openPostBox();
    Post? post = _postBoxInstance!.get(postId);
    if (post != null) {
      post.likeCount += 1;
      await _postBoxInstance!.put(postId, post);

      await _openUserBox();
      User? user = _userBoxInstance!.get(userId);
      if (user != null) {
        user.likedPostIds.add(postId);
        await _userBoxInstance!.put(userId, user);
      }
    }
  }

  Future<void> unlikePost(String postId, String userId) async {
    await _openPostBox();
    Post? post = _postBoxInstance!.get(postId);
    if (post != null && post.likeCount > 0) {
      post.likeCount -= 1;
      await _postBoxInstance!.put(postId, post);

      await _openUserBox();
      User? user = _userBoxInstance!.get(userId);
      if (user != null) {
        user.likedPostIds.remove(postId);
        await _userBoxInstance!.put(userId, user);
      }
    }
  }

  Future<List<Post>> getUserLikedPosts(String userId) async {
    await _openUserBox();
    User? user = _userBoxInstance!.get(userId);
    if (user != null) {
      await _openPostBox();
      return user.likedPostIds.map((postId) => _postBoxInstance!.get(postId)!).toList();
    }
    return [];
  }

  Future<void> saveUser(User user) async {
    await _openUserBox();
    await _userBoxInstance!.put('current_user', user);
  }

  Future<User?> getUser() async {
    await _openUserBox();
    return _userBoxInstance!.get('current_user');
  }
}
