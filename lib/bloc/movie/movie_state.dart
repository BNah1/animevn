import 'package:animevn/model/apirespone.dart';

abstract class MovieState {}

class MovieInitial extends MovieState{}

class MovieLoading extends MovieState{}

class MovieLoaded extends MovieState{
  final ApiResponse apiResponse;
  MovieLoaded(this.apiResponse);
}

class MovieError extends MovieState{
  final String message;
  MovieError(this.message);
}
