import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_ratings/models/reviews.dart';

class ReviewCard extends StatelessWidget {
  final Review? review;
  const ReviewCard({Key? key, this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xffFFBF69),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
        side: BorderSide(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
            child: SelectableText(
              review!.user!,
              style: const TextStyle(
                  height: 1.5,
                  fontFamily: 'Titilium',
                  fontSize: 22.0,
                  color: Color(0xFF8E5108),
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 2, 15, 10),
            child: SelectableText(
              '"${review!.content!}"',
              style: const TextStyle(
                  height: 1.2,
                  fontFamily: 'Titilium',
                  fontSize: 16.0,
                  fontStyle: FontStyle.italic,
                  color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 2, 15, 10),
            child: RatingBarIndicator(
              rating: review!.stars!.toDouble(),
              itemBuilder: (BuildContext context, int index) {
                return const Icon(
                  Icons.star,
                  color: Colors.orange,
                );
              },
              itemCount: 5,
              itemSize: 30.0,
              direction: Axis.horizontal,
            ),
          ),
        ],
      ),
    );
  }
}
