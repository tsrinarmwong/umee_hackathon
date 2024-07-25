import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:umee_hackathon/services/local_storage_service.dart';
import 'package:umee_hackathon/models/user.dart';
import 'package:umee_hackathon/main.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
                onSaved: (value) {
                  _username = value!;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final localStorageService = LocalStorageService();
                    final user = User(id: DateTime.now().toString(), username: _username);
                    await localStorageService.saveUser(user);
                    Provider.of<UserProvider>(context, listen: false).setUser(user);
                    Navigator.of(context).pushReplacementNamed('/newsfeed');
                  }
                },
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
