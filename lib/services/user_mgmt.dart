import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HttpService {
  static final _client = http.Client();
  static final _loginUrl = Uri.parse(dotenv.env['LOGIN_URL']!);
  static login(user, password, context) async {
    await EasyLoading.show(status: 'Conectando ...');
    try {
      http.Response response = await _client.post(_loginUrl,
          headers: <String, String>{
            'Content-Type': 'text/plain; charset=UTF-8',
            'Access-Control-Allow-Origin': '*',
          },
          body: jsonEncode(
              {"email": user, "password": password, "remember": false}));
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        if (json[0] == 'Éxito') {
          await EasyLoading.showSuccess(json[0]);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('user', user);
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
}
