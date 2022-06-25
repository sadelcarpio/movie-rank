import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_ratings/constants.dart';
import 'package:movie_ratings/screens/movies/favorites.dart';
import 'package:movie_ratings/screens/movies/movies_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.orange[500],
            elevation: 0,
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: GestureDetector(
                  onTap: () async {
                    await showDialog(
                        context: context, builder: (context) => areYouSure());
                  },
                  child: SvgPicture.asset(
                    'assets/logos/logout.svg',
                    height: 40,
                  ),
                ),
              ),
            ],
            title: const Text(
              'Movie Rank',
              style: TextStyle(
                fontFamily: 'Titilium',
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ColoredBox(
                color: Colors.orange[700]!,
                child: const TabBar(
                  indicatorColor: mainColor,
                  indicatorWeight: 5.0,
                  tabs: [
                    Tab(
                      text: 'Películas',
                      icon: Icon(Icons.movie),
                      height: 65,
                    ),
                    Tab(
                      text: 'Favoritos',
                      icon: Icon(Icons.favorite),
                      height: 65,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Stack(children: [
                  Column(
                    children: [
                      Expanded(
                        child: Image.asset(
                          'assets/images/movie_collage_dark.jpeg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                  const TabBarView(
                    children: [
                      MoviesList(),
                      FavoritesList(),
                    ],
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  areYouSure() {
    return AlertDialog(
      title: const Center(child: Text('¿Seguro?')),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 40.0, vertical: 8.0),
      buttonPadding: const EdgeInsets.only(top: 0.0),
      actionsPadding: const EdgeInsets.only(bottom: 10.0),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TextButton(
            style: TextButton.styleFrom(
              fixedSize: const Size(50, 40),
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              backgroundColor: Colors.orange[500],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0),
              ),
              elevation: 10,
            ),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
              FirebaseAuth.instance.signOut();
            },
            child: const Text(
              'SALIR',
              style: TextStyle(
                fontFamily: 'Titilium',
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFFFFFF),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TextButton(
            style: TextButton.styleFrom(
              fixedSize: const Size(50, 40),
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              backgroundColor: Colors.orange[700],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0),
              ),
              elevation: 10,
            ),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: const Text(
              'NO',
              style: TextStyle(
                fontFamily: 'Titilium',
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFFFFFF),
              ),
            ),
          ),
        )
      ],
    );
  }
}
