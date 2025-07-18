import '../../domain/entities/location.dart';

/// State class for location feature
class LocationState {
  final Location? currentLocation;
  final bool isLoading;
  final String? errorMessage;

  const LocationState({
    this.currentLocation,
    this.isLoading = false,
    this.errorMessage,
  });

  /// Create a copy with modified fields
  LocationState copyWith({
    Location? currentLocation,
    bool? isLoading,
    String? errorMessage,
  }) {
    return LocationState(
      currentLocation: currentLocation ?? this.currentLocation,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  /// Create initial state
  factory LocationState.initial() => const LocationState();

  /// Create loading state
  LocationState loading() => copyWith(isLoading: true, errorMessage: null);

  /// Create success state
  LocationState success(Location location) => copyWith(
        currentLocation: location,
        isLoading: false,
        errorMessage: null,
      );

  /// Create error state
  LocationState error(String message) => copyWith(
        isLoading: false,
        errorMessage: message,
      );

  @override
  String toString() {
    return 'LocationState(currentLocation: $currentLocation, isLoading: $isLoading, errorMessage: $errorMessage)';
  }
}
