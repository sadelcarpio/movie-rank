import 'package:flutter/material.dart';
import 'package:movie_ratings/components/movie_card.dart';
import 'package:movie_ratings/providers/movies_provider.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: RefreshIndicator(
            color: Colors.orange[600],
            onRefresh: () async {
              setState(() {});
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Consumer<MoviesProvider>(builder: (context, model, child) {
                return ListView(children: [
                  ...model.movies
                      .map((movie) => MovieCard(imdbId: movie.imdbId!))
                ]);
              }),
            ),
          ),
        ),
      ],
    );
  }
}
