import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:core/core.dart';
import '../../../../core/utils/result.dart';
import '../../domain/usecases/category_usecases.dart';
import 'category_state.dart';

/// Notifier for managing category state
class CategoryNotifier extends StateNotifier<CategoryState> {
  final GetCategoriesUseCase _getCategoriesUseCase;
  final RefreshCategoriesUseCase _refreshCategoriesUseCase;

  CategoryNotifier(
    this._getCategoriesUseCase,
    this._refreshCategoriesUseCase,
  ) : super(CategoryState.initial()) {
    // Auto-load categories when notifier is created
    getCategories();
  }

  /// Get categories
  Future<void> getCategories() async {
    if (state.hasData && !state.isRefreshing) {
      // If we already have data and not refreshing, don't show loading
      return;
    }

    state = state.loading();
    
    final result = await _getCategoriesUseCase();
    
    switch (result) {
      case Success(:final data):
        state = state.success(data);
        Log.info('Successfully loaded ${data.length} categories');
      case Failed(:final message):
        state = state.error(message);
        Log.error('Failed to load categories: $message');
    }
  }

  /// Refresh categories
  Future<void> refresh() async {
    if (state.isLoading) return;

    state = state.refreshing();
    Log.info('Refreshing categories...');

    final result = await _refreshCategoriesUseCase();

    switch (result) {
      case Success(:final data):
        state = state.success(data);
        Log.info('Successfully refreshed ${data.length} categories');
      case Failed(:final message):
        state = state.error(message);
        Log.error('Failed to refresh categories: $message');
    }
  }

  /// Clear error state
  void clearError() {
    if (state.hasError) {
      state = state.copyWith(errorMessage: null);
      Log.debug('Category error cleared');
    }
  }

  /// Retry loading categories
  Future<void> retry() async {
    Log.info('Retrying to fetch categories...');
    await getCategories();
  }

  /// Reset state to initial
  void reset() {
    state = CategoryState.initial();
    Log.debug('Category state reset');
  }
}
