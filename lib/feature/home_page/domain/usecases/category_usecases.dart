import '../../../../core/utils/result.dart';
import '../entities/category.dart';
import '../repositories/category_repository.dart';

/// Use case for getting categories
class GetCategoriesUseCase {
  final CategoryRepository _repository;

  const GetCategoriesUseCase(this._repository);

  /// Execute the use case to get categories
  Future<Result<List<Category>>> call() async {
    return await _repository.getCategories();
  }
}

/// Use case for refreshing categories
class RefreshCategoriesUseCase {
  final CategoryRepository _repository;

  const RefreshCategoriesUseCase(this._repository);

  /// Execute the use case to refresh categories
  Future<Result<List<Category>>> call() async {
    return await _repository.refreshCategories();
  }
}
