import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:core/core.dart';
import '../../../../core/utils/result.dart';
import '../../domain/usecases/get_popular_products_usecase.dart';
import 'product_state.dart';

/// Notifier for managing product state
class ProductNotifier extends StateNotifier<ProductState> {
  final GetPopularProductsUseCase _getPopularProductsUseCase;

  ProductNotifier({
    required GetPopularProductsUseCase getPopularProductsUseCase,
  })  : _getPopularProductsUseCase = getPopularProductsUseCase,
        super(ProductState.initial());

  /// Get popular products
  Future<void> getPopularProducts() async {
    if (state.isLoading) return;

    state = state.copyWithLoading();
    Log.info('Fetching popular products...');

    final result = await _getPopularProductsUseCase();

    switch (result) {
      case Success():
        final data = result.data;
        Log.info('Successfully fetched ${data.length} popular products');
        state = state.copyWithSuccess(data);
      case Failed():
        final message = result.message;
        Log.error('Failed to fetch popular products: $message');
        state = state.copyWithError(message);
    }
  }

  /// Refresh popular products
  Future<void> refresh() async {
    Log.info('Refreshing popular products...');
    final result = await _getPopularProductsUseCase();

    switch (result) {
      case Success():
        final data = result.data;
        Log.info('Successfully refreshed ${data.length} popular products');
        state = state.copyWithSuccess(data);
      case Failed():
        final message = result.message;
        Log.error('Failed to refresh popular products: $message');
        state = state.copyWithError(message);
    }
  }

  /// Clear error state
  void clearError() {
    if (state.hasError) {
      Log.debug('Product error cleared');
      state = state.copyWithClearedError();
    }
  }

  /// Retry fetching products
  Future<void> retry() async {
    Log.info('Retrying to fetch popular products...');
    clearError();
    await getPopularProducts();
  }

  /// Reset state
  void reset() {
    Log.debug('Product state reset');
    state = ProductState.initial();
  }
}
