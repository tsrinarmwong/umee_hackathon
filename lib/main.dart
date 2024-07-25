import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import '../blocs/newsfeed/newsfeed_bloc.dart';
import '../blocs/post/post_bloc.dart';
import '../services/local_storage_service.dart';
import '../screens/newsfeed_screen.dart';
import '../screens/saved_posts_screen.dart';
import '../screens/create_post_screen.dart';
import '../models/post.dart';
import '../models/user.dart';
import '../simple_bloc_observer.dart';
import '../screens/login_screen.dart';

void main() async {
  Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(PostAdapter());
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox<Post>('postsBox');
  await Hive.openBox<Post>('savedPostsBox'); // Ensure the box is opened once
  await Hive.openBox<User>('userBox'); // Ensure the user box is opened once

  final localStorageService = LocalStorageService();
  await localStorageService.populateMockData();

  runApp(MyApp(localStorageService: localStorageService));
}

class MyApp extends StatefulWidget {
  final LocalStorageService localStorageService;

  MyApp({required this.localStorageService});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? user;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final storedUser = await widget.localStorageService.getUser();
    setState(() {
      user = storedUser;
    });
  }

  final List<Widget> _screens = [
    NewsfeedScreen(),
    CreatePostScreen(),
    SavedPostsScreen(),
  ];

  void _navigateToNewsfeed() {
    setState(() {
      _currentIndex = 0; // Set index to Newsfeed tab
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override 
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider(user)),
        BlocProvider(
          create: (context) =>
              NewsfeedBloc(widget.localStorageService)..add(LoadNewsfeed()),
        ),
        BlocProvider(
          create: (context) =>
              PostBloc(widget.localStorageService)..add(LoadPosts()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: user == null ? LoginScreen() : _buildMainScreen(),
        onGenerateRoute: _generateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }

  Widget _buildMainScreen() {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Newsfeed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Create Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Saved Posts',
          ),
        ],
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
      ),
    );
  }

  Route<dynamic> _generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/savedPosts':
        return MaterialPageRoute(builder: (context) => SavedPostsScreen());
      default:
        return MaterialPageRoute(builder: (context) => NewsfeedScreen());
    }
  }
}

class UserProvider with ChangeNotifier {
  User? _user;

  UserProvider(this._user);

  User? get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}
