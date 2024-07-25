import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:umee_hackathon/models/post.dart';
import 'package:umee_hackathon/services/local_storage_service.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final LocalStorageService _localStorageService;
  final String userId = 'mock_user_id';  // Mock user ID for demonstration

  PostBloc(this._localStorageService) : super(PostInitial()) {
    on<LoadPosts>((event, emit) async {
      emit(PostLoading());
      try {
        final posts = await _localStorageService.getAllPosts();
        emit(PostReady(posts));
      } catch (e) {
        emit(PostError(e.toString()));
      }
    });

    on<AddPost>((event, emit) async {
      await _localStorageService.addPost(event.post);
      add(LoadPosts());
    });

    on<DeletePost>((event, emit) async {
      await _localStorageService.deletePost(event.id);
      add(LoadPosts());
    });

    on<UpdateLikeCount>((event, emit) async {
      await _localStorageService.updateLikeCount(event.id, event.newCount);
      add(LoadPosts());
    });

    on<SavePost>((event, emit) async {
      await _localStorageService.savePost(event.post, userId);
      add(LoadSavedPosts());
    });

    on<UnsavePost>((event, emit) async {
      await _localStorageService.unsavePost(event.id, userId);
      add(LoadSavedPosts());
    });

    on<LoadSavedPosts>((event, emit) async {
      emit(PostLoading());
      try {
        final posts = await _localStorageService.getAllSavedPosts(userId);
        emit(PostReady(posts));
      } catch (e) {
        emit(PostError(e.toString()));
      }
    });

    on<LikePost>((event, emit) async {
      await _localStorageService.likePost(event.id, userId);
      add(LoadPosts());
    });

    on<UnlikePost>((event, emit) async {
      await _localStorageService.unlikePost(event.id, userId);
      add(LoadPosts());
    });


    on<LoadLikedPosts>((event, emit) async {
      emit(PostLoading());
      try {
        final posts = await _localStorageService.getUserLikedPosts(userId);
        emit(PostReady(posts));
      } catch (e) {
        emit(PostError(e.toString()));
      }
    });
  }
}
