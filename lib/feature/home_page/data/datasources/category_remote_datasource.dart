import 'package:core/core.dart';
import '../models/category_model.dart';

/// Abstract data source for remote category operations
abstract class CategoryRemoteDataSource {
  /// Get categories from API
  Future<List<CategoryModel>> getCategories();
}

/// Implementation of CategoryRemoteDataSource
class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final StackFoodApiService _apiService;

  CategoryRemoteDataSourceImpl(this._apiService);

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await _apiService.getCategories();
      
      if (response.statusCode == 200) {
        final data = response.data;
        
        // Handle different response structures
        List<dynamic> categoriesJson;
        
        if (data is Map<String, dynamic>) {
          // If response has nested structure
          if (data.containsKey('categories')) {
            categoriesJson = data['categories'] as List<dynamic>;
          } else if (data.containsKey('data')) {
            categoriesJson = data['data'] as List<dynamic>;
          } else {
            // If the map itself contains the list
            categoriesJson = data.values.first as List<dynamic>;
          }
        } else if (data is List) {
          // If response is directly a list
          categoriesJson = data;
        } else {
          throw const BadRequest('Invalid response format');
        }
        
        return categoriesJson
            .map((json) => CategoryModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw BadRequest('Failed to fetch categories: ${response.statusCode}');
      }
    } on Failure {
      rethrow;
    } catch (e) {
      throw InternalServerError('Failed to get categories: ${e.toString()}');
    }
  }
}
