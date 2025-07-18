import 'package:core/core.dart';
import '../../../../core/utils/result.dart';
import '../models/product_model.dart';

/// Abstract remote data source for product operations
abstract class ProductRemoteDataSource {
  Future<Result<List<ProductModel>>> getPopularProducts();
}

/// Implementation of ProductRemoteDataSource using StackFood API
class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final StackFoodApiService _apiService;

  const ProductRemoteDataSourceImpl({
    required StackFoodApiService apiService,
  }) : _apiService = apiService;

  @override
  Future<Result<List<ProductModel>>> getPopularProducts() async {
    try {
      final response = await _apiService.getPopularFood();

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data as Map<String, dynamic>;
        final productsJson = data['products'] as List<dynamic>? ?? [];
        
        final products = productsJson
            .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
            .toList();

        return Success(products);
      } else {
        return Failed('Failed to fetch popular products: ${response.statusMessage}');
      }
    } catch (e) {
      return Failed('Network error while fetching popular products: $e');
    }
  }
}
