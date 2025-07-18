import 'package:equatable/equatable.dart';

/// Location entity representing geographical coordinates and address
class Location extends Equatable {
  final double latitude;
  final double longitude;
  final String? address;
  final String? city;
  final String? country;
  final String? formattedAddress;

  const Location({
    required this.latitude,
    required this.longitude,
    this.address,
    this.city,
    this.country,
    this.formattedAddress,
  });

  /// Creates a copy of this Location with the given fields replaced
  Location copyWith({
    double? latitude,
    double? longitude,
    String? address,
    String? city,
    String? country,
    String? formattedAddress,
  }) {
    return Location(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
      city: city ?? this.city,
      country: country ?? this.country,
      formattedAddress: formattedAddress ?? this.formattedAddress,
    );
  }

  @override
  List<Object?> get props => [
        latitude,
        longitude,
        address,
        city,
        country,
        formattedAddress,
      ];

  @override
  String toString() {
    return 'Location(latitude: $latitude, longitude: $longitude, address: $address, city: $city, country: $country, formattedAddress: $formattedAddress)';
  }
}
