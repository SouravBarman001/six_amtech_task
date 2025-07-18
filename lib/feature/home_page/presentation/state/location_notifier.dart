import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/result.dart';
import '../../domain/usecases/get_current_location_usecase.dart';
import '../../domain/usecases/get_address_from_coordinates_usecase.dart';
import 'location_state.dart';

/// Notifier for managing location state
class LocationNotifier extends StateNotifier<LocationState> {
  final GetCurrentLocationUseCase _getCurrentLocationUseCase;
  final GetAddressFromCoordinatesUseCase _getAddressFromCoordinatesUseCase;

  LocationNotifier(
    this._getCurrentLocationUseCase,
    this._getAddressFromCoordinatesUseCase,
  ) : super(LocationState.initial());

  /// Get current location
  Future<void> getCurrentLocation() async {
    state = state.loading();

    final result = await _getCurrentLocationUseCase();

    switch (result) {
      case Success(:final data):
        state = state.success(data);
      case Failed(:final message):
        state = state.error(message);
    }
  }

  /// Get address from specific coordinates
  Future<void> getAddressFromCoordinates(
    double latitude,
    double longitude,
  ) async {
    final result = await _getAddressFromCoordinatesUseCase(latitude, longitude);

    switch (result) {
      case Success(:final data):
        // Update the current location with the new address
        if (state.currentLocation != null) {
          final updatedLocation = state.currentLocation!.copyWith(
            formattedAddress: data,
          );
          state = state.success(updatedLocation);
        }
      case Failed(:final message):
        state = state.error(message);
    }
  }

  /// Clear error state
  void clearError() {
    if (state.errorMessage != null) {
      state = state.copyWith(errorMessage: null);
    }
  }

  /// Refresh current location
  Future<void> refreshLocation() async {
    await getCurrentLocation();
  }
}
