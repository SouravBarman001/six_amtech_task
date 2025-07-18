import 'package:equatable/equatable.dart';

/// Domain entity representing a Food Campaign
class Campaign extends Equatable {
  final String name;
  final String restaurantName;
  final double price;
  final String imageFullUrl;
  final int ratingCount;
  final double rating; // Rating value (0.0 to 5.0)
  final double discount;
  final String discountType; // "amount" or "percent"

  const Campaign({
    required this.name,
    required this.restaurantName,
    required this.price,
    required this.imageFullUrl,
    required this.ratingCount,
    required this.rating,
    required this.discount,
    required this.discountType,
  });

  /// Create a copy with modified fields
  Campaign copyWith({
    String? name,
    String? restaurantName,
    double? price,
    String? imageFullUrl,
    int? ratingCount,
    double? rating,
    double? discount,
    String? discountType,
  }) {
    return Campaign(
      name: name ?? this.name,
      restaurantName: restaurantName ?? this.restaurantName,
      price: price ?? this.price,
      imageFullUrl: imageFullUrl ?? this.imageFullUrl,
      ratingCount: ratingCount ?? this.ratingCount,
      rating: rating ?? this.rating,
      discount: discount ?? this.discount,
      discountType: discountType ?? this.discountType,
    );
  }

  /// Calculate discounted price based on discount type
  double get discountedPrice {
    if (discountType == "percent") {
      // Calculate percentage discount
      return price - (price * discount / 100);
    } else {
      // Amount discount
      return price - discount;
    }
  }

  /// Get formatted original price (cut price)
  String get formattedOriginalPrice => '\$${price.toStringAsFixed(2)}';

  /// Get formatted discounted price (main price)
  String get formattedDiscountedPrice => '\$${discountedPrice.toStringAsFixed(2)}';

  /// Get formatted discount text
  String get formattedDiscount {
    if (discountType == "percent") {
      return '${discount.toInt()}% off';
    } else {
      return '\$${discount.toStringAsFixed(0)} off';
    }
  }

  /// Get the number of full stars (filled stars)
  int get fullStars => rating.floor();

  /// Check if there should be a half star
  bool get hasHalfStar => (rating - fullStars) >= 0.5;

  /// Get the number of empty stars
  int get emptyStars => 5 - fullStars - (hasHalfStar ? 1 : 0);

  /// Get formatted rating text (e.g., "4.5 (123)" or just "4.5" if no rating count)
  String get formattedRating {
    if (ratingCount > 0) {
      return '${rating.toStringAsFixed(1)} ($ratingCount)';
    } else {
      return rating.toStringAsFixed(1);
    }
  }

  @override
  List<Object?> get props => [
        name,
        restaurantName,
        price,
        imageFullUrl,
        ratingCount,
        rating,
        discount,
        discountType,
      ];
}
