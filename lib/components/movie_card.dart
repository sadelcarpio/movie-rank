import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_ratings/constants.dart';
import 'package:movie_ratings/providers/favorites_provider.dart';
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
    final movie = Provider.of<MoviesProvider>(context).getById(imdbId);
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
                        movie.title,
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
                          movie.plot,
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 30,
                            height: 30,
                            child: FloatingActionButton.small(
                              heroTag: null,
                              onPressed: () {},
                              backgroundColor: mainColor,
                              elevation: 10,
                              child: SvgPicture.asset(
                                'assets/logos/eye.svg',
                                width: 25,
                                height: 25,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 30,
                            height: 30,
                            child: FloatingActionButton.small(
                              heroTag: null,
                              onPressed: () {},
                              backgroundColor: mainColor,
                              elevation: 10,
                              child: SvgPicture.asset(
                                'assets/logos/star.svg',
                                width: 20,
                                height: 20,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 30,
                            height: 30,
                            child: FloatingActionButton.small(
                              heroTag: null,
                              onPressed: () {
                                Provider.of<MoviesProvider>(context,
                                        listen: false)
                                    .toggleFavorite(widget.imdbId);
                              },
                              backgroundColor: mainColor,
                              elevation: 10,
                              child: movie.favorite
                                  ? const Icon(
                                      Icons.favorite_rounded,
                                      color: Colors.red,
                                      size: 20.0,
                                    )
                                  : SvgPicture.asset(
                                      'assets/logos/heart.svg',
                                      width: 20,
                                      height: 20,
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
                // child: CachedNetworkImage(
                //   memCacheHeight: 300,
                //   memCacheWidth: 200,
                //   placeholder: (context, url) =>
                //       const CircularProgressIndicator(),
                //   imageUrl: widget.movie!.imgUrl!,
                //   fit: BoxFit.fill,
                // ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.horizontal(
                    right: Radius.circular(cardRadius),
                  ),
                  child: Image.asset(
                    movie.imgUrl,
                    fit: BoxFit.cover,
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
