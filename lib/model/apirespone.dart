import 'episode.dart';
import 'movie.dart';

class ApiResponse {
  final bool status;
  final String msg;
  final Movie movie;
  final Episode episodes;

  ApiResponse({
    required this.status,
    required this.msg,
    required this.movie,
    required this.episodes,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      status: json['status'],
      msg: json['msg'],
      movie: Movie.fromJson(json['movie']),
      episodes: Episode.fromJson(json['episodes']),
    );
  }
}
