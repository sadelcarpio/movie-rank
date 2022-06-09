import 'package:flutter/material.dart';
import 'package:movie_ratings/constants.dart';
import 'package:movie_ratings/models/movies.dart';
import 'package:movie_ratings/providers/movies_provider.dart';
import 'package:movie_ratings/screens/movies/favorites.dart';
import 'package:movie_ratings/screens/movies/movies_list.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String movieString;
  late List<dynamic> searchResult;
  // Aquí debería definirse nuestro modelo de películas en favoritos
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MoviesProvider(),
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: SafeArea(
          child: DefaultTabController(
            length: 2,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                backgroundColor: Colors.orange[500],
                elevation: 0,
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
        ),
      ),
    );
  }
}
