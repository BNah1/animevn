import 'dart:convert';

class Country {
  final String id;
  final String name;
  final String slug;

  Country({
    required this.id,
    required this.name,
    required this.slug,
  });

  // Convert Country to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
    };
  }

  // Create Country from Map
  factory Country.fromMap(Map<String, dynamic> map) {
    return Country(
      id: map['id'],
      name: map['name'],
      slug: map['slug'],
    );
  }

  // Convert Country to JSON string
  String toJson() => json.encode(toMap());

  // Create Country from JSON string
  factory Country.fromJson(String source) =>
      Country.fromMap(json.decode(source) as Map<String, dynamic>);
}
