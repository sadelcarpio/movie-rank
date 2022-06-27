import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_ratings/constants.dart';
import 'package:movie_ratings/models/movies.dart';

class MovieCard extends StatefulWidget {
  final Movie movie;
  const MovieCard({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  get movie => widget.movie;
  late Map? favorites;
  late DatabaseReference ref;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: const Color(0xB3FFFFFF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cardRadius),
        ),
        child: SizedBox(
          height: 160,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0.0),
                      child: Text(
                        movie.title!,
                        style: const TextStyle(
                          height: 1.2,
                          fontFamily: 'Titilium',
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF502700),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(12.0, 4.0, 10.0, 0.0),
                        child: Text(
                          movie.plot!,
                          style: const TextStyle(
                            height: 1.2,
                            fontSize: 13.0,
                            fontFamily: 'Titilium',
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 5,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            flex: 2,
                            child: SizedBox(
                              width: 28,
                              height: 28,
                              child: FutureBuilder(
                                  future: isFavorite(movie),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return FloatingActionButton.small(
                                        heroTag: null,
                                        onPressed: () {
                                          toggleFavorite(movie);
                                          setState(() {});
                                        },
                                        backgroundColor: mainColor,
                                        elevation: 10,
                                        child: snapshot.data == true
                                            ? const Icon(
                                                Icons.favorite_rounded,
                                                color: Colors.red,
                                                size: 18.0,
                                              )
                                            : SvgPicture.asset(
                                                'assets/logos/heart.svg',
                                                width: 18,
                                                height: 18,
                                              ),
                                      );
                                    } else {
                                      return Container();
                                    }
                                  }),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: SizedBox(
                              width: 28,
                              height: 28,
                              child: FloatingActionButton.small(
                                heroTag: null,
                                onPressed: () {
                                  Navigator.pushNamed(context, '/reviews');
                                },
                                backgroundColor: mainColor,
                                elevation: 10,
                                child: SvgPicture.asset(
                                  'assets/logos/eye.svg',
                                  width: 22,
                                  height: 22,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: SizedBox(
                              width: 28,
                              height: 28,
                              child: FloatingActionButton.small(
                                heroTag: null,
                                onPressed: () {
                                  Navigator.pushNamed(context, '/newReview');
                                },
                                backgroundColor: mainColor,
                                elevation: 10,
                                child: SvgPicture.asset(
                                  'assets/logos/star.svg',
                                  width: 18,
                                  height: 18,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Text(
                                'Subido por:  ${movie.postedBy}',
                                style: const TextStyle(
                                  fontFamily: 'Titilium',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.0,
                                  height: 1.0,
                                  color: secondaryColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: ClipRRect(
                  borderRadius: const BorderRadius.horizontal(
                    right: Radius.circular(cardRadius),
                  ),
                  child: CachedNetworkImage(
                    placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(
                      color: Colors.orange[500]!,
                    )),
                    imageUrl: movie.imgUrl!,
                    fit: BoxFit.fill,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> isFavorite(Movie movie) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    ref = FirebaseDatabase.instance.ref('usuarios/$userId');
    DatabaseEvent event = await ref.child('favorites').once();
    favorites = Map<String, dynamic>.from(
        (event.snapshot.value ?? {}) as Map<dynamic, dynamic>);
    return favorites!.keys.contains(movie.imdbId) ? true : false;
  }

  void toggleFavorite(Movie movie) async {
    if (favorites!.isEmpty) {
      ref.update({
        'favorites': {movie.imdbId: movie.toMap()}
      });
    } else {
      if (favorites!.keys.contains(movie.imdbId)) {
        favorites!.remove(movie.imdbId);
        ref.update({'favorites': favorites});
      } else {
        favorites![movie.imdbId] = movie.toMap();
        ref.update({'favorites': favorites});
      }
    }
  }
}
