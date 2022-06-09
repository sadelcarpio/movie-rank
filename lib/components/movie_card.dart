import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_ratings/constants.dart';
import 'package:movie_ratings/models/movies.dart';
import 'package:movie_ratings/providers/movies_provider.dart';
import 'package:movie_ratings/screens/movies/reviews.dart';
import 'package:movie_ratings/screens/movies/write_review.dart';
import 'package:provider/provider.dart';

class MovieCard extends StatefulWidget {
  final String imdbId;
  const MovieCard({
    Key? key,
    required this.imdbId,
  }) : super(key: key);

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  get imdbId => widget.imdbId;
  @override
  Widget build(BuildContext context) {
    final Movie movie =
        Provider.of<MoviesProvider>(context, listen: true).getById(imdbId);
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
                              child: Consumer<MoviesProvider>(
                                  builder: (context, model, child) {
                                return FloatingActionButton.small(
                                  heroTag: null,
                                  onPressed: () async {
                                    model.toggleFavorite(movie.imdbId!);
                                  },
                                  backgroundColor: mainColor,
                                  elevation: 10,
                                  child: movie.favorite!
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
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) =>
                                              const ReviewsPage()));
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
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) =>
                                              const WriteReview()));
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
}
