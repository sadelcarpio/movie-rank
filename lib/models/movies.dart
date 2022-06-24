class Movie {
  final String? title, plot, postedBy, imgUrl, year, imdbId;
  final int? postedAt;
  Movie(
      {this.title,
      this.plot,
      this.postedBy,
      this.imgUrl,
      this.year,
      this.imdbId,
      this.postedAt});

  factory Movie.fromRTDB(Map<String, dynamic> data) {
    return Movie(
        title: data['title'],
        plot: data['plot'],
        postedBy: data['postedBy'],
        imgUrl: data['imgUrl'],
        year: data['year'],
        imdbId: data['imdbId'],
        postedAt: data['postedAt']);
  }
}
