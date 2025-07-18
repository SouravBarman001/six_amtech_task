import 'package:core/core.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/location.dart';
import '../../domain/repositories/location_repository.dart';
import '../datasources/location_remote_datasource.dart';

/// Implementation of LocationRepository
class LocationRepositoryImpl implements LocationRepository {
  final LocationRemoteDataSource _remoteDataSource;

  LocationRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<Location>> getCurrentLocation() async {
    try {
      // Use the default coordinates from API constants
      const latitude = 23.735129;
      const longitude = 90.425614;
      
      final locationModel = await _remoteDataSource.getLocationFromCoordinates(
        latitude,
        longitude,
      );
      
      return Success(locationModel.toEntity());
    } on Failure catch (failure) {
      return Failed('Failed to get current location: ${failure.name}');
    } catch (e) {
      return Failed('Unexpected error occurred: ${e.toString()}');
    }
  }

  @override
  Future<Result<Location>> getLocationFromCoordinates(
    double latitude,
    double longitude,
  ) async {
    try {
      final locationModel = await _remoteDataSource.getLocationFromCoordinates(
        latitude,
        longitude,
      );
      
      return Success(locationModel.toEntity());
    } on Failure catch (failure) {
      return Failed('Failed to get location: ${failure.name}');
    } catch (e) {
      return Failed('Unexpected error occurred: ${e.toString()}');
    }
  }

  @override
  Future<Result<String>> getAddressFromCoordinates(
    double latitude,
    double longitude,
  ) async {
    try {
      final address = await _remoteDataSource.getAddressFromCoordinates(
        latitude,
        longitude,
      );
      
      return Success(address);
    } on Failure catch (failure) {
      return Failed('Failed to get address: ${failure.name}');
    } catch (e) {
      return Failed('Unexpected error occurred: ${e.toString()}');
    }
  }
}
