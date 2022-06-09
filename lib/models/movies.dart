class Movie {
  final String? title, plot, postedBy, imgUrl, year, imdbId;
  final bool? favorite;
  Movie({
    this.title,
    this.plot,
    this.postedBy,
    this.imgUrl,
    this.year,
    this.imdbId,
    this.favorite,
  });

  factory Movie.fromRTDB(Map<String, dynamic> data) {
    return Movie(
        title: data['title'],
        plot: data['plot'],
        postedBy: data['postedBy'],
        imgUrl: data['imgUrl'],
        year: data['year'],
        imdbId: data['imdbId'],
        favorite: data['favorite']);
  }
}
