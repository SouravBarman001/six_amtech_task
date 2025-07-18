import 'package:equatable/equatable.dart';

/// Banner entity representing promotional banner data
class Banner extends Equatable {
  final int id;
  final String title;
  final String type;
  final String image;

  const Banner({
    required this.id,
    required this.title,
    required this.type,
    required this.image,
  });

  /// Creates a copy of this Banner with the given fields replaced
  Banner copyWith({
    int? id,
    String? title,
    String? type,
    String? image,
  }) {
    return Banner(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      image: image ?? this.image,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        type,
        image,
      ];

  @override
  String toString() {
    return 'Banner(id: $id, title: $title, type: $type, image: $image)';
  }
}
