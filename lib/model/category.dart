import 'dart:convert';

class Category {
  final String id;
  final String name;

  Category({
    required this.id,
    required this.name,
  });

  // Convert Category to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  // Create Category from Map
  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      name: map['name'],
    );
  }

  // Convert Category to JSON string
  String toJson() => json.encode(toMap());

  // Create Category from JSON string
  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source) as Map<String, dynamic>);
}
