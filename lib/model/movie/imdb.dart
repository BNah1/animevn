class Imdb {
  final String? id;

  Imdb({this.id});

  factory Imdb.fromJson(Map<String, dynamic> json) {
    return Imdb(id: json['id']);
  }
}