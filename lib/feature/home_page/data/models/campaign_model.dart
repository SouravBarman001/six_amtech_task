import '../../domain/entities/campaign.dart';

/// Data model for Campaign with JSON serialization
class CampaignModel {
  final String name;
  final String restaurantName;
  final double price;
  final String imageFullUrl;
  final int ratingCount;
  final double rating; // Rating value (0.0 to 5.0)
  final double discount;
  final String discountType;

  const CampaignModel({
    required this.name,
    required this.restaurantName,
    required this.price,
    required this.imageFullUrl,
    required this.ratingCount,
    required this.rating,
    required this.discount,
    required this.discountType,
  });

  /// Create CampaignModel from JSON
  factory CampaignModel.fromJson(Map<String, dynamic> json) {
    return CampaignModel(
      name: _parseString(json['name']),
      restaurantName: _parseString(json['restaurant_name']),
      price: _parseDouble(json['price']),
      imageFullUrl: _parseString(json['image_full_url']),
      ratingCount: _parseInt(json['rating_count'] ?? json['reviews_count'] ?? 0),
      rating: _parseRating(json['avg_rating'] ?? json['rating'] ?? 4.0), // Safely parse and clamp rating
      discount: _parseDouble(json['discount']),
      discountType: _parseString(json['discount_type']),
    );
  }

  /// Convert CampaignModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'restaurant_name': restaurantName,
      'price': price,
      'image_full_url': imageFullUrl,
      'rating_count': ratingCount,
      'avg_rating': rating,
      'discount': discount,
      'discount_type': discountType,
    };
  }

  /// Convert to domain entity
  Campaign toEntity() {
    return Campaign(
      name: name,
      restaurantName: restaurantName,
      price: price,
      imageFullUrl: imageFullUrl,
      ratingCount: ratingCount,
      rating: rating,
      discount: discount,
      discountType: discountType,
    );
  }

  /// Create from domain entity
  factory CampaignModel.fromEntity(Campaign campaign) {
    return CampaignModel(
      name: campaign.name,
      restaurantName: campaign.restaurantName,
      price: campaign.price,
      imageFullUrl: campaign.imageFullUrl,
      ratingCount: campaign.ratingCount,
      rating: campaign.rating,
      discount: campaign.discount,
      discountType: campaign.discountType,
    );
  }

  /// Helper method to safely parse String from dynamic
  static String _parseString(dynamic value) {
    if (value == null) return '';
    return value.toString();
  }

  /// Helper method to safely parse double from dynamic
  static double _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  /// Helper method to safely parse rating (ensures it's between 0-5)
  static double _parseRating(dynamic value) {
    double rating = _parseDouble(value);
    // Clamp rating between 0.0 and 5.0
    return rating.clamp(0.0, 5.0);
  }

  /// Helper method to safely parse int from dynamic
  static int _parseInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }
}
