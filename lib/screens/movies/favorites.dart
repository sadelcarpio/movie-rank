import 'package:flutter/material.dart';
import 'package:movie_ratings/components/movie_card.dart';
import 'package:movie_ratings/models/movies.dart';
import 'package:movie_ratings/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class FavoritesList extends StatefulWidget {
  const FavoritesList({Key? key}) : super(key: key);

  @override
  State<FavoritesList> createState() => _FavoritesListState();
}

class _FavoritesListState extends State<FavoritesList> {
  @override
  Widget build(BuildContext context) {
    final List<Movie> favoriteMovies =
        Provider.of<MoviesProvider>(context).favorites;
    return RefreshIndicator(
      color: Colors.orange[500],
      onRefresh: () async {
        setState(() {});
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView.builder(
            key: const PageStorageKey('favorites_key'),
            itemCount: favoriteMovies.length,
            itemBuilder: (context, index) {
              return MovieCard(imdbId: favoriteMovies[index].imdbId!);
            }),
      ),
    );
  }
}
