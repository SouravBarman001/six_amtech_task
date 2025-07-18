import '../../../../core/utils/result.dart';
import '../entities/location.dart';

/// Abstract repository interface for location operations
abstract class LocationRepository {
  /// Get current location from coordinates
  Future<Result<Location>> getCurrentLocation();
  
  /// Get location from coordinates
  Future<Result<Location>> getLocationFromCoordinates(
    double latitude,
    double longitude,
  );
  
  /// Get formatted address from coordinates
  Future<Result<String>> getAddressFromCoordinates(
    double latitude,
    double longitude,
  );
}
