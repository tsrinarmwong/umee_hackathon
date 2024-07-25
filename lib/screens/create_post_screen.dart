import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/newsfeed/newsfeed_bloc.dart';
import '../models/user.dart';
import '../blocs/post/post_bloc.dart';
import '../models/post.dart';

class CreatePostScreen extends StatefulWidget {
  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _formKey = GlobalKey<FormState>();
  String _content = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Post')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Content'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some content';
                  }
                  return null;
                },
                onSaved: (value) {
                  _content = value!;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final user = User(id: 'mock_id', username: 'MockUser');
                    final post = Post(
                      id: DateTime.now().toString(),
                      userName: user.username,
                      content: _content,
                      timestamp: DateTime.now(),
                      likeCount: 0,
                      imagePath: null,
                    );
                    BlocProvider.of<PostBloc>(context).add(AddPost(post));
                    BlocProvider.of<NewsfeedBloc>(context).add(LoadNewsfeed()); // Trigger load newsfeed
                    Navigator.of(context).popUntil((route) => route.isFirst); // Navigate back to the main screen
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Post created successfully!'),
                      ),
                    );
                  }
                },
                child: Text('Publish'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
