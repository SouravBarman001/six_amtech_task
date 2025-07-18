import '../../domain/entities/banner.dart';

/// Data model for Banner that extends the domain entity
class BannerModel extends Banner {
  const BannerModel({
    required super.id,
    required super.title,
    required super.type,
    required super.image,
  });

  /// Create BannerModel from JSON
  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: _parseInt(json['id']) ?? 0,
      title: json['title']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      image: _buildImageUrl(json['image']),
    );
  }

  /// Convert BannerModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'type': type,
      'image': image,
    };
  }

  /// Create BannerModel from domain entity
  factory BannerModel.fromEntity(Banner banner) {
    return BannerModel(
      id: banner.id,
      title: banner.title,
      type: banner.type,
      image: banner.image,
    );
  }

  /// Convert to domain entity
  Banner toEntity() {
    return Banner(
      id: id,
      title: title,
      type: type,
      image: image,
    );
  }

  /// Helper method to parse integer values safely
  static int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
  }

  /// Helper method to build complete image URL
  static String _buildImageUrl(dynamic imageValue) {
    if (imageValue == null) return '';
    
    final imageStr = imageValue.toString();
    if (imageStr.isEmpty) return '';
    
    // If it's already a complete URL, return as is
    if (imageStr.startsWith('http://') || imageStr.startsWith('https://')) {
      return imageStr;
    }
    
    // If it's a relative path, prepend the base URL
    // You can get this from your API config or environment
    const baseImageUrl = 'https://stackfood-admin.6amtech.com/storage/app/public/banner/';
    return baseImageUrl + imageStr;
  }

  /// Create a copy with modified fields
  @override
  BannerModel copyWith({
    int? id,
    String? title,
    String? type,
    String? image,
  }) {
    return BannerModel(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      image: image ?? this.image,
    );
  }
}
