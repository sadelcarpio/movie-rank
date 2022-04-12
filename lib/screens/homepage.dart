import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
  late Future<List<dynamic>> futureMovie;
  @override
  void initState() {
    super.initState();
  }

  get name => widget.name;
  @override
  Widget build(BuildContext context) {
    futureMovie = HttpService.fetchMovies();
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                'assets/images/movie_collage_dark.jpeg',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            alignment: Alignment.bottomLeft,
                            elevation: 0,
                            padding: const EdgeInsets.all(0.0),
                            primary: Colors.black.withOpacity(0.0)),
                        onPressed: () async {
                          await showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: SizedBox(
                                    width: 300,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.0),
                                          child: Text(
                                            '¿Salir?',
                                            style: TextStyle(
                                                fontFamily: 'Titilium',
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                fixedSize: const Size(100, 40),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5,
                                                        vertical: 5),
                                                backgroundColor:
                                                    const Color(0xAAFF9F1C),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  side: const BorderSide(),
                                                ),
                                                elevation: 10,
                                              ),
                                              onPressed: () async {
                                                SharedPreferences prefs =
                                                    await SharedPreferences
                                                        .getInstance();
                                                prefs.remove('user');
                                                if (!mounted) return;
                                                Navigator.of(context).pop();
                                                await Navigator.pushReplacement(
                                                  context,
                                                  CupertinoPageRoute(
                                                    builder: (context) =>
                                                        const LoginPage(
                                                            title: 'Login'),
                                                  ),
                                                );
                                              },
                                              child: const Text(
                                                'Sí',
                                                style: TextStyle(
                                                  fontFamily: 'Titilium',
                                                  fontSize: 24.0,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                fixedSize: const Size(100, 40),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5,
                                                        vertical: 5),
                                                backgroundColor:
                                                    const Color(0xFFFF9F1C),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  side: const BorderSide(),
                                                ),
                                                elevation: 10,
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text(
                                                'No',
                                                style: TextStyle(
                                                  fontFamily: 'Titilium',
                                                  fontSize: 24.0,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                        child: SvgPicture.asset(
                          'assets/logos/logout.svg',
                        ),
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              alignment: Alignment.bottomLeft,
                              elevation: 0,
                              padding: const EdgeInsets.all(0.0),
                              primary: Colors.black.withOpacity(0.0)),
                          onPressed: () {},
                          child: const Icon(Icons.settings,
                              size: 40, color: Colors.white)),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0.0, 30.0, 30.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width < 900
                          ? MediaQuery.of(context).size.width * 0.8
                          : MediaQuery.of(context).size.width * 0.5,
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
                                child: SvgPicture.asset(
                                    'assets/logos/search.svg',
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
                                          shrinkWrap: true,
                                          itemCount: searchResult.length,
                                          itemBuilder: (BuildContext context,
                                                  int index) =>
                                              PossibleMovieCard(
                                            movie: Movie(
                                                id: searchResult[index]['id']
                                                    .toString(),
                                                title: searchResult[index]
                                                        ['title']
                                                    .toString(),
                                                year: searchResult[index]
                                                        ['description']
                                                    .toString(),
                                                imgUrl: searchResult[index]
                                                    ['image']),
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
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        setState(() {});
                      },
                      child: RawScrollbar(
                        isAlwaysShown: true,
                        thumbColor: Colors.white,
                        shape: const StadiumBorder(),
                        thickness: 10,
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          primary: true,
                          padding: EdgeInsets.symmetric(
                              vertical: 0,
                              horizontal:
                                  MediaQuery.of(context).size.width.toDouble() <
                                          900
                                      ? 20
                                      : 80),
                          child: FutureBuilder<List>(
                              future: futureMovie,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  List itemList =
                                      snapshot.data!.reversed.toList();
                                  return AlignedGridView.count(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: itemList.length,
                                    crossAxisCount: MediaQuery.of(context)
                                                .size
                                                .width
                                                .toDouble() <
                                            900
                                        ? 1
                                        : 2,
                                    mainAxisSpacing: 4,
                                    crossAxisSpacing: 20,
                                    itemBuilder: (context, index) {
                                      return MovieCard(
                                        name: name,
                                        movie: Movie(
                                          id: itemList[index]['imdb_id'],
                                          title: itemList[index]['title'],
                                          imgUrl: itemList[index]['img_url'],
                                          plot: itemList[index]['plot'],
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  return Container();
                                }
                              }),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
