import '../../domain/entities/restaurant.dart';

/// Data model for Restaurant with JSON serialization
class RestaurantModel {
  final int id;
  final String name;
  final double avgRating;
  final String coverPhotoFullUrl;

  const RestaurantModel({
    required this.id,
    required this.name,
    required this.avgRating,
    required this.coverPhotoFullUrl,
  });

  /// Create RestaurantModel from JSON
  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: _parseInt(json['id']),
      name: _parseString(json['name']),
      avgRating: _parseRating(json['avg_rating']),
      coverPhotoFullUrl: _parseString(json['cover_photo_full_url']),
    );
  }

  /// Convert RestaurantModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'avg_rating': avgRating,
      'cover_photo_full_url': coverPhotoFullUrl,
    };
  }

  /// Convert to domain entity
  Restaurant toEntity() {
    return Restaurant(
      id: id,
      name: name,
      avgRating: avgRating,
      coverPhotoFullUrl: coverPhotoFullUrl,
    );
  }

  /// Create from domain entity
  factory RestaurantModel.fromEntity(Restaurant restaurant) {
    return RestaurantModel(
      id: restaurant.id,
      name: restaurant.name,
      avgRating: restaurant.avgRating,
      coverPhotoFullUrl: restaurant.coverPhotoFullUrl,
    );
  }

  /// Helper method to safely parse String from dynamic
  static String _parseString(dynamic value) {
    if (value == null) return '';
    return value.toString();
  }

  /// Helper method to safely parse double from dynamic
  static double _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  /// Helper method to safely parse rating (ensures it's between 0-5)
  static double _parseRating(dynamic value) {
    double rating = _parseDouble(value);
    // Clamp rating between 0.0 and 5.0
    return rating.clamp(0.0, 5.0);
  }

  /// Helper method to safely parse int from dynamic
  static int _parseInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }
}

/// Data model for paginated restaurant response
class RestaurantResponseModel {
  final String filterData;
  final int totalSize;
  final String limit;
  final String offset;
  final List<RestaurantModel> restaurants;

  const RestaurantResponseModel({
    required this.filterData,
    required this.totalSize,
    required this.limit,
    required this.offset,
    required this.restaurants,
  });

  /// Create RestaurantResponseModel from JSON
  factory RestaurantResponseModel.fromJson(Map<String, dynamic> json) {
    return RestaurantResponseModel(
      filterData: RestaurantModel._parseString(json['filter_data']),
      totalSize: RestaurantModel._parseInt(json['total_size']),
      limit: RestaurantModel._parseString(json['limit']),
      offset: RestaurantModel._parseString(json['offset']),
      restaurants: (json['restaurants'] as List<dynamic>?)
              ?.map((restaurantJson) => RestaurantModel.fromJson(restaurantJson))
              .toList() ??
          [],
    );
  }

  /// Convert to domain entity
  RestaurantResponse toEntity() {
    return RestaurantResponse(
      filterData: filterData,
      totalSize: totalSize,
      limit: limit,
      offset: offset,
      restaurants: restaurants.map((model) => model.toEntity()).toList(),
    );
  }
}
