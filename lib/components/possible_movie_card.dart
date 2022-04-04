import 'package:flutter/material.dart';
import 'package:movie_ratings/models/movies.dart';

class PossibleMovieCard extends StatelessWidget {
  final Movie? movie;
  final Function? press;
  const PossibleMovieCard({
    Key? key,
    this.movie,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFFFFFFF),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(left: Radius.circular(15.0)),
        side: BorderSide(width: 2, color: Colors.black),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: SelectableText(
                movie!.title!,
                style: const TextStyle(
                  height: 1.5,
                  fontFamily: 'Titilium',
                  fontSize: 25.0,
                  color: Color(0xFF8E5108),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
              child: SelectableText(movie!.year!,
                  style: const TextStyle(
                      height: 1.2,
                      fontFamily: 'Titilium',
                      fontSize: 16.0,
                      color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}
