import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_ratings/models/movies.dart';

class MovieCard extends StatelessWidget {
  final Movie? movie;
  final Function? press;
  const MovieCard({
    Key? key,
    this.movie,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xB3FFFFFF),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(left: Radius.circular(15.0)),
        side: BorderSide(width: 2, color: Colors.black),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            flex: 2,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5.0, vertical: 10.0),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 0),
                    child: SelectableText(movie!.plot!,
                        style: const TextStyle(
                            height: 1.2,
                            fontFamily: 'Titilium',
                            fontSize: 16.0,
                            color: Colors.black)),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            backgroundColor: const Color(0xFFFF9F1C),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: const BorderSide(),
                            ),
                            elevation: 10,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 5),
                            child: Stack(
                              children: [
                                const Text(
                                  'Ver calificaciones',
                                  style: TextStyle(
                                    fontFamily: 'Titilium',
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFFFFFFF),
                                  ),
                                ),
                                Text(
                                  'Ver calificaciones',
                                  style: TextStyle(
                                    fontFamily: 'Titilium',
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    foreground: Paint()
                                      ..style = PaintingStyle.stroke
                                      ..strokeWidth = 1
                                      ..color = Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        FloatingActionButton(
                          heroTag: null,
                          onPressed: () {},
                          backgroundColor: const Color(0xffFFBF69),
                          elevation: 10,
                          child: SvgPicture.asset(
                            'assets/logos/star.svg',
                            width: 30,
                            height: 30,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Image.asset(
              movie!.imgUrl!,
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
    );
  }
}
