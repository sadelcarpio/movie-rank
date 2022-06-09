import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie_ratings/models/movies.dart';

class MoviesProvider with ChangeNotifier {
  List<Movie> _movies = [];
  final _db = FirebaseDatabase.instance.ref();

  static const pathPeliculas = 'peliculas';
  late StreamSubscription<DatabaseEvent> _moviesStream;
  List<Movie> get movies => _movies;
  void toggleFavorite(String movieId) {
    Movie favoriteMovie = getById(movieId);
    DatabaseReference query = _db.child('peliculas/$movieId');
    query.update({'favorite': !favoriteMovie.favorite!});
    notifyListeners();
  }

  MoviesProvider() {
    _listenMovies();
  }

  void _listenMovies() {
    _moviesStream = _db.child(pathPeliculas).onValue.listen((event) {
      final allMovies = Map<String, dynamic>.from(
          event.snapshot.value as Map<dynamic, dynamic>);
      _movies = allMovies.values
          .map((e) => Movie.fromRTDB(Map<String, dynamic>.from(e)))
          .toList();
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _moviesStream.cancel();
    super.dispose();
  }

  getById(imdbId) {
    return _movies.firstWhere((movie) => movie.imdbId == imdbId);
  }
}
