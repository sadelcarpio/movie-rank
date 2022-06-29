import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_ratings/constants.dart';
import 'package:movie_ratings/models/reviews.dart';

class ReviewCard extends StatelessWidget {
  final Review review;
  const ReviewCard({Key? key, required this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 10.0,
        color: const Color(0xB3FFFFFF),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
              child: Text(
                review.postedBy!,
                style: const TextStyle(
                    fontFamily: 'Titilium',
                    fontSize: 18.0,
                    color: secondaryColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 2, 15, 10),
              child: Text(
                '"${review.content!}"',
                style: const TextStyle(
                    fontFamily: 'NotoSans',
                    fontSize: 13.0,
                    fontStyle: FontStyle.italic,
                    color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 2, 15, 10),
              child: RatingBarIndicator(
                rating: review.stars!,
                itemBuilder: (BuildContext context, int index) {
                  return Icon(
                    Icons.star,
                    color: Colors.orange[500],
                  );
                },
                itemCount: 5,
                itemSize: 30.0,
                direction: Axis.horizontal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
