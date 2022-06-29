import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:movie_ratings/components/review_card.dart';
import 'package:movie_ratings/constants.dart';
import 'package:movie_ratings/models/movies.dart';
import 'package:movie_ratings/models/reviews.dart';

class ReviewsPage extends StatelessWidget {
  static const routeName = '/reviews';
  final Movie movie;
  const ReviewsPage({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Query reviews =
        FirebaseDatabase.instance.ref('peliculas/${movie.imdbId}/reviews');
    return SafeArea(
      child: Scaffold(
        backgroundColor: mainColor,
        appBar: AppBar(
          backgroundColor: Colors.orange[500],
          elevation: 10,
          title: const Text(
            'Reseñas',
            style: TextStyle(
              fontFamily: 'Titilium',
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                movie.title!,
                style: const TextStyle(
                    fontSize: 24.0,
                    color: secondaryColor,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'NotoSans'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Text(
                movie.plot!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 14.0,
                    color: secondaryColor,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'NotoSans'),
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
                child: StreamBuilder(
                    stream: reviews.onValue,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.snapshot.value == null) {
                          return Container();
                        }
                        DatabaseEvent event = snapshot.data;
                        List<Review> reviews =
                            event.snapshot.children.map((elem) {
                          Review review = Review.fromRTDB(
                              Map<String, dynamic>.from(
                                  Map<String, dynamic>.from(
                                      elem.value as Map<dynamic, dynamic>)));
                          return review;
                        }).toList();
                        return ListView.builder(
                          itemCount: reviews.length,
                          itemBuilder: (BuildContext context, int index) {
                            Review review = reviews[index];
                            return ReviewCard(review: review);
                          },
                        );
                      } else {
                        return Container();
                      }
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
