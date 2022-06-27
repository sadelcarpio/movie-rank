import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_ratings/components/movie_card.dart';
import 'package:movie_ratings/models/movies.dart';

class MoviesList extends StatelessWidget {
  const MoviesList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Query movies =
        FirebaseDatabase.instance.ref('peliculas').orderByChild('postedAt');
    return Stack(children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: StreamBuilder(
                  stream: movies.onValue,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.snapshot.value == null) {
                        return Container();
                      }
                      DatabaseEvent event = snapshot.data;
                      List<Movie> movies = event.snapshot.children.map((elem) {
                        Movie movie = Movie.fromRTDB(Map<String, dynamic>.from(
                            Map<String, dynamic>.from(
                                elem.value as Map<dynamic, dynamic>)));
                        return movie;
                      }).toList();
                      return ListView.builder(
                        key: const PageStorageKey('movies-list'),
                        itemCount: movies.length,
                        itemBuilder: (BuildContext context, int index) {
                          Movie movie = movies[movies.length - index - 1];
                          return MovieCard(movie: movie);
                        },
                      );
                    } else {
                      return Center(
                          child: CircularProgressIndicator(
                        color: Colors.orange[500],
                      ));
                    }
                  }),
            ),
          ),
        ],
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0, bottom: 20.0),
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/newMovie');
                  },
                  backgroundColor: Colors.orange[500],
                  elevation: 10,
                  child: SvgPicture.asset(
                    'assets/logos/plus.svg',
                    height: 35,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )
        ],
      )
    ]);
  }
}
