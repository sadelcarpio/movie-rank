import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_ratings/screens/homepage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:movie_ratings/screens/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'assets/dotenv');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var user = prefs.getString('user');
  runApp(MaterialApp(
    home: user == null ? const MyApp() : HomePage(name: user),
    debugShowCheckedModeBanner: false,
    builder: EasyLoading.init(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const LoginPage(title: 'Login'),
    );
  }
}
