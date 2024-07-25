import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:umee_hackathon/models/post.dart';
import 'package:umee_hackathon/services/local_storage_service.dart';
import 'package:umee_hackathon/models/user.dart';

part 'newsfeed_event.dart';
part 'newsfeed_state.dart';

class NewsfeedBloc extends Bloc<NewsfeedEvent, NewsfeedState> {
  final LocalStorageService _localStorageService;
  final User user = User(id: 'mock_user_id', username: 'Timo');  // Mock user

  NewsfeedBloc(this._localStorageService) : super(NewsfeedInitial()) {
    on<LoadNewsfeed>((event, emit) async {
      emit(NewsfeedLoading());
      try {
        final posts = await _localStorageService.getAllPosts();
        final savedPosts = await _localStorageService.getAllSavedPosts(user.id);  // Load saved posts
        final likedPosts = await _localStorageService.getUserLikedPosts(user.id); // Load liked posts
        emit(NewsfeedReady(posts, savedPosts, likedPosts));
      } catch (e) {
        emit(NewsfeedError(e.toString()));
      }
    });
  }
}
