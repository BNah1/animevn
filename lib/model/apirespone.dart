import 'episode.dart';
import 'movie.dart';

class ApiResponse {
  final bool status;
  final String msg;
  final Movie movie;
  final List<Episode> episodes;

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
      episodes: (json['episodes'] as List)
          .map((e) => Episode.fromJson(e))
          .toList(),
    );
  }
}
