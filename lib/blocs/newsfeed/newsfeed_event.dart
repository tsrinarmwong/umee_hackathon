part of 'newsfeed_bloc.dart';

abstract class NewsfeedEvent extends Equatable {
  const NewsfeedEvent();

  @override
  List<Object> get props => [];
}

class LoadNewsfeed extends NewsfeedEvent {}
