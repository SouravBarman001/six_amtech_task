import '../../domain/entities/product.dart';

/// Data model for Product that extends the domain entity
class ProductModel extends Product {
  const ProductModel({
    required super.name,
    required super.restaurantName,
    required super.price,
    required super.avgRating,
    required super.imageFullUrl,
  });

  /// Create ProductModel from JSON
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      name: json['name']?.toString() ?? '',
      restaurantName: json['restaurant_name']?.toString() ?? '',
      price: _parseDouble(json['price']) ?? 0.0,
      avgRating: _parseDouble(json['avg_rating']) ?? 0.0,
      imageFullUrl: json['image_full_url']?.toString() ?? '',
    );
  }

  /// Convert ProductModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'restaurant_name': restaurantName,
      'price': price,
      'avg_rating': avgRating,
      'image_full_url': imageFullUrl,
    };
  }

  /// Create ProductModel from domain entity
  factory ProductModel.fromEntity(Product product) {
    return ProductModel(
      name: product.name,
      restaurantName: product.restaurantName,
      price: product.price,
      avgRating: product.avgRating,
      imageFullUrl: product.imageFullUrl,
    );
  }

  /// Convert to domain entity
  Product toEntity() {
    return Product(
      name: name,
      restaurantName: restaurantName,
      price: price,
      avgRating: avgRating,
      imageFullUrl: imageFullUrl,
    );
  }

  /// Helper method to parse double values safely
  static double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  /// Create a copy with modified fields
  @override
  ProductModel copyWith({
    String? name,
    String? restaurantName,
    double? price,
    double? avgRating,
    String? imageFullUrl,
  }) {
    return ProductModel(
      name: name ?? this.name,
      restaurantName: restaurantName ?? this.restaurantName,
      price: price ?? this.price,
      avgRating: avgRating ?? this.avgRating,
      imageFullUrl: imageFullUrl ?? this.imageFullUrl,
    );
  }
}
