class Tmdb {
  final String? type;
  final String? id;
  final String? season;
  final double voteAverage;
  final int voteCount;

  Tmdb({this.type, this.id, this.season, required this.voteAverage, required this.voteCount});

  factory Tmdb.fromJson(Map<String, dynamic> json) {
    return Tmdb(
      type: json['type'],
      id: json['id'],
      season: json['season'],
      voteAverage: json['vote_average']?.toDouble() ?? 0.0,
      voteCount: json['vote_count'] ?? 0,
    );
  }
}