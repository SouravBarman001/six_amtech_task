import 'package:equatable/equatable.dart';

/// Domain entity representing a Restaurant
class Restaurant extends Equatable {
  final int id;
  final String name;
  final double avgRating;
  final String coverPhotoFullUrl;

  const Restaurant({
    required this.id,
    required this.name,
    required this.avgRating,
    required this.coverPhotoFullUrl,
  });

  /// Create a copy with modified fields
  Restaurant copyWith({
    int? id,
    String? name,
    double? avgRating,
    String? coverPhotoFullUrl,
  }) {
    return Restaurant(
      id: id ?? this.id,
      name: name ?? this.name,
      avgRating: avgRating ?? this.avgRating,
      coverPhotoFullUrl: coverPhotoFullUrl ?? this.coverPhotoFullUrl,
    );
  }

  /// Get the number of full stars (filled stars)
  int get fullStars => avgRating.floor();

  /// Check if there should be a half star
  bool get hasHalfStar => (avgRating - fullStars) >= 0.5;

  /// Get the number of empty stars
  int get emptyStars => 5 - fullStars - (hasHalfStar ? 1 : 0);

  /// Get formatted rating text
  String get formattedRating => avgRating.toStringAsFixed(1);

  @override
  List<Object?> get props => [
        id,
        name,
        avgRating,
        coverPhotoFullUrl,
      ];
}

/// Domain entity representing paginated restaurant response
class RestaurantResponse extends Equatable {
  final String filterData;
  final int totalSize;
  final String limit;
  final String offset;
  final List<Restaurant> restaurants;

  const RestaurantResponse({
    required this.filterData,
    required this.totalSize,
    required this.limit,
    required this.offset,
    required this.restaurants,
  });

  /// Check if there are more restaurants to load
  bool get hasMoreData {
    final currentOffset = int.tryParse(offset) ?? 1;
    final limitNum = int.tryParse(limit) ?? 10;
    
    // Method 1: Check if we got fewer restaurants than requested
    final gotFewerThanRequested = restaurants.length < limitNum;
    
    // Method 2: Check if next offset would exceed total
    // For 1-based: if current batch ends at or after totalSize, no more data
    final currentBatchEnd = currentOffset + restaurants.length - 1;
    final hasMoreByOffset = currentBatchEnd < totalSize;
    
    // Use the more reliable method: if we got fewer than requested, we're done
    final result = !gotFewerThanRequested && hasMoreByOffset;
    
    // Debug logging
    print('🔍 hasMoreData calculation:');
    print('  - offset: $offset (parsed: $currentOffset)');
    print('  - limit: $limit (parsed: $limitNum)');
    print('  - totalSize: $totalSize');
    print('  - restaurantsReceived: ${restaurants.length}');
    print('  - gotFewerThanRequested: $gotFewerThanRequested');
    print('  - currentBatchEnd: $currentBatchEnd');
    print('  - hasMoreByOffset: $hasMoreByOffset');
    print('  - final result: $result');
    
    return result;
  }

  /// Get next offset for pagination
  int get nextOffset {
    final currentOffset = int.tryParse(offset) ?? 0;
    final limitNum = int.tryParse(limit) ?? 10;
    return currentOffset + limitNum;
  }

  @override
  List<Object?> get props => [
        filterData,
        totalSize,
        limit,
        offset,
        restaurants,
      ];
}
