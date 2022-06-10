import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:movie_ratings/firebase_options.dart';
import 'package:movie_ratings/providers/movies_provider.dart';
import 'package:movie_ratings/screens/login/login_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'dev project',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => MoviesProvider(),
      child: MaterialApp(
        builder: EasyLoading.init(),
        home: const LoginPage(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
