import 'package:equatable/equatable.dart';
import '../../domain/entities/product.dart';

/// State for product operations
class ProductState extends Equatable {
  final bool isLoading;
  final List<Product> products;
  final String? errorMessage;
  final bool hasError;

  const ProductState({
    this.isLoading = false,
    this.products = const [],
    this.errorMessage,
    this.hasError = false,
  });

  /// Create initial state
  factory ProductState.initial() {
    return const ProductState();
  }

  /// Create loading state
  ProductState copyWithLoading() {
    return ProductState(
      isLoading: true,
      products: products,
      errorMessage: null,
      hasError: false,
    );
  }

  /// Create success state
  ProductState copyWithSuccess(List<Product> newProducts) {
    return ProductState(
      isLoading: false,
      products: newProducts,
      errorMessage: null,
      hasError: false,
    );
  }

  /// Create error state
  ProductState copyWithError(String error) {
    return ProductState(
      isLoading: false,
      products: products,
      errorMessage: error,
      hasError: true,
    );
  }

  /// Create state with cleared error
  ProductState copyWithClearedError() {
    return ProductState(
      isLoading: isLoading,
      products: products,
      errorMessage: null,
      hasError: false,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        products,
        errorMessage,
        hasError,
      ];

  @override
  String toString() {
    return 'ProductState(isLoading: $isLoading, productsCount: ${products.length}, hasError: $hasError, errorMessage: $errorMessage)';
  }
}
