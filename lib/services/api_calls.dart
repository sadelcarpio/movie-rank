import 'dart:convert';
import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

class HttpService {
  static final _client = http.Client();
  static const _imdbAPI = 'https://imdb-api.com/en/API/SearchMovie/k_sw0tz07q/';

  static getMovies(movieSearch) async {
    final uri = Uri.parse(_imdbAPI + movieSearch);
    if (movieSearch == '') {
      return;
    }
    http.Response response = await _client.get(uri);
    Map<String, dynamic> json = jsonDecode(response.body);
    if (response.statusCode != 200) {
      return;
    }
    return json['results'];
  }

  static scrapePlot(id) async {
    final uri = Uri.parse('https://www.imdb.com/title/$id');
    await EasyLoading.show(status: 'Agregando película ...');
    final String doc =
        await http.read(uri, headers: {'Cookie': 'lc-main=es_ES'});
    BeautifulSoup bs = BeautifulSoup(doc);
    final plot = bs.find('span', class_: 'sc-16ede01-2 gXUyNh');
    EasyLoading.showSuccess('¡Película agregada!');
    return plot!.innerHtml;
  }
}
