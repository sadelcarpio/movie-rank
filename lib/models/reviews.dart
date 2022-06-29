class Review {
  final String? content, postedBy;
  final double? stars;
  Review({this.content, this.stars, this.postedBy});

  factory Review.fromRTDB(Map<String, dynamic> data) {
    return Review(
        content: data['content'],
        stars: data['stars'].toDouble(),
        postedBy: data['postedBy']);
  }
}
