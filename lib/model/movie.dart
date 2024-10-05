import 'dart:convert';

import 'category.dart';
import 'episode.dart';
import 'movie/country.dart';

class Movie {
  final String id;
  final String name;
  final String originName;
  final String content;
  final String type;
  final String posterUrl;
  final String thumbUrl;
  final String time;
  final String slug;
  final String episodeCurrent;
  final String episodeTotal;
  final String quality;
  final String lang;
  final String year;
  final List<String> actor;
  final List<String> director;
  final List<Category> categories;
  final List<Country> countries;
  late Episode episodes;

  Movie({
    required this.id,
    required this.name,
    required this.originName,
    required this.content,
    required this.type,
    required this.posterUrl,
    required this.thumbUrl,
    required this.time,
    required this.slug,
    required this.episodeCurrent,
    required this.episodeTotal,
    required this.quality,
    required this.lang,
    required this.year,
    required this.actor,
    required this.director,
    required this.categories,
    required this.countries,
    required this.episodes,
  });

  // Convert Movie to Map
  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'origin_name': originName,
      'content': content,
      'type': type,
      'poster_url': posterUrl,
      'thumb_url': thumbUrl,
      'time': time,
      'slug': slug,
      'episode_current': episodeCurrent,
      'episode_total': episodeTotal,
      'quality': quality,
      'lang': lang,
      'year': year,
      'actor': actor,
      'director': director,
      'category': categories.map((e) => e.toMap()).toList(),
      'country': countries.map((e) => e.toMap()).toList(),
      'episodes': episodes.toMap(),
    };
  }

  // Create Movie from Map
  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      originName: map['origin_name'] ?? '',
      content: map['content'] ?? '',
      type: map['type'] ?? '',
      posterUrl: map['poster_url'] ?? '',
      thumbUrl: map['thumb_url'] ?? '',
      time: map['time'] ?? '',
      slug: map['slug'] ?? '',
      episodeCurrent: map['episode_current'] ?? '',
      episodeTotal: map['episode_total'] ?? '',
      quality: map['quality'] ?? '',
      lang: map['lang'] ?? '',
      year: map['year'].toString() ,
      actor: List<String>.from(map['actor'] ?? ['nodata']),
      director: List<String>.from(map['director'] ?? ['nodata']),
      categories: (map['category'] as List<dynamic>? ?? ['nodata'])
          .map((e) => Category.fromMap(e))
          .toList(),
      countries: (map['country'] as List<dynamic>? ?? [])
          .map((e) => Country.fromMap(e))
          .toList(),
      episodes: Episode.fromMap(map['episodes'] as Map<String, dynamic>? ?? {}),
    );
  }

  // Convert Movie to JSON string
  String toJson() => json.encode(toMap());

  // Create Movie from JSON string
  factory Movie.fromJson(String source) =>
      Movie.fromMap(json.decode(source) as Map<String, dynamic>);
}
