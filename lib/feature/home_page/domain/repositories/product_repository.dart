import '../../../../core/utils/result.dart';
import '../entities/product.dart';

/// Abstract repository for product operations
abstract class ProductRepository {
  /// Get popular products from the API
  Future<Result<List<Product>>> getPopularProducts();
}
