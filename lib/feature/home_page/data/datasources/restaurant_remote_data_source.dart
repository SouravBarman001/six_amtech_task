import 'package:core/core.dart';
import '../models/restaurant_model.dart';

/// Remote data source for Restaurant operations
class RestaurantRemoteDataSource {
  final StackFoodApiService _apiService;

  const RestaurantRemoteDataSource(this._apiService);

  /// Get restaurants from API with pagination
  /// [offset] - Starting position for pagination
  /// [limit] - Number of items to fetch
  /// Returns: RestaurantResponseModel
  /// Throws: Exception on API error
  Future<RestaurantResponseModel> getRestaurants({
    required int offset,
    required int limit,
  }) async {
    try {
      Log.info('Fetching restaurants from API with offset: $offset, limit: $limit');
      Log.info('API URL: ${_apiService.buildUrl('/api/v1/restaurants/get-restaurants/all', queryParams: {'offset': offset, 'limit': limit})}');
      
      final response = await _apiService.getRestaurants(
        offset: offset,
        limit: limit,
      );
      
      Log.info('Restaurants API response: ${response.statusCode}');
      
      if (response.statusCode == 200) {
        final data = response.data;
        Log.info('Response data type: ${data.runtimeType}');
        
        if (data is Map<String, dynamic>) {
          Log.info('Response data keys: ${data.keys.toList()}');
          final restaurantResponseModel = RestaurantResponseModel.fromJson(data);
          
          Log.info('Successfully parsed ${restaurantResponseModel.restaurants.length} restaurants');
          Log.info('Total size: ${restaurantResponseModel.totalSize}, Has more: ${restaurantResponseModel.restaurants.length < int.parse(restaurantResponseModel.limit)}');
          
          return restaurantResponseModel;
        } else {
          Log.error('Invalid response format: expected Map, got ${data.runtimeType}');
          Log.error('Response data: $data');
          throw Exception('Invalid response format');
        }
      } else {
        Log.error('API request failed with status: ${response.statusCode}');
        Log.error('Response data: ${response.data}');
        throw Exception('Failed to load restaurants. Status code: ${response.statusCode}');
      }
    } catch (e) {
      Log.error('Error while fetching restaurants: $e');
      if (e.toString().contains('403')) {
        Log.error('403 Forbidden - Check if required headers (zoneId, latitude, longitude) are properly set');
      }
      throw Exception('Failed to fetch restaurants: $e');
    }
  }
}
