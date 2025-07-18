import 'package:core/core.dart';
import '../../../../core/utils/result.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

/// Use case for getting popular products
class GetPopularProductsUseCase {
  final ProductRepository _repository;

  const GetPopularProductsUseCase({
    required ProductRepository repository,
  }) : _repository = repository;

  /// Execute the use case to get popular products
  Future<Result<List<Product>>> call() async {
    try {
      Log.info('Fetching popular products...');
      
      final result = await _repository.getPopularProducts();
      
      switch (result) {
        case Success<List<Product>>():
          Log.info('Successfully fetched ${result.data.length} popular products');
          return result;
        case Failed<List<Product>>():
          Log.error('Failed to fetch popular products: ${result.message}');
          return result;
      }
    } catch (e) {
      Log.error('Unexpected error in GetPopularProductsUseCase: $e');
      return Failed('Failed to fetch popular products: $e');
    }
  }
}
