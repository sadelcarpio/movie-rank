import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movie_ratings/components/movie_card.dart';
import 'package:movie_ratings/providers/favorites_provider.dart';

class MoviesList extends StatefulWidget {
  const MoviesList({Key? key}) : super(key: key);

  @override
  State<MoviesList> createState() => _MoviesListState();
}

class _MoviesListState extends State<MoviesList> {
  @override
  Widget build(BuildContext context) {
    final movies = Provider.of<MoviesProvider>(context, listen: true).movies;
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
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    return MovieCard(
                      imdbId: movies[index].imdbId,
                    );
                  },
                )),
          ),
        ),
      ],
    );
  }
}
