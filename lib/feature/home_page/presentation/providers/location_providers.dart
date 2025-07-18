import 'package:core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/location_remote_datasource.dart';
import '../../data/repositories/location_repository_impl.dart';
import '../../domain/repositories/location_repository.dart';
import '../../domain/usecases/get_address_from_coordinates_usecase.dart';
import '../../domain/usecases/get_current_location_usecase.dart';
import '../state/location_notifier.dart';
import '../state/location_state.dart';

/// Provider for LocationRemoteDataSource
final locationRemoteDataSourceProvider = Provider<LocationRemoteDataSource>(
  (ref) {
    final apiService = ref.read(stackFoodApiServiceProvider);
    return LocationRemoteDataSourceImpl(apiService);
  },
);

/// Provider for LocationRepository
final locationRepositoryProvider = Provider<LocationRepository>(
  (ref) {
    final remoteDataSource = ref.read(locationRemoteDataSourceProvider);
    return LocationRepositoryImpl(remoteDataSource);
  },
);

/// Provider for GetCurrentLocationUseCase
final getCurrentLocationUseCaseProvider = Provider<GetCurrentLocationUseCase>(
  (ref) {
    final repository = ref.read(locationRepositoryProvider);
    return GetCurrentLocationUseCase(repository);
  },
);

/// Provider for GetAddressFromCoordinatesUseCase
final getAddressFromCoordinatesUseCaseProvider = Provider<GetAddressFromCoordinatesUseCase>(
  (ref) {
    final repository = ref.read(locationRepositoryProvider);
    return GetAddressFromCoordinatesUseCase(repository);
  },
);

/// Provider for LocationNotifier
final locationNotifierProvider = StateNotifierProvider<LocationNotifier, LocationState>(
  (ref) {
    final getCurrentLocationUseCase = ref.read(getCurrentLocationUseCaseProvider);
    final getAddressFromCoordinatesUseCase = ref.read(getAddressFromCoordinatesUseCaseProvider);
    
    return LocationNotifier(
      getCurrentLocationUseCase,
      getAddressFromCoordinatesUseCase,
    );
  },
);

/// Convenience provider for accessing location state
final locationStateProvider = Provider<LocationState>(
  (ref) => ref.watch(locationNotifierProvider),
);

/// Provider for checking if location is loading
final isLocationLoadingProvider = Provider<bool>(
  (ref) => ref.watch(locationNotifierProvider.select((state) => state.isLoading)),
);

/// Provider for getting location error message
final locationErrorProvider = Provider<String?>(
  (ref) => ref.watch(locationNotifierProvider.select((state) => state.errorMessage)),
);

/// Provider for getting current location address
final currentLocationAddressProvider = Provider<String?>(
  (ref) {
    final location = ref.watch(locationNotifierProvider.select((state) => state.currentLocation));
    return location?.formattedAddress ?? location?.address;
  },
);
