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
  final String slug;
  final String linkEmbed;

  EpisodeData({
    required this.slug,
    required this.linkEmbed,
  });

  factory EpisodeData.fromJson(Map<String, dynamic> json) {
    return EpisodeData(
      slug: json['slug'],
      linkEmbed: json['link_m3u8'],
    );
  }
}
