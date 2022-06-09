import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:movie_ratings/constants.dart';
import 'package:movie_ratings/firebase_options.dart';
import 'package:movie_ratings/screens/login/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'dev project',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // var user = prefs.getString('user');
  runApp(
    const MaterialApp(
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
