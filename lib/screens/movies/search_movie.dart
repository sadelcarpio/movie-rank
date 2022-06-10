import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_ratings/components/possible_movie_card.dart';
import 'package:movie_ratings/services/api_calls.dart';

class SearchMovie extends StatefulWidget {
  const SearchMovie({Key? key}) : super(key: key);

  @override
  State<SearchMovie> createState() => _SearchMovieState();
}

class _SearchMovieState extends State<SearchMovie> {
  late String movieSearch = '';
  late Future<dynamic> futurePossibleMovie;
  @override
  Widget build(BuildContext context) {
    futurePossibleMovie = HttpService.getMovies(movieSearch);
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.orange[500],
            elevation: 0,
            title: const Text(
              'Buscar Película',
              style: TextStyle(
                fontFamily: 'Titilium',
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Image.asset(
                      'assets/images/movie_collage_dark.jpeg',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextFormField(
                      onFieldSubmitted: (value) {
                        setState(() {
                          movieSearch = value;
                        });
                      },
                      cursorColor: Colors.orange[500],
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontFamily: 'NotoSans',
                      ),
                      decoration: InputDecoration(
                        hintText: 'Busca una película (:',
                        fillColor: Colors.white,
                        filled: true,
                        isDense: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: const BorderSide(
                              width: 1.0, color: Colors.black54),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 15.0),
                        suffixIconConstraints:
                            const BoxConstraints(maxHeight: 25, maxWidth: 33),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: SvgPicture.asset('assets/logos/search.svg',
                              color: Colors.orange[700],
                              height: 25.0,
                              width: 25.0,
                              fit: BoxFit.fill),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder(
                      future: futurePossibleMovie,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if ((snapshot.hasData) && (movieSearch != '')) {
                          return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return PossibleMovieCard(
                                    movie: snapshot.data[index]);
                              });
                        } else if (movieSearch == '') {
                          return Container();
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Colors.orange[500]!,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
