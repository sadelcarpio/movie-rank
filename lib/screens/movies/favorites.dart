import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:movie_ratings/components/movie_card.dart';
import 'package:movie_ratings/models/movies.dart';

class FavoritesList extends StatefulWidget {
  const FavoritesList({Key? key}) : super(key: key);

  @override
  State<FavoritesList> createState() => _FavoritesListState();
}

class _FavoritesListState extends State<FavoritesList> {
  @override
  Widget build(BuildContext context) {
    final String userId = FirebaseAuth.instance.currentUser!.uid;
    Query movies = FirebaseDatabase.instance
        .ref('usuarios/$userId/favorites')
        .orderByChild('postedAt');
    return Stack(
      children: [
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
                        List<Movie> movies =
                            event.snapshot.children.map((elem) {
                          Movie movie = Movie.fromRTDB(
                              Map<String, dynamic>.from(
                                  Map<String, dynamic>.from(
                                      elem.value as Map<dynamic, dynamic>)));
                          return movie;
                        }).toList();
                        return ListView.builder(
                          key: const PageStorageKey('favorites-list'),
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
                          ),
                        );
                      }
                    }),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
