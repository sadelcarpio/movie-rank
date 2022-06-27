import 'package:flutter/material.dart';
import 'package:movie_ratings/constants.dart';
import 'package:movie_ratings/models/movies.dart';

class WriteReview extends StatelessWidget {
  static const routeName = '/newReview';
  final Movie movie;
  const WriteReview({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange[500],
          elevation: 10,
          titleSpacing: -10,
          title: Text(
            movie.title!,
            style: const TextStyle(
              fontFamily: 'Titilium',
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Container(
          color: mainColor,
        ),
      ),
    );
  }
}
