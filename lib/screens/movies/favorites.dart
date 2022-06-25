import 'package:flutter/material.dart';
import 'package:movie_ratings/components/movie_card.dart';
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
    return RefreshIndicator(
      color: Colors.orange[500],
      onRefresh: () async {
        setState(() {});
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Consumer<MoviesProvider>(builder: (context, model, child) {
          model.favorites.sort((a, b) {
            int? adate = a.postedAt;
            int? bdate = b.postedAt;
            return bdate!.compareTo(adate!);
          });
          return ListView.builder(
              key: const PageStorageKey('favorites_key'),
              itemCount: model.favorites.length,
              itemBuilder: (context, index) {
                return MovieCard(imdbId: model.favorites[index].imdbId!);
              });
        }),
      ),
    );
  }
}
