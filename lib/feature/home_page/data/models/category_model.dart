import '../../domain/entities/category.dart';

/// Data model for Category that extends the domain entity
class CategoryModel extends Category {
  const CategoryModel({
    required super.id,
    required super.name,
    required super.image,
  });

  /// Create CategoryModel from JSON
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: _parseInt(json['id']) ?? 0,
      name: json['name']?.toString() ?? '',
      image: _buildImageUrl(json['image']),
    );
  }

  /// Convert CategoryModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }

  /// Create CategoryModel from domain entity
  factory CategoryModel.fromEntity(Category category) {
    return CategoryModel(
      id: category.id,
      name: category.name,
      image: category.image,
    );
  }

  /// Convert to domain entity
  Category toEntity() {
    return Category(
      id: id,
      name: name,
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
    const baseImageUrl = 'https://stackfood-admin.6amtech.com/storage/app/public/category/';
    return baseImageUrl + imageStr;
  }

  /// Create a copy with modified fields
  @override
  CategoryModel copyWith({
    int? id,
    String? name,
    String? image,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
    );
  }
}
