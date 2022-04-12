import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_ratings/components/review_card.dart';
import 'package:movie_ratings/models/movies.dart';
import 'package:movie_ratings/models/reviews.dart';
import 'package:movie_ratings/services/api_calls.dart';

class MovieCard extends StatefulWidget {
  final Movie? movie;
  final String? name;
  const MovieCard({Key? key, this.movie, this.name}) : super(key: key);

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  double starRating = 0;
  String reviewContent = '';

  get movie => widget.movie;
  get name => widget.name;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xB3FFFFFF),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(left: Radius.circular(15.0)),
        side: BorderSide(width: 2, color: Colors.black),
      ),
      child: SizedBox(
        height: 250,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 2,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                      child: SelectableText(
                        widget.movie!.title!,
                        style: const TextStyle(
                          height: 1.0,
                          fontFamily: 'Titilium',
                          fontSize: 25.0,
                          color: Color(0xFF8E5108),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5),
                        child: SingleChildScrollView(
                          child: SelectableText(widget.movie!.plot!,
                              style: const TextStyle(
                                  height: 1.2,
                                  fontFamily: 'Titilium',
                                  fontSize: 16.0,
                                  color: Colors.black)),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextButton(
                                onPressed: () async {
                                  Future<List<dynamic>> futureReview =
                                      HttpService.fetchReviews(
                                          widget.movie!.id!);
                                  await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: SizedBox(
                                            height: 400,
                                            width: 400,
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 10),
                                                  child: Text(
                                                    'Reviews para ${widget.movie!.title}',
                                                    style: const TextStyle(
                                                      fontFamily: 'Titilium',
                                                      height: 1.2,
                                                      fontSize: 24.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: FutureBuilder<List>(
                                                      future: futureReview,
                                                      builder:
                                                          (BuildContext context,
                                                              AsyncSnapshot
                                                                  snapshot) {
                                                        if (snapshot.hasData) {
                                                          List itemList =
                                                              snapshot.data;
                                                          if (snapshot.data
                                                                  .length !=
                                                              0) {
                                                            return SingleChildScrollView(
                                                              child: ListView
                                                                  .builder(
                                                                      shrinkWrap:
                                                                          true,
                                                                      itemCount:
                                                                          itemList
                                                                              .length,
                                                                      itemBuilder:
                                                                          ((context,
                                                                              index) {
                                                                        return ReviewCard(
                                                                            review: Review(
                                                                                user: itemList[index]['user'],
                                                                                stars: itemList[index]['stars'],
                                                                                content: itemList[index]['review_content']));
                                                                      })),
                                                            );
                                                          } else {
                                                            return const Center(
                                                              child: Text(
                                                                'Parece que no hay reseñas todavia :(',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Titilium',
                                                                  height: 1.2,
                                                                  fontSize:
                                                                      20.0,
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                        } else {
                                                          return const Center(
                                                              child:
                                                                  CircularProgressIndicator());
                                                        }
                                                      }),
                                                ),
                                              ],
                                            )),
                                      );
                                    },
                                  );
                                },
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
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width <
                                                  900
                                              ? 10
                                              : 40,
                                      vertical: 5),
                                  child: Stack(
                                    children: [
                                      const Text(
                                        'Ver reseñas',
                                        style: TextStyle(
                                          fontFamily: 'Titilium',
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFFFFFFFF),
                                        ),
                                      ),
                                      Text(
                                        'Ver reseñas',
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
                              FloatingActionButton.small(
                                heroTag: null,
                                onPressed: () async {
                                  await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          content: SizedBox(
                                            height: 450,
                                            width: 400,
                                            child: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.all(10.0),
                                                    child: Text(
                                                      'Escribir reseña',
                                                      style: TextStyle(
                                                        fontFamily: 'Titilium',
                                                        height: 1.2,
                                                        fontSize: 24.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  TextFormField(
                                                    minLines: 8,
                                                    maxLines: 8,
                                                    maxLength: 300,
                                                    style: const TextStyle(
                                                        fontSize: 18.0,
                                                        fontFamily: 'Titilium'),
                                                    decoration: InputDecoration(
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        fillColor: Colors.white,
                                                        filled: true,
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        hintText:
                                                            'Escribe una reseña (:'),
                                                    onChanged: (value) {
                                                      reviewContent = value;
                                                    },
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 5, 0, 20),
                                                    child: RatingBar.builder(
                                                      initialRating: 0,
                                                      itemCount: 5,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return const Icon(
                                                          Icons.star,
                                                          color: Colors.orange,
                                                        );
                                                      },
                                                      onRatingUpdate:
                                                          (double value) {
                                                        setState(() {
                                                          starRating = value;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () async {
                                                      if (reviewContent == "") {
                                                        await EasyLoading.showInfo(
                                                            'No puedes publicar una reseña vacía');
                                                      } else {
                                                        await HttpService.createReview(
                                                            movie!.id!,
                                                            Review(
                                                                content:
                                                                    reviewContent,
                                                                stars: starRating
                                                                    .toInt(),
                                                                user: name));
                                                        Navigator.of(context)
                                                            .pop();
                                                      }
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                        color: const Color(
                                                            0xFFFF9F1C),
                                                        border: Border.all(
                                                          color: Colors.black,
                                                          width: 1,
                                                        ),
                                                      ),
                                                      child: const Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    30.0,
                                                                vertical: 0.0),
                                                        child: Text(
                                                          'LISTO',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Titilium',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 24.0,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                },
                                backgroundColor: const Color(0xffFFBF69),
                                elevation: 10,
                                child: SvgPicture.asset(
                                  'assets/logos/star.svg',
                                  width: MediaQuery.of(context)
                                              .size
                                              .width
                                              .toDouble() <
                                          900
                                      ? 20
                                      : 30,
                                  height: MediaQuery.of(context)
                                              .size
                                              .width
                                              .toDouble() <
                                          900
                                      ? 20
                                      : 30,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: CachedNetworkImage(
                memCacheHeight: 300,
                memCacheWidth: 200,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                imageUrl: widget.movie!.imgUrl!,
                fit: BoxFit.fill,
              ),
            )
          ],
        ),
      ),
    );
  }
}
