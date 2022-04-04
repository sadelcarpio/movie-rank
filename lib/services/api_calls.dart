import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:movie_ratings/screens/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HttpService {
  static final _client = http.Client();
  static final _loginUrl = Uri.parse(dotenv.env['LOGIN_URL']!);
  static final _registerUrl = Uri.parse(dotenv.env['REGISTER_URL']!);
  static final _searchMovieUrl = Uri.parse(dotenv.env['SEARCH_URL']!);
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
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => HomePage(name: user)),
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
      http.Response response = await _client.post(_searchMovieUrl,
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
}
