import 'dart:convert';

class ApiResponse {
  String name;
  String slug;
  String originName;
  String posterUrl;
  String thumbUrl;
  String year;


  ApiResponse({
    required this.name,
    required this.slug,
    required this.originName,
    required this.posterUrl,
    required this.thumbUrl,
    required this.year,
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
    return ApiResponse(
      name: map['name'] as String,
      slug: map['slug'] as String,
      originName: map['origin_name'] as String,
      posterUrl: map['poster_url'] as String,
      thumbUrl: map['thumb_url'] as String,
      year: map['year'].toString(),
    );
  }

  // Convert ApiResponse to a JSON string
  String toJson() => json.encode(toMap());

  factory ApiResponse.fromJson(String source) {
    final Map<String, dynamic> jsonData = json.decode(source);
    return ApiResponse.fromMap(jsonData);
  }

}
