import 'package:core/core.dart';
import '../models/banner_model.dart';

/// Abstract data source for remote banner operations
abstract class BannerRemoteDataSource {
  /// Get banners from API
  Future<List<BannerModel>> getBanners();
}

/// Implementation of BannerRemoteDataSource
class BannerRemoteDataSourceImpl implements BannerRemoteDataSource {
  final StackFoodApiService _apiService;

  BannerRemoteDataSourceImpl(this._apiService);

  @override
  Future<List<BannerModel>> getBanners() async {
    try {
      final response = await _apiService.getBanners();
      
      if (response.statusCode == 200) {
        final data = response.data;
        
        // Handle different response structures
        List<dynamic> bannersJson;
        
        if (data is Map<String, dynamic>) {
          // If response has a wrapper structure
          bannersJson = data['data'] ?? data['banners'] ?? data['result'] ?? [];
        } else if (data is List) {
          // If response is directly a list
          bannersJson = data;
        } else {
          throw const BadRequest('Invalid response format');
        }
        
        return bannersJson
            .map((json) => BannerModel.fromJson(json as Map<String, dynamic>))
            .toList(); // Removed the isActive filter since the new model doesn't have this field
      } else {
        throw BadRequest('Failed to fetch banners: ${response.statusCode}');
      }
    } on Failure {
      rethrow;
    } catch (e) {
      throw InternalServerError('Failed to get banners: ${e.toString()}');
    }
  }
}
