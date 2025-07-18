import 'package:equatable/equatable.dart';

/// Domain entity representing a Product (Popular Food)
class Product extends Equatable {
  final String name;
  final String restaurantName;
  final double price;
  final double avgRating;
  final String imageFullUrl;

  const Product({
    required this.name,
    required this.restaurantName,
    required this.price,
    required this.avgRating,
    required this.imageFullUrl,
  });

  /// Create a copy with modified fields
  Product copyWith({
    String? name,
    String? restaurantName,
    double? price,
    double? avgRating,
    String? imageFullUrl,
  }) {
    return Product(
      name: name ?? this.name,
      restaurantName: restaurantName ?? this.restaurantName,
      price: price ?? this.price,
      avgRating: avgRating ?? this.avgRating,
      imageFullUrl: imageFullUrl ?? this.imageFullUrl,
    );
  }

  /// Get formatted rating with 2 decimal places
  String get formattedRating => avgRating.toStringAsFixed(1);

  /// Get formatted price
  String get formattedPrice => '\$${price.toStringAsFixed(2)}';

  @override
  List<Object?> get props => [
        name,
        restaurantName,
        price,
        avgRating,
        imageFullUrl,
      ];

  @override
  String toString() {
    return 'Product(name: $name, restaurantName: $restaurantName, price: $price, avgRating: $avgRating, imageFullUrl: $imageFullUrl)';
  }
}
