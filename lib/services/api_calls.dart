import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:movie_ratings/models/movies.dart';
import 'package:movie_ratings/models/reviews.dart';
import 'package:movie_ratings/screens/movies/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HttpService {
  static final _client = http.Client();
  static final _loginUrl = Uri.parse(dotenv.env['LOGIN_URL']!);
  static final _registerUrl = Uri.parse(dotenv.env['REGISTER_URL']!);
  static final _moviesUrl = dotenv.env['MOVIES_URL']!;
  static final _reviewsUrl = dotenv.env['REVIEWS_URL']!;
  static register(email, username, password, context) async {
    await EasyLoading.show(status: 'Creando cuenta ...');
    try {
      http.Response response = await _client.post(_registerUrl,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Access-Control-Allow-Origin': '*',
          },
          body: jsonEncode(
              {"email": email, "username": username, "password": password}));
      var json = jsonDecode(response.body);
      if (response.statusCode == 201) {
        await EasyLoading.showSuccess(json[0]);
      } else {
        await EasyLoading.showInfo(json[0].toString());
      }
    } on Exception {
      await EasyLoading.showError("Parece que no hay conexión :(");
    }
  }

  static login(user, password, context) async {
    await EasyLoading.show(status: 'Conectando ...');
    try {
      http.Response response = await _client.post(_loginUrl,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Access-Control-Allow-Origin': '*',
          },
          body: jsonEncode(
              {"email": user, "password": password, "remember": false}));
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        if (json[0] == 'Éxito') {
          await EasyLoading.showSuccess('Bienvenido, ${json[1]}');
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('user', json[1]);
          await Navigator.of(context).pushReplacement(
            CupertinoPageRoute(builder: (context) => const HomePage()),
          );
        } else {
          await EasyLoading.showInfo(json[0].toString());
        }
      } else {
        await EasyLoading.showError(
            "Error Code : ${response.statusCode.toString()}");
      }
    } on Exception {
      await EasyLoading.showError("Parece que no hay conexión :(");
    }
  }

  static searchMovie(movieString) async {
    await EasyLoading.show(status: 'Buscando ...');
    try {
      final searchMovieUrl = Uri.parse('$_moviesUrl/search');
      http.Response response = await _client.post(searchMovieUrl,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Access-Control-Allow-Origin': '*',
          },
          body: jsonEncode({"searchMovie": movieString}));
      Map<String, dynamic> json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        await EasyLoading.dismiss();
        return json['results'];
      }
    } on Exception {
      await EasyLoading.showError("Parece que no hay conexión :(");
    }
  }

  static Future<List<dynamic>> fetchMovies() async {
    try {
      final showMoviesUrl = Uri.parse('$_moviesUrl/all');
      http.Response response = await _client.get(showMoviesUrl);
      List<dynamic> json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        await EasyLoading.dismiss();
        return json;
      }
    } catch (e) {
      await EasyLoading.showError("Parece que no hay conexión :(");
    }
    return [];
  }

  static createMovie(Movie movie) async {
    await EasyLoading.show(status: 'Añadiendo película ...');
    try {
      final createMovieUrl = Uri.parse('$_moviesUrl/create');
      http.Response response = await _client.post(createMovieUrl,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Access-Control-Allow-Origin': '*',
          },
          body: jsonEncode({
            "imdb_id": movie.imdbId,
            "year": movie.year,
            "title": movie.title,
            "img_url": movie.imgUrl
          }));
      var json = jsonDecode(response.body);
      if (response.statusCode == 201) {
        await EasyLoading.showSuccess(json[0]);
      }
    } on Exception {
      await EasyLoading.showError("Parece que no hay conexión :(");
    }
  }

  static Future<List<dynamic>> fetchReviews(String movieId) async {
    try {
      final showReviewsUrl = Uri.parse('$_reviewsUrl/all/$movieId');
      http.Response response = await _client.get(showReviewsUrl);
      List<dynamic> json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        await EasyLoading.dismiss();
        return json;
      }
    } catch (e) {
      await EasyLoading.showError("Parece que no hay conexión :(");
    }
    return [];
  }

  static createReview(String imdbId, Review review) async {
    await EasyLoading.show(status: 'Añadiendo película ...');
    try {
      final createReviewUrl = Uri.parse('$_reviewsUrl/create');
      http.Response response = await _client.post(createReviewUrl,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Access-Control-Allow-Origin': '*',
          },
          body: jsonEncode({
            "movie_id": imdbId,
            "username": review.user,
            "review_content": review.content,
            "stars": review.stars,
          }));
      var json = jsonDecode(response.body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        await EasyLoading.showSuccess(json[0]);
      }
    } on Exception {
      await EasyLoading.showError("Parece que no hay conexión :(");
    }
  }
}
