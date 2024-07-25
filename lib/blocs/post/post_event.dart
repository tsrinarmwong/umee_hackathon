part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class LoadPosts extends PostEvent {}

class AddPost extends PostEvent {
  final Post post;

  const AddPost(this.post);

  @override
  List<Object> get props => [post];
}

class DeletePost extends PostEvent {
  final String id;

  const DeletePost(this.id);

  @override
  List<Object> get props => [id];
}

class UpdateLikeCount extends PostEvent {
  final String id;
  final int newCount;

  const UpdateLikeCount(this.id, this.newCount);

  @override
  List<Object> get props => [id, newCount];
}

class SavePost extends PostEvent {
  final Post post;

  const SavePost(this.post);

  @override
  List<Object> get props => [post];
}

class UnsavePost extends PostEvent {
  final String id;

  const UnsavePost(this.id);

  @override
  List<Object> get props => [id];
}

class LoadSavedPosts extends PostEvent {}

class LikePost extends PostEvent {
  final String id;

  const LikePost(this.id);

  @override
  List<Object> get props => [id];
}

class UnlikePost extends PostEvent {
  final String id;

  const UnlikePost(this.id);

  @override
  List<Object> get props => [id];
}

class LoadLikedPosts extends PostEvent {}