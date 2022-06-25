import 'package:flutter/cupertino.dart';
import 'package:movie_ratings/screens/movies/homepage.dart';
import 'package:movie_ratings/screens/movies/reviews.dart';
import 'package:movie_ratings/screens/movies/search_movie.dart';
import 'package:movie_ratings/screens/movies/write_review.dart';

class HomeNavigator extends StatefulWidget {
  const HomeNavigator({Key? key}) : super(key: key);

  @override
  State<HomeNavigator> createState() => _HomeNavigatorState();
}

class _HomeNavigatorState extends State<HomeNavigator>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<NavigatorState> _key = GlobalKey<NavigatorState>();
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WillPopScope(
      onWillPop: () async {
        return !await _key.currentState!.maybePop();
      },
      child: Navigator(
        key: _key,
        onGenerateRoute: (RouteSettings settings) {
          return CupertinoPageRoute(
              settings: settings,
              builder: (BuildContext context) {
                switch (settings.name) {
                  case '/':
                    return const HomePage();
                  case '/reviews':
                    return const ReviewsPage();
                  case '/newMovie':
                    return const SearchMovie();
                  case '/newReview':
                    return const WriteReview();
                  default:
                    return const HomePage();
                }
              });
        },
      ),
    );
  }
}
