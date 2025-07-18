import 'package:dio/dio.dart';
import 'api.dart';
import 'src/rest_client.dart';

/// StackFood API Service
/// Provides convenient methods to call StackFood API endpoints
class StackFoodApiService {
  final RestClient _restClient;

  StackFoodApiService(this._restClient);

  /// Get configuration/settings
  /// Returns: Configuration data including image base URLs
  Future<Response> getConfig() async {
    return await _restClient.get(
      APIType.public,
      API.config,
    );
  }

  /// Get banners
  /// Returns: List of banner data
  Future<Response> getBanners() async {
    return await _restClient.get(
      APIType.public,
      API.banner,
    );
  }

  /// Get categories
  /// Returns: List of food categories
  Future<Response> getCategories() async {
    return await _restClient.get(
      APIType.public,
      API.category,
    );
  }

  /// Get popular food items
  /// Returns: List of popular food products
  Future<Response> getPopularFood() async {
    return await _restClient.get(
      APIType.public,
      API.popularFood,
    );
  }

  /// Get food campaigns
  /// Returns: List of food campaign items
  Future<Response> getFoodCampaigns() async {
    return await _restClient.get(
      APIType.public,
      API.foodCampaign,
    );
  }

  /// Get restaurants with pagination
  /// [offset]: Page offset (default: 1)
  /// [limit]: Items per page (default: 10)
  /// Returns: Paginated list of restaurants
  Future<Response> getRestaurants({
    int offset = 1,
    int limit = 10,
  }) async {
    final queryParams = API.getRestaurantParams(
      offset: offset,
      limit: limit,
    );

    return await _restClient.get(
      APIType.public,
      API.restaurants,
      query: queryParams,
    );
  }

  /// Build complete URL for any endpoint
  /// [endpoint]: API endpoint
  /// [queryParams]: Optional query parameters
  /// Returns: Complete URL string
  String buildUrl(String endpoint, {Map<String, dynamic>? queryParams}) {
    return API.buildUrl(endpoint, queryParams: queryParams);
  }
}
