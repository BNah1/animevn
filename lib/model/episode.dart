class Episode {
  final String serverName;
  final List<EpisodeData> serverData;

  Episode({
    required this.serverName,
    required this.serverData,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      serverName: json['server_name'],
      serverData: (json['server_data'] as List)
          .map((e) => EpisodeData.fromJson(e))
          .toList(),
    );
  }
}

class EpisodeData {
  final String name;
  final String slug;
  final String filename;
  final String linkEmbed;
  final String linkM3u8;

  EpisodeData({
    required this.name,
    required this.slug,
    required this.filename,
    required this.linkEmbed,
    required this.linkM3u8,
  });

  factory EpisodeData.fromJson(Map<String, dynamic> json) {
    return EpisodeData(
      name: json['name'],
      slug: json['slug'],
      filename: json['filename'],
      linkEmbed: json['link_embed'],
      linkM3u8: json['link_m3u8'],
    );
  }
}
