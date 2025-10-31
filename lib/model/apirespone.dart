import 'dart:convert';

class ApiResponse {
  String name;
  String slug;
  String originName;
  String posterUrl;
  String thumbUrl;
  String year;
  int? season;
  double? voteAverage;
  double? voteCount;

  ApiResponse({
    required this.name,
    required this.slug,
    required this.originName,
    required this.posterUrl,
    required this.thumbUrl,
    required this.year,
     this.season = 1,
     this.voteAverage = 0,
     this.voteCount = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'slug': slug,
      'origin_name': originName,
      'poster_url': posterUrl,
      'thumb_url': thumbUrl,
      'year': year,
    };
  }

  factory ApiResponse.fromMap(Map<String, dynamic> map) {
    final tmdb = map['tmdb'] ?? {};

    return ApiResponse(
      name: map['name'] as String,
      slug: map['slug'] as String,
      originName: map['origin_name'] as String,
      posterUrl: map['poster_url'] as String,
      thumbUrl: map['thumb_url'] as String,
      year: map['year'].toString(),
      season: (tmdb['season'] is int) ? tmdb['season'] : int.tryParse('${tmdb['season'] ?? 1}'),
      voteAverage: (tmdb['vote_average'] is num)
          ? (tmdb['vote_average'] as num).toDouble()
          : double.tryParse('${tmdb['vote_average'] ?? 0}'),
      voteCount: (tmdb['vote_count'] is num)
          ? (tmdb['vote_count'] as num).toDouble()
          : double.tryParse('${tmdb['vote_count'] ?? 0}'),
    );
  }

  // Convert ApiResponse to a JSON string
  String toJson() => json.encode(toMap());

  factory ApiResponse.fromJson(String source) {
    final Map<String, dynamic> jsonData = json.decode(source);
    return ApiResponse.fromMap(jsonData);
  }

}
