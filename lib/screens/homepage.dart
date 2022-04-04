import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_ratings/components/movie_card.dart';
import 'package:movie_ratings/components/possible_movie_card.dart';
import 'package:movie_ratings/models/movies.dart';
import 'package:movie_ratings/screens/login_page.dart';
import 'package:movie_ratings/services/api_calls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.name}) : super(key: key);
  final String name;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String movieString;
  late List<dynamic> searchResult;
  get name => widget.name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              'assets/images/movie_collage_dark.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0x00FFFFFF),
                          elevation: 0,
                        ),
                        onPressed: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.remove('name');
                          if (!mounted) return;
                          await Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const LoginPage(title: 'Login')));
                        },
                        child: SvgPicture.asset('assets/logos/logout.svg'),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0.0, 30.0, 30.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: TextFormField(
                      style: const TextStyle(
                        fontFamily: 'Titilium',
                        fontSize: 18.0,
                      ),
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: const BorderSide(
                                  width: 2.0, color: Colors.black)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: const BorderSide(
                                  width: 2.0, color: Colors.blue)),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 30,
                              width: 30,
                              child: SvgPicture.asset('assets/logos/search.svg',
                                  fit: BoxFit.cover),
                            ),
                          ),
                          hintText:
                              '$name, busca una película para calificar :)',
                          contentPadding: const EdgeInsets.all(10.0),
                          isDense: true,
                          hintStyle: const TextStyle(fontSize: 18)),
                      onChanged: (value) {
                        movieString = value;
                      },
                      onFieldSubmitted: (value) async {
                        searchResult =
                            await HttpService.searchMovie(movieString);
                        await showDialog(
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: SizedBox(
                                width: 400,
                                height: 400,
                                child: Column(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Text(
                                        'Resultados',
                                        style: TextStyle(
                                          fontFamily: 'Titilium',
                                          fontSize: 36.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: searchResult.length,
                                        itemBuilder:
                                            (BuildContext context, int index) =>
                                                PossibleMovieCard(
                                          movie: Movie(
                                              id: searchResult[index]['id']
                                                  .toString(),
                                              title: searchResult[index]
                                                      ['title']
                                                  .toString(),
                                              year: searchResult[index]
                                                      ['description']
                                                  .toString()),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          context: context,
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 80),
                    child: SingleChildScrollView(
                      child: LayoutGrid(
                        columnSizes: [1.fr, 1.fr],
                        rowSizes: const [auto, auto],
                        rowGap: 10,
                        columnGap: 40,
                        children: [
                          for (var movie in movies) MovieCard(movie: movie)
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
