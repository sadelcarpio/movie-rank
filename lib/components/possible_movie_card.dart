import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_ratings/constants.dart';
import 'package:movie_ratings/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class PossibleMovieCard extends StatelessWidget {
  final Map movie;
  const PossibleMovieCard({Key? key, required this.movie}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Center(
          child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              blurRadius: 10.0,
              blurStyle: BlurStyle.outer,
            )
          ],
          color: const Color(0XCCF5F5F5),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  '${movie['title']} ${movie['description']}',
                  style: const TextStyle(
                    fontFamily: 'NotoSans',
                    height: 1.2,
                    fontSize: 14.0,
                    color: secondaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 30,
                  height: 30,
                  child: FloatingActionButton(
                    onPressed: () async {
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                      await Provider.of<MoviesProvider>(context, listen: false)
                          .addMovie(movie);
                      Navigator.of(context).pop();
                    },
                    backgroundColor: Colors.orange[500],
                    elevation: 10,
                    child: SvgPicture.asset(
                      'assets/logos/plus.svg',
                      width: 20.0,
                      height: 20.0,
                      color: Colors.white,
                    ),
                    heroTag: null,
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
