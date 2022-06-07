class Movie {
  final String? title, plot, postedBy, imgUrl, year, imdbId;
  bool favorite = false;
  Movie({
    this.title,
    this.plot,
    this.postedBy,
    this.imgUrl,
    this.year,
    this.imdbId,
  });
}

List<Movie> movies = [
  Movie(
    title: 'The Batman',
    plot:
        'Cuando Enigma, un sádico asesino en serie, comienza a asesinar a las principales figuras políticas de Gotham, Batman se ve obligado a investigar la corrupción oculta de la ciudad y a cuestionar la participación de su familia.',
    postedBy: 'sergio',
    imgUrl: 'assets/images/batman.jpeg',
    imdbId: '1',
    year: '2018',
  ),
  Movie(
    title: 'Coda',
    plot:
        'Como hija de adultos sordos, Ruby es la única persona oyente en su familia. Cuando el negocio pesquero de la familia se ve amenazado, Ruby se encuentra dividida entre perseguir su amor por la música y su miedo a abandonar a sus padres.',
    postedBy: 'sergio',
    imgUrl: 'assets/images/coda.jpeg',
    imdbId: '2',
    year: '2021',
  ),
  Movie(
      title: 'The Batman',
      plot:
          'Cuando Enigma, un sádico asesino en serie, comienza a asesinar a las principales figuras políticas de Gotham, Batman se ve obligado a investigar la corrupción oculta de la ciudad y a cuestionar la participación de su familia.',
      postedBy: 'sergio',
      imgUrl: 'assets/images/batman.jpeg',
      imdbId: '3',
      year: '2021'),
  Movie(
      title: 'The Batman',
      plot:
          'Cuando Enigma, un sádico asesino en serie, comienza a asesinar a las principales figuras políticas de Gotham, Batman se ve obligado a investigar la corrupción oculta de la ciudad y a cuestionar la participación de su familia.',
      postedBy: 'sergio',
      imgUrl: 'assets/images/batman.jpeg',
      imdbId: '4',
      year: '2021')
];
