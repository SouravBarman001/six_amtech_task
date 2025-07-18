import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:core/core.dart';
import '../../../../core/utils/result.dart';
import '../../domain/usecases/banner_usecases.dart';
import 'banner_state.dart';

/// Notifier for managing banner state
class BannerNotifier extends StateNotifier<BannerState> {
  final GetBannersUseCase _getBannersUseCase;
  final RefreshBannersUseCase _refreshBannersUseCase;

  BannerNotifier(
    this._getBannersUseCase,
    this._refreshBannersUseCase,
  ) : super(BannerState.initial()) {
    // Auto-load banners when notifier is created
    getBanners();
  }

  /// Get banners
  Future<void> getBanners() async {
    if (state.hasData && !state.isRefreshing) {
      // If we already have data and not refreshing, don't show loading
      return;
    }

    state = state.loading();
    
    Log.info('Fetching banners...');

    final result = await _getBannersUseCase();

    switch (result) {
      case Success(:final data):
        Log.info('Successfully fetched ${data.length} banners');
        state = state.success(data);
      case Failed(:final message):
        Log.error('Failed to fetch banners: $message');
        state = state.error(message);
    }
  }

  /// Refresh banners
  Future<void> refreshBanners() async {
    if (state.isLoading) return; // Prevent multiple simultaneous requests

    state = state.refreshing();
    
    Log.info('Refreshing banners...');

    final result = await _refreshBannersUseCase();

    switch (result) {
      case Success(:final data):
        Log.info('Successfully refreshed ${data.length} banners');
        state = state.success(data);
      case Failed(:final message):
        Log.error('Failed to refresh banners: $message');
        state = state.error(message);
    }
  }

  /// Update current banner index (for carousel)
  void updateCurrentIndex(int index) {
    if (index >= 0 && index < state.banners.length) {
      state = state.updateCurrentIndex(index);
      Log.debug('Banner index updated to: $index');
    }
  }

  /// Clear error state
  void clearError() {
    if (state.hasError) {
      state = state.copyWith(errorMessage: null);
      Log.debug('Banner error cleared');
    }
  }

  /// Retry loading banners
  Future<void> retry() async {
    Log.info('Retrying to fetch banners...');
    await getBanners();
  }

  /// Auto-advance banner index (for automatic carousel)
  void autoAdvanceBanner() {
    if (state.banners.isNotEmpty) {
      final nextIndex = (state.currentBannerIndex + 1) % state.banners.length;
      updateCurrentIndex(nextIndex);
    }
  }

  /// Go to previous banner
  void previousBanner() {
    if (state.banners.isNotEmpty) {
      final prevIndex = state.currentBannerIndex > 0 
          ? state.currentBannerIndex - 1 
          : state.banners.length - 1;
      updateCurrentIndex(prevIndex);
    }
  }

  /// Go to next banner
  void nextBanner() {
    if (state.banners.isNotEmpty) {
      final nextIndex = (state.currentBannerIndex + 1) % state.banners.length;
      updateCurrentIndex(nextIndex);
    }
  }
}
