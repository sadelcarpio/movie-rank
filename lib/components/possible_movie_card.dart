import 'package:flutter/material.dart';
import 'package:movie_ratings/models/movies.dart';

class PossibleMovieCard extends StatelessWidget {
  final Movie? movie;
  final String? name;
  const PossibleMovieCard({
    Key? key,
    this.movie,
    this.name,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Text(
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
                    child: Text(movie!.year!,
                        style: const TextStyle(
                            height: 1.2,
                            fontFamily: 'Titilium',
                            fontSize: 16.0,
                            color: Colors.black)),
                  ),
                ],
              ),
            ),
            FloatingActionButton.small(
              onPressed: () {},
              backgroundColor: const Color(0xFFFF9F1C),
              child: const Icon(Icons.add, size: 20),
            )
          ],
        ),
      ),
    );
  }
}
