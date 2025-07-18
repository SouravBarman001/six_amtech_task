import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:core/core.dart';
import '../../data/datasources/product_remote_datasource.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/usecases/get_popular_products_usecase.dart';
import '../../domain/entities/product.dart';
import '../state/product_notifier.dart';
import '../state/product_state.dart';

/// Provider for ProductRemoteDataSource
final productRemoteDataSourceProvider = Provider<ProductRemoteDataSource>((ref) {
  final apiService = ref.read(stackFoodApiServiceProvider);
  return ProductRemoteDataSourceImpl(
    apiService: apiService,
  );
});

/// Provider for ProductRepository
final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepositoryImpl(
    remoteDataSource: ref.read(productRemoteDataSourceProvider),
  );
});

/// Provider for GetPopularProductsUseCase
final getPopularProductsUseCaseProvider = Provider<GetPopularProductsUseCase>((ref) {
  return GetPopularProductsUseCase(
    repository: ref.read(productRepositoryProvider),
  );
});

/// Provider for ProductNotifier
final productNotifierProvider = StateNotifierProvider<ProductNotifier, ProductState>((ref) {
  return ProductNotifier(
    getPopularProductsUseCase: ref.read(getPopularProductsUseCaseProvider),
  );
});

/// Provider for product state
final productStateProvider = Provider<ProductState>((ref) {
  return ref.watch(productNotifierProvider);
});

/// Provider for loading state
final isProductLoadingProvider = Provider<bool>((ref) {
  return ref.watch(productStateProvider).isLoading;
});

/// Provider for products list
final productsListProvider = Provider<List<Product>>((ref) {
  return ref.watch(productStateProvider).products;
});

/// Provider for error message
final productErrorProvider = Provider<String?>((ref) {
  return ref.watch(productStateProvider).errorMessage;
});
