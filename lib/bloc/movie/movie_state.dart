import 'package:animevn/model/apirespone.dart';

import '../../model/movie.dart';

abstract class MovieState {}
late Movie movie ;

class MovieInitial extends MovieState{}

class MovieLoading extends MovieState{}

class ApiLoaded extends MovieState{
  final List<ApiResponse> listApi;
  ApiLoaded(this.listApi);
}

class MovieLoaded extends MovieState{
  final Movie movie;
  MovieLoaded(this.movie);
}

class MovieError extends MovieState{
  final String message;
  MovieError(this.message);
}
