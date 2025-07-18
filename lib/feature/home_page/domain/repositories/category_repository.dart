import '../../../../core/utils/result.dart';
import '../entities/category.dart';

/// Abstract repository interface for category operations
abstract class CategoryRepository {
  /// Get all categories
  Future<Result<List<Category>>> getCategories();
  
  /// Refresh categories from remote source
  Future<Result<List<Category>>> refreshCategories();
}
