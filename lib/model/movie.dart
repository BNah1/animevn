import 'category.dart';
import 'movie/country.dart';

class Movie {
  final String id;
  final String name;
  final String originName;
  final String content;
  final String type;
  final String status;
  final String posterUrl;
  final String thumbUrl;
  final String time;
  final String episodeCurrent;
  final String episodeTotal;
  final String quality;
  final String lang;
  final String year;
  final List<String> actor;
  final List<String> director;
  final List<Category> categories;
  final List<Country> countries;

  Movie({
    required this.id,
    required this.name,
    required this.originName,
    required this.content,
    required this.type,
    required this.status,
    required this.posterUrl,
    required this.thumbUrl,
    required this.time,
    required this.episodeCurrent,
    required this.episodeTotal,
    required this.quality,
    required this.lang,
    required this.year,
    required this.actor,
    required this.director,
    required this.categories,
    required this.countries,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['_id'],
      name: json['name'],
      originName: json['origin_name'],
      content: json['content'],
      type: json['type'],
      status: json['status'],
      posterUrl: json['poster_url'],
      thumbUrl: json['thumb_url'],
      time: json['time'],
      episodeCurrent: json['episode_current'],
      episodeTotal: json['episode_total'],
      quality: json['quality'],
      lang: json['lang'],
      year: json['year'],
      actor: List<String>.from(json['actor']),
      director: List<String>.from(json['director']),
      categories: (json['category'] as List)
          .map((e) => Category.fromJson(e))
          .toList(),
      countries: (json['country'] as List)
          .map((e) => Country.fromJson(e))
          .toList(),
    );
  }
}