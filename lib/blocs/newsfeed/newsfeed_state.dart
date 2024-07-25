part of 'newsfeed_bloc.dart';

abstract class NewsfeedState extends Equatable {
  const NewsfeedState();

  @override
  List<Object> get props => [];
}

class NewsfeedInitial extends NewsfeedState {}

class NewsfeedLoading extends NewsfeedState {}

class NewsfeedReady extends NewsfeedState {
  final List<Post> posts;
  final List<Post> savedPosts;
  final List<Post> likedPosts; // Add likedPosts

  const NewsfeedReady(this.posts, this.savedPosts, this.likedPosts);

  @override
  List<Object> get props => [posts, savedPosts, likedPosts];
}

class NewsfeedError extends NewsfeedState {
  final String message;

  const NewsfeedError(this.message);

  @override
  List<Object> get props => [message];
}
