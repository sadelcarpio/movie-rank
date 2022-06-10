import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_ratings/components/movie_card.dart';
import 'package:movie_ratings/providers/movies_provider.dart';
import 'package:movie_ratings/screens/movies/search_movie.dart';
import 'package:provider/provider.dart';

class MoviesList extends StatefulWidget {
  const MoviesList({Key? key}) : super(key: key);

  @override
  State<MoviesList> createState() => _MoviesListState();
}

class _MoviesListState extends State<MoviesList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: RefreshIndicator(
              color: Colors.orange[500],
              onRefresh: () async {
                setState(() {});
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child:
                    Consumer<MoviesProvider>(builder: (context, model, child) {
                  return ListView.builder(
                      itemCount: model.movies.length,
                      itemBuilder: (context, index) {
                        return MovieCard(imdbId: model.movies[index].imdbId!);
                      });
                }),
              ),
            ),
          ),
        ],
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0, bottom: 20.0),
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => const SearchMovie()));
                  },
                  backgroundColor: Colors.orange[500],
                  elevation: 10,
                  child: SvgPicture.asset(
                    'assets/logos/plus.svg',
                    height: 35,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )
        ],
      )
    ]);
  }
}
