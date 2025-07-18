import '../../domain/entities/category.dart';

/// State class for category feature
class CategoryState {
  final List<Category> categories;
  final bool isLoading;
  final String? errorMessage;
  final bool isRefreshing;

  const CategoryState({
    this.categories = const [],
    this.isLoading = false,
    this.errorMessage,
    this.isRefreshing = false,
  });

  /// Create a copy with modified fields
  CategoryState copyWith({
    List<Category>? categories,
    bool? isLoading,
    String? errorMessage,
    bool? isRefreshing,
  }) {
    return CategoryState(
      categories: categories ?? this.categories,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      isRefreshing: isRefreshing ?? this.isRefreshing,
    );
  }

  /// Create initial state
  factory CategoryState.initial() => const CategoryState();

  /// Create loading state
  CategoryState loading() => copyWith(isLoading: true, errorMessage: null);

  /// Create refreshing state
  CategoryState refreshing() => copyWith(isRefreshing: true, errorMessage: null);

  /// Create success state
  CategoryState success(List<Category> categories) => copyWith(
        categories: categories,
        isLoading: false,
        isRefreshing: false,
        errorMessage: null,
      );

  /// Create error state
  CategoryState error(String message) => copyWith(
        isLoading: false,
        isRefreshing: false,
        errorMessage: message,
      );

  /// Computed properties
  bool get hasData => categories.isNotEmpty;
  bool get hasError => errorMessage != null;
  bool get isEmpty => categories.isEmpty && !isLoading && !hasError;

  @override
  String toString() {
    return 'CategoryState(categories: ${categories.length}, isLoading: $isLoading, errorMessage: $errorMessage, isRefreshing: $isRefreshing)';
  }
}
