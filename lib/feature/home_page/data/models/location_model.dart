import '../../domain/entities/location.dart';

/// Data model for Location that extends the domain entity
class LocationModel extends Location {
  const LocationModel({
    required super.latitude,
    required super.longitude,
    super.address,
    super.city,
    super.country,
    super.formattedAddress,
  });

  /// Create LocationModel from JSON
  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      latitude: _parseDouble(json['latitude']) ?? 0.0,
      longitude: _parseDouble(json['longitude']) ?? 0.0,
      address: json['address'] as String?,
      city: json['city'] as String?,
      country: json['country'] as String?,
      formattedAddress: json['formatted_address'] as String?,
    );
  }

  /// Convert LocationModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'city': city,
      'country': country,
      'formatted_address': formattedAddress,
    };
  }

  /// Create LocationModel from domain entity
  factory LocationModel.fromEntity(Location location) {
    return LocationModel(
      latitude: location.latitude,
      longitude: location.longitude,
      address: location.address,
      city: location.city,
      country: location.country,
      formattedAddress: location.formattedAddress,
    );
  }

  /// Convert to domain entity
  Location toEntity() {
    return Location(
      latitude: latitude,
      longitude: longitude,
      address: address,
      city: city,
      country: country,
      formattedAddress: formattedAddress,
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
  LocationModel copyWith({
    double? latitude,
    double? longitude,
    String? address,
    String? city,
    String? country,
    String? formattedAddress,
  }) {
    return LocationModel(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
      city: city ?? this.city,
      country: country ?? this.country,
      formattedAddress: formattedAddress ?? this.formattedAddress,
    );
  }
}
