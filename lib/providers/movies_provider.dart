import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie_ratings/models/movies.dart';
import 'package:collection/collection.dart';
import 'package:movie_ratings/services/api_calls.dart';

class MoviesProvider with ChangeNotifier {
  List<Movie> _movies = [];
  List<Movie> _favorites = [];
  final _db = FirebaseDatabase.instance.ref();

  static const pathPeliculas = 'peliculas';
  static const pathUsuarios = 'usuarios';

  late StreamSubscription<DatabaseEvent> _moviesStream;
  late StreamSubscription<DatabaseEvent> _favoritesStream;

  List<Movie> get movies => _movies;
  List<Movie> get favorites => _favorites;
  List<String?> get favoritesIds =>
      _favorites.map((value) => value.imdbId).toList();

  Movie getById(imdbId) {
    return _movies.firstWhere((movie) => movie.imdbId == imdbId);
  }

  void toggleFavorite(String movieId) {
    final List<String?> favoritesIds =
        _favorites.map((value) => value.imdbId).toList();
    if ((_favorites.firstWhereOrNull((elem) => elem.imdbId == movieId)) !=
        null) {
      favoritesIds.remove(movieId);
    } else {
      favoritesIds.add(movieId);
    }
    DatabaseReference user = _db.child('$pathUsuarios/sergio');
    user.update({'favorites': favoritesIds});
    notifyListeners();
  }

  Future<dynamic> addMovie(Map possibleMovie) async {
    DatabaseReference moviesRef = _db.child(pathPeliculas);
    moviesRef.update({
      possibleMovie['id']: {
        'imdbId': possibleMovie['id'],
        'imgUrl': possibleMovie['image']
            .replaceFirst('_V1_Ratio0.7273_AL_', '_V1_UX150_CR0,3,150,222_AL_'),
        'postedBy': 'sergio',
        'title': possibleMovie['title'],
        'year': possibleMovie['description'],
        'plot': await HttpService.scrapePlot(possibleMovie['id'])
      }
    });
    notifyListeners();
  }

  MoviesProvider() {
    _listenMovies();
    _listenFavorites();
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

  void _listenFavorites() {
    _favoritesStream =
        _db.child('$pathUsuarios/sergio/favorites').onValue.listen((event) {
      if (event.snapshot.value != null) {
        final List allFavorites = event.snapshot.value as List;
        _favorites = allFavorites.map((imdbId) => getById(imdbId)).toList();
      } else {
        _favorites = [];
      }
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _moviesStream.cancel();
    _favoritesStream.cancel();
    super.dispose();
  }
}
