abstract class MovieEvent {}

class LoadMovieByUrl extends MovieEvent{
  final String url;
  LoadMovieByUrl(this.url);
}

class LoadApiResponse extends MovieEvent{
  final String url;
  LoadApiResponse(this.url);
}
class SearchMovies extends MovieEvent{
  final String words;
  SearchMovies(this.words);
}

class LoadApiResponseWithPage extends MovieEvent{
  final String url;
  LoadApiResponseWithPage(this.url);
}

