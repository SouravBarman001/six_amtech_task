import '../entities/restaurant.dart';

/// Repository interface for restaurant operations
abstract class RestaurantRepository {
  /// Get paginated list of restaurants
  /// 
  /// [offset] - Starting position for pagination
  /// [limit] - Number of items to fetch
  Future<RestaurantResponse> getRestaurants({
    required int offset,
    required int limit,
  });
}
