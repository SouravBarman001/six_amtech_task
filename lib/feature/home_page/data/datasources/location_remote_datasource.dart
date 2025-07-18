import 'package:core/core.dart';
import '../models/location_model.dart';

/// Abstract data source for remote location operations
abstract class LocationRemoteDataSource {
  /// Get location data from API using coordinates
  Future<LocationModel> getLocationFromCoordinates(
    double latitude,
    double longitude,
  );
  
  /// Get address string from coordinates using reverse geocoding
  Future<String> getAddressFromCoordinates(
    double latitude,
    double longitude,
  );
}

/// Implementation of LocationRemoteDataSource
class LocationRemoteDataSourceImpl implements LocationRemoteDataSource {
  final StackFoodApiService _apiService;

  LocationRemoteDataSourceImpl(this._apiService);

  @override
  Future<LocationModel> getLocationFromCoordinates(
    double latitude,
    double longitude,
  ) async {
    try {
      // For now, we create a location model with the provided coordinates
      // In a real app, you might call a geocoding service here
      
      // Get address from coordinates
      final address = await getAddressFromCoordinates(latitude, longitude);
      
      return LocationModel(
        latitude: latitude,
        longitude: longitude,
        formattedAddress: address,
        address: _extractStreetAddress(address),
        city: _extractCity(address),
        country: _extractCountry(address),
      );
    } catch (e) {
      throw const InternalServerError('Failed to get location from coordinates');
    }
  }

  @override
  Future<String> getAddressFromCoordinates(
    double latitude,
    double longitude,
  ) async {
    try {
      // For this implementation, we'll use the default address from the API constants
      // In a real app, you would call a geocoding service
      
      // You can extend this to call an actual geocoding API
      // For now, return a formatted address based on the coordinates
      if (latitude == 23.735129 && longitude == 90.425614) {
        return "76A eighth avenue, New York, US";
      }
      
      return "Location at ${latitude.toStringAsFixed(6)}, ${longitude.toStringAsFixed(6)}";
    } catch (e) {
      throw const InternalServerError('Failed to get address from coordinates');
    }
  }

  /// Extract street address from full address
  String? _extractStreetAddress(String fullAddress) {
    final parts = fullAddress.split(',');
    return parts.isNotEmpty ? parts.first.trim() : null;
  }

  /// Extract city from full address
  String? _extractCity(String fullAddress) {
    final parts = fullAddress.split(',');
    return parts.length > 1 ? parts[1].trim() : null;
  }

  /// Extract country from full address
  String? _extractCountry(String fullAddress) {
    final parts = fullAddress.split(',');
    return parts.length > 2 ? parts.last.trim() : null;
  }
}
