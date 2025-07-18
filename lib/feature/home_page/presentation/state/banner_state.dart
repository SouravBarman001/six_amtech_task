import '../../domain/entities/banner.dart';

/// State class for banner feature
class BannerState {
  final List<Banner> banners;
  final bool isLoading;
  final String? errorMessage;
  final bool isRefreshing;
  final int currentBannerIndex;

  const BannerState({
    this.banners = const [],
    this.isLoading = false,
    this.errorMessage,
    this.isRefreshing = false,
    this.currentBannerIndex = 0,
  });

  /// Create a copy with modified fields
  BannerState copyWith({
    List<Banner>? banners,
    bool? isLoading,
    String? errorMessage,
    bool? isRefreshing,
    int? currentBannerIndex,
  }) {
    return BannerState(
      banners: banners ?? this.banners,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      currentBannerIndex: currentBannerIndex ?? this.currentBannerIndex,
    );
  }

  /// Create initial state
  factory BannerState.initial() => const BannerState();

  /// Create loading state
  BannerState loading() => copyWith(isLoading: true, errorMessage: null);

  /// Create refreshing state
  BannerState refreshing() => copyWith(isRefreshing: true, errorMessage: null);

  /// Create success state
  BannerState success(List<Banner> banners) => copyWith(
        banners: banners,
        isLoading: false,
        isRefreshing: false,
        errorMessage: null,
      );

  /// Create error state
  BannerState error(String message) => copyWith(
        isLoading: false,
        isRefreshing: false,
        errorMessage: message,
      );

  /// Update current banner index
  BannerState updateCurrentIndex(int index) => copyWith(
        currentBannerIndex: index,
        errorMessage: null,
      );

  /// Computed properties
  bool get hasData => banners.isNotEmpty;
  bool get hasError => errorMessage != null;
  bool get isEmpty => banners.isEmpty && !isLoading && !hasError;
  Banner? get currentBanner => 
      banners.isNotEmpty && currentBannerIndex < banners.length 
          ? banners[currentBannerIndex] 
          : null;

  @override
  String toString() {
    return 'BannerState(banners: ${banners.length}, isLoading: $isLoading, errorMessage: $errorMessage, isRefreshing: $isRefreshing, currentBannerIndex: $currentBannerIndex)';
  }
}
