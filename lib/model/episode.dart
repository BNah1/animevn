import 'dart:convert';

class Episode {
  final String serverName;
  List<EpisodeData> serverData;

  Episode({required this.serverName, required this.serverData});

  // Convert Episode to Map
  Map<String, dynamic> toMap() {
    return {
      'server_name': serverName,
      'server_data': serverData.map((e) => e.toMap()).toList(),
    };
  }

  // Create Episode from Map
  factory Episode.fromMap(Map<String, dynamic> map) {
    return Episode(
      serverName: map['server_name'] ?? '',
      serverData: (map['server_data'] as List<dynamic>? ?? [])
          .map((e) => EpisodeData.fromMap(e))
          .toList(),
    );
  }

  // Convert Episode to JSON string
  String toJson() => json.encode(toMap());

  // Create Episode from JSON string
  factory Episode.fromJson(String source) =>
      Episode.fromMap(json.decode(source) as Map<String, dynamic>);
}

class EpisodeData {
  final String slug;
  final String link_m3u8;

  EpisodeData({required this.slug, required this.link_m3u8});

  // Convert EpisodeData to Map
  Map<String, dynamic> toMap() {
    return {
      'slug': slug,
      'link_m3u8': link_m3u8,
    };
  }

  // Create EpisodeData from Map
  factory EpisodeData.fromMap(Map<String, dynamic> map) {
    return EpisodeData(
      slug: map['slug'] ?? '',
      link_m3u8: map['link_m3u8'] ?? '',
    );
  }

  // Convert EpisodeData to JSON string
  String toJson() => json.encode(toMap());

  // Create EpisodeData from JSON string
  factory EpisodeData.fromJson(String source) =>
      EpisodeData.fromMap(json.decode(source) as Map<String, dynamic>);
}
