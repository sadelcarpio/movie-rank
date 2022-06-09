import 'package:flutter/material.dart';
import 'package:movie_ratings/components/movie_card.dart';
import 'package:movie_ratings/models/movies.dart';
import 'package:movie_ratings/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class FavoritesList extends StatelessWidget {
  const FavoritesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Movie> favoriteMovies = Provider.of<MoviesProvider>(context)
        .movies
        .where((elem) => elem.favorite == true)
        .toList();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ListView.builder(
          key: const PageStorageKey('favorites_key'),
          itemCount: favoriteMovies.length,
          itemBuilder: (context, index) {
            return MovieCard(imdbId: favoriteMovies[index].imdbId!);
          }),
    );
  }
}
