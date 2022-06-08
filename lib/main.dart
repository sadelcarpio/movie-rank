import 'package:flutter/material.dart';
import 'package:movie_ratings/providers/favorites_provider.dart';
import 'package:movie_ratings/screens/movies/homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:movie_ratings/firebase_options.dart';
import 'package:movie_ratings/screens/login/login_page.dart';
import 'package:provider/provider.dart';
import 'package:movie_ratings/models/movies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'dev project',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // var user = prefs.getString('user');
  runApp(
    MaterialApp(
      home: ChangeNotifierProvider(
        create: (_) => MoviesProvider(movies: movies),
        child: const HomePage(),
      ),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Movie Rank',
      home: LoginPage(title: 'Login'),
    );
  }
}
