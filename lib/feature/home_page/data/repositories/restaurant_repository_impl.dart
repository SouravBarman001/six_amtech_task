import '../../domain/entities/restaurant.dart';
import '../../domain/repositories/restaurant_repository.dart';
import '../datasources/restaurant_remote_data_source.dart';

/// Implementation of RestaurantRepository
class RestaurantRepositoryImpl implements RestaurantRepository {
  final RestaurantRemoteDataSource _remoteDataSource;

  const RestaurantRepositoryImpl(this._remoteDataSource);

  @override
  Future<RestaurantResponse> getRestaurants({
    required int offset,
    required int limit,
  }) async {
    try {
      final restaurantResponseModel = await _remoteDataSource.getRestaurants(
        offset: offset,
        limit: limit,
      );
      
      return restaurantResponseModel.toEntity();
    } catch (e) {
      throw Exception('Failed to fetch restaurants: $e');
    }
  }
}
