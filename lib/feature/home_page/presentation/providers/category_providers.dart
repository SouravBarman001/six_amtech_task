import 'package:core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/category_remote_datasource.dart';
import '../../data/repositories/category_repository_impl.dart';
import '../../domain/entities/category.dart';
import '../../domain/repositories/category_repository.dart';
import '../../domain/usecases/category_usecases.dart';
import '../state/category_notifier.dart';
import '../state/category_state.dart';

/// Provider for CategoryRemoteDataSource
final categoryRemoteDataSourceProvider = Provider<CategoryRemoteDataSource>(
  (ref) {
    final apiService = ref.read(stackFoodApiServiceProvider);
    return CategoryRemoteDataSourceImpl(apiService);
  },
);

/// Provider for CategoryRepository
final categoryRepositoryProvider = Provider<CategoryRepository>(
  (ref) {
    final remoteDataSource = ref.read(categoryRemoteDataSourceProvider);
    return CategoryRepositoryImpl(remoteDataSource);
  },
);

/// Provider for GetCategoriesUseCase
final getCategoriesUseCaseProvider = Provider<GetCategoriesUseCase>(
  (ref) {
    final repository = ref.read(categoryRepositoryProvider);
    return GetCategoriesUseCase(repository);
  },
);

/// Provider for RefreshCategoriesUseCase
final refreshCategoriesUseCaseProvider = Provider<RefreshCategoriesUseCase>(
  (ref) {
    final repository = ref.read(categoryRepositoryProvider);
    return RefreshCategoriesUseCase(repository);
  },
);

/// Provider for CategoryNotifier
final categoryNotifierProvider = StateNotifierProvider<CategoryNotifier, CategoryState>(
  (ref) {
    final getCategoriesUseCase = ref.read(getCategoriesUseCaseProvider);
    final refreshCategoriesUseCase = ref.read(refreshCategoriesUseCaseProvider);
    
    return CategoryNotifier(
      getCategoriesUseCase,
      refreshCategoriesUseCase,
    );
  },
);

/// Convenience provider for accessing category state
final categoryStateProvider = Provider<CategoryState>(
  (ref) => ref.watch(categoryNotifierProvider),
);

/// Provider for checking if categories are loading
final isCategoryLoadingProvider = Provider<bool>(
  (ref) => ref.watch(categoryNotifierProvider.select((state) => state.isLoading)),
);

/// Provider for checking if categories are refreshing
final isCategoryRefreshingProvider = Provider<bool>(
  (ref) => ref.watch(categoryNotifierProvider.select((state) => state.isRefreshing)),
);

/// Provider for getting category error message
final categoryErrorProvider = Provider<String?>(
  (ref) => ref.watch(categoryNotifierProvider.select((state) => state.errorMessage)),
);

/// Provider for getting categories list
final categoriesListProvider = Provider<List<Category>>(
  (ref) => ref.watch(categoryNotifierProvider.select((state) => state.categories)),
);

/// Provider for checking if categories have data
final hasCategoryDataProvider = Provider<bool>(
  (ref) => ref.watch(categoryNotifierProvider.select((state) => state.hasData)),
);

/// Provider for checking if categories are empty
final isCategoryEmptyProvider = Provider<bool>(
  (ref) => ref.watch(categoryNotifierProvider.select((state) => state.isEmpty)),
);
