import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/newsfeed/newsfeed_bloc.dart';
import '../widgets/loading_widget.dart';
import '../widgets/post_widgets.dart';

class NewsfeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Newsfeed'),        
      ),
      body: BlocBuilder<NewsfeedBloc, NewsfeedState>(
        builder: (context, state) {
          if (state is NewsfeedLoading) {
            return LoadingWidget();
          } else if (state is NewsfeedReady) {
            return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                final post = state.posts[index];
                final isSavedPost = state.savedPosts.any((savedPost) => savedPost.id == post.id);
                return PostWidget(post: post, isSavedPost: isSavedPost);
              },
            );
          } else if (state is NewsfeedError) {
            return Center(child: Text('Failed to load newsfeed'));
          } else {
            return Center(child: Text('No posts available'));
          }
        },
      ),

    );
  }
}
