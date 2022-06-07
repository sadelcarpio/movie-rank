import 'package:flutter/cupertino.dart';
import 'package:movie_ratings/models/movies.dart';

class MoviesProvider with ChangeNotifier {
  final List<Movie> _movies;
  MoviesProvider({required List<Movie> movies}) : _movies = movies;
  void toggleFavorite(String movieId) {
    Movie favoriteMovie = getById(movieId);
    favoriteMovie.favorite = !favoriteMovie.favorite;
    notifyListeners();
  }

  get movies => _movies;

  getById(imdbId) {
    return _movies.firstWhere((movie) => movie.imdbId == imdbId);
  }
}
