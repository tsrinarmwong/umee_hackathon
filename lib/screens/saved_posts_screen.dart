import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/post/post_bloc.dart';
import '../widgets/loading_widget.dart';
import '../widgets/post_widgets.dart';

class SavedPostsScreen extends StatelessWidget {
  const SavedPostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Posts'),
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostLoading) {
            return LoadingWidget();
          } else if (state is PostReady) {
            if (state.posts.isEmpty) {
              return const Center(child: Text('No saved posts available'));
            }
            return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                final post = state.posts[index];
                return PostWidget(post: post);
              },
            );
          } else if (state is PostError) {
            return const Center(child: Text('Failed to load saved posts'));
          } else {
            return const Center(child: Text('No saved posts available'));
          }
        },
      ),
    );
  }
}
