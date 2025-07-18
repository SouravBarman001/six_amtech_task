import 'package:equatable/equatable.dart';

/// Category entity representing food category data
class Category extends Equatable {
  final int id;
  final String name;
  final String image;

  const Category({
    required this.id,
    required this.name,
    required this.image,
  });

  /// Creates a copy of this Category with the given fields replaced
  Category copyWith({
    int? id,
    String? name,
    String? image,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        image,
      ];

  @override
  String toString() {
    return 'Category(id: $id, name: $name, image: $image)';
  }
}
