import 'dart:convert';

class Poster {
  String id;
  String name;
  String image;

  Poster({required this.id, required this.name, required this.image});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
    };
  }

  factory Poster.fromMap(Map<String, dynamic> map) {
    return Poster(
      id: map['id'] as String,
      name: map['name'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());
  factory Poster.fromJson(String source) =>
      Poster.fromMap(json.decode(source) as Map<String, dynamic>);
}