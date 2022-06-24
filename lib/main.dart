import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:movie_ratings/firebase_options.dart';
import 'package:movie_ratings/providers/movies_provider.dart';
import 'package:movie_ratings/screens/login/login_page.dart';
import 'package:movie_ratings/screens/movies/home_navigator.dart';
import 'package:movie_ratings/screens/movies/homepage.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'dev project',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MaterialApp(
      builder: EasyLoading.init(),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ChangeNotifierProvider(
                  create: (BuildContext context) => MoviesProvider(),
                  child: const HomeNavigator());
            } else {
              return const LoginPage();
            }
          },
        ),
      ),
      debugShowCheckedModeBanner: false,
    ),
  );
}
