abstract class StorageEvent {}

class AddToStorage extends StorageEvent {
  String name;
  String slug;
  String originName;

  String posterUrl;
  String thumbUrl;
  String year;
  bool favourite;
  bool seen;

  AddToStorage({
    required this.name,
    required this.slug,
    required this.originName,
    required this.posterUrl,
    required this.thumbUrl,
    required this.year,
    this.favourite = false,
    this.seen = false,
  });
}

class LoadJson extends StorageEvent{}

class FavouriteApiStatus extends StorageEvent {
 final String slug;
  FavouriteApiStatus(this.slug);
}

class SeenApiStatus extends StorageEvent {
  final String slug;
  SeenApiStatus(this.slug,);
}

class RemoveSeen extends StorageEvent {
  final String slug;
  RemoveSeen(this.slug,);
}

class RemoveFavourite extends StorageEvent {
  final String slug;
  RemoveFavourite(this.slug,);
}