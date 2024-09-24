class Country {
  final String id;
  final String name;
  final String slug;

  Country({required this.id, required this.name, required this.slug});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
    );
  }
}