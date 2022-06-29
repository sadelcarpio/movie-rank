import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_ratings/constants.dart';
import 'package:movie_ratings/models/movies.dart';

class WriteReview extends StatefulWidget {
  static const routeName = '/newReview';
  final Movie movie;
  const WriteReview({Key? key, required this.movie}) : super(key: key);

  @override
  State<WriteReview> createState() => _WriteReviewState();
}

class _WriteReviewState extends State<WriteReview> {
  late String content = '';
  late double stars = 0.0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: mainColor,
          appBar: AppBar(
            backgroundColor: Colors.orange[500],
            elevation: 10,
            titleSpacing: -10,
            title: const Text(
              'Escribir reseña',
              style: TextStyle(
                fontFamily: 'Titilium',
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      '¿Que te pareció ${widget.movie.title}?',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: secondaryColor,
                        fontSize: 24,
                        fontFamily: 'Titilium',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  RatingBar.builder(
                    allowHalfRating: true,
                    onRatingUpdate: (double value) {
                      setState(() {
                        stars = value;
                      });
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return Icon(
                        Icons.star,
                        color: Colors.orange[500],
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: TextFormField(
                      cursorColor: Colors.orange[500],
                      maxLines: 6,
                      maxLength: 400,
                      onChanged: (value) {
                        setState(() {
                          content = value;
                        });
                      },
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontFamily: 'NotoSans',
                      ),
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        hintText: 'Escribe una reseña',
                        hintStyle: const TextStyle(fontSize: 14.0),
                      ),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      fixedSize: const Size(200, 40),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      backgroundColor: Colors.orange[500],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      elevation: 10,
                    ),
                    child: const Text(
                      'ENVIAR RESEÑA',
                      style: TextStyle(
                        fontFamily: 'Titilium',
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                    onPressed: () async {
                      // FocusScopeNode currentFocus = FocusScope.of(context);
                      // if (!currentFocus.hasPrimaryFocus) {
                      //   currentFocus.unfocus();
                      // }
                      uploadComment(content, stars, context);
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void uploadComment(content, stars, context) async {
    if (content == '') {
      EasyLoading.showError('Reseña vacía!');
      return;
    }
    await EasyLoading.show(status: 'Subiendo reseña ...');
    DatabaseReference ref = FirebaseDatabase.instance
        .ref('peliculas/${widget.movie.imdbId}/reviews');
    String uid = FirebaseAuth.instance.currentUser!.uid;
    ref.child(uid).update({
      'content': content,
      'stars': stars,
      'postedBy': FirebaseAuth.instance.currentUser!.displayName!
    });
    EasyLoading.showSuccess('Reseña subida!',
        duration: const Duration(seconds: 1));
    Navigator.of(context).pop();
  }
}
