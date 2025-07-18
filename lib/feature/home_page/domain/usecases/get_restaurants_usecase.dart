import '../entities/restaurant.dart';
import '../repositories/restaurant_repository.dart';

/// Use case for getting paginated restaurants
class GetRestaurantsUseCase {
  final RestaurantRepository _repository;

  GetRestaurantsUseCase(this._repository);

  /// Execute the use case to get restaurants
  /// 
  /// [offset] - Starting position for pagination
  /// [limit] - Number of items to fetch
  Future<RestaurantResponse> execute({
    required int offset,
    required int limit,
  }) async {
    return await _repository.getRestaurants(
      offset: offset,
      limit: limit,
    );
  }
}
