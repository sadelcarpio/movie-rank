class Movie {
  final String? title, plot, imgUrl, year, id;
  Movie({this.title, this.plot, this.imgUrl, this.year, this.id});
}

List<Movie> movies = [
  Movie(
    imgUrl: 'assets/images/batman.jpeg',
    title: 'The Batman',
    plot:
        "Cuando Enigma, un sádico asesino en serie, comienza a asesinar a las principales figuras políticas de Gotham, Batman se ve obligado a investigar la corrupción oculta de la ciudad y a cuestionar la participación de su familia.",
  ),
  Movie(
    imgUrl: 'assets/images/coda.jpeg',
    title: 'CODA: Los sonidos del silencio',
    plot:
        'Como hija de adultos sordos, Ruby es la única persona oyente en su familia. Cuando el negocio pesquero de la familia se ve amenazado, Ruby se encuentra dividida entre perseguir su amor por la música y su miedo a abandonar a sus padres.',
  ),
  Movie(
    imgUrl: 'assets/images/batman.jpeg',
    title: 'The Batman',
    plot:
        "Cuando Enigma, un sádico asesino en serie, comienza a asesinar a las principales figuras políticas de Gotham, Batman se ve obligado a investigar la corrupción oculta de la ciudad y a cuestionar la participación de su familia.",
  ),
  Movie(
    imgUrl: 'assets/images/coda.jpeg',
    title: 'CODA: Los sonidos del silencio',
    plot:
        'Como hija de adultos sordos, Ruby es la única persona oyente en su familia. Cuando el negocio pesquero de la familia se ve amenazado, Ruby se encuentra dividida entre perseguir su amor por la música y su miedo a abandonar a sus padres.',
  ),
];
