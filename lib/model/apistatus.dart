import 'apirespone.dart';

class ApiStatus {
  final ApiResponse api;
  final bool favourite;
  final bool seen;

  ApiStatus({
    required this.api,
    this.favourite = false,
    this.seen = false,
  });

  factory ApiStatus.fromJson(Map<String, dynamic> json) {
    return ApiStatus(
      api: ApiResponse.fromMap(json['api'] as Map<String, dynamic>),
      favourite: json['favourite'] as bool? ?? false,
      seen: json['seen'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'api': api.toJson(),
      'favourite': favourite,
      'seen': seen,
    };
  }

  Map<String, Object?> toMap() {
    return {
      'api': api.toMap(),
      'favourite': favourite,
      'seen': seen,
    };
  }


}
