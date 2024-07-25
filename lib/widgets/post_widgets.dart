  // backgroundImage: AssetImage('/Users/thitipunsrinarmwong/Documents/CODING/Flutter/umee_hackathon/lib/assets/profile_placeholder.png'), // Placeholder image

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../blocs/newsfeed/newsfeed_bloc.dart';
import '../blocs/post/post_bloc.dart';
import '../models/post.dart';

class PostWidget extends StatefulWidget {
  final Post post;
  final bool isSavedPost;

  const PostWidget({Key? key, required this.post, this.isSavedPost = false}) : super(key: key);

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  bool _isLikeAnimating = false;
  // bool _isSaveAnimating = false;

  @override
  Widget build(BuildContext context) {
    // Format the timestamp to MM/DD/YY Hr:min
    final DateFormat formatter = DateFormat('MM/dd/yy HH:mm');
    final String formattedTimestamp = formatter.format(widget.post.timestamp);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile picture
            CircleAvatar(
              backgroundImage: AssetImage('/Users/thitipunsrinarmwong/Documents/CODING/Flutter/umee_hackathon/lib/assets/profile_placeholder.png'), // Placeholder image
              radius: 24.0,
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User name
                  Text(
                    widget.post.userName,
                    style: const TextStyle(color: Colors.grey, fontSize: 14.0),
                  ),
                  const SizedBox(height: 4.0),
                  // Post content
                  Text(
                    widget.post.content,
                    style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$formattedTimestamp • ${widget.post.likeCount} likes',
                        style: const TextStyle(color: Colors.grey),
                      ),
                      Row(
                        children: [
                          // Animated like button
                          AnimatedScale(
                            scale: _isLikeAnimating ? 1.2 : 1.0,
                            duration: const Duration(milliseconds: 150),
                            child: IconButton(
                              icon: const Icon(Icons.thumb_up_alt_rounded),
                              onPressed: () {
                                setState(() {
                                  _isLikeAnimating = true;
                                });

                                // Reset animation after the scale effect
                                Future.delayed(const Duration(milliseconds: 150), () {
                                  setState(() {
                                    _isLikeAnimating = false;
                                  });
                                });

                                BlocProvider.of<PostBloc>(context).add(
                                  UpdateLikeCount(widget.post.id, widget.post.likeCount + 1),
                                );
                                // BlocProvider.of<PostBloc>(context).add(LoadSavedPosts()); // Trigger load saved posts
                                BlocProvider.of<NewsfeedBloc>(context).add(LoadNewsfeed()); // Trigger load newsfeed
                              },
                            ),
                          ),
                          // IconButton(
                          //   icon: const Icon(Icons.delete),
                          //   onPressed: () {
                          //     BlocProvider.of<PostBloc>(context)
                          //         .add(DeletePost(widget.post.id));
                          //     BlocProvider.of<NewsfeedBloc>(context)
                          //         .add(LoadNewsfeed()); // Trigger load newsfeed
                          //   },
                          // ),
                          // Animated save button
                         BlocBuilder<PostBloc, PostState>(
                            builder: (context, state) {
                              bool isSaved = false;
                              if (state is PostReady) {
                                isSaved = state.posts.any((savedPost) => savedPost.id == widget.post.id);
                              }
                              return IconButton(
                                icon: Icon(
                                  isSaved ? Icons.bookmark : Icons.bookmark_border,
                                  color: isSaved ? Color.fromARGB(255, 91, 194, 89) : null,
                                ),
                                onPressed: () {
                                  if (isSaved) {
                                    BlocProvider.of<PostBloc>(context).add(UnsavePost(widget.post.id));
                                  } else {
                                    BlocProvider.of<PostBloc>(context).add(SavePost(widget.post));
                                  }
                                  BlocProvider.of<PostBloc>(context).add(LoadSavedPosts()); // Trigger load saved posts
                                  BlocProvider.of<NewsfeedBloc>(context).add(LoadNewsfeed()); // Trigger load newsfeed
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
