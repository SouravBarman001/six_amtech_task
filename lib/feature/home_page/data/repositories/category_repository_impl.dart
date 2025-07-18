import 'package:core/core.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/category.dart';
import '../../domain/repositories/category_repository.dart';
import '../datasources/category_remote_datasource.dart';

/// Implementation of CategoryRepository
class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource _remoteDataSource;

  CategoryRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<List<Category>>> getCategories() async {
    try {
      final categoryModels = await _remoteDataSource.getCategories();
      final categories = categoryModels.map((model) => model.toEntity()).toList();
      
      return Success(categories);
    } on Failure catch (failure) {
      return Failed(_getErrorMessage(failure));
    } catch (e) {
      return Failed('Unexpected error occurred: ${e.toString()}');
    }
  }

  @override
  Future<Result<List<Category>>> refreshCategories() async {
    // For now, this is the same as getCategories since we don't have caching
    // In a real app, you might clear cache here and fetch fresh data
    return await getCategories();
  }

  /// Helper method to get user-friendly error messages
  String _getErrorMessage(Failure failure) {
    switch (failure.runtimeType) {
      case BadRequest:
        return 'Invalid request. Please try again.';
      case NotFound:
        return 'Categories not found.';
      case Unauthorized:
        return 'You are not authorized to access this content.';
      case InternalServerError:
        return 'Something went wrong. Please try again.';
      default:
        return 'An error occurred while fetching categories.';
    }
  }
}
