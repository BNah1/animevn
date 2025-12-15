import 'package:animevn/model/apirespone.dart';


abstract class MovieState {}

class MovieInitial extends MovieState{}

class MovieLoading extends MovieState{}

class ApiLoaded extends MovieState{
  final List<ApiResponse> listApi;
  ApiLoaded(this.listApi);
}


class MovieError extends MovieState{
  final String message;
  MovieError(this.message);
}
