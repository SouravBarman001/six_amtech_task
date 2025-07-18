import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:core/core.dart';
import '../../data/datasources/restaurant_remote_data_source.dart';
import '../../data/repositories/restaurant_repository_impl.dart';
import '../../domain/repositories/restaurant_repository.dart';
import '../../domain/usecases/get_restaurants_usecase.dart';
import '../notifiers/restaurant_notifier.dart';
import '../state/restaurant_state.dart';

/// Provider for StackFood API service (from core module)
/// Uses the existing provider from core instead of creating a new one
final restaurantApiServiceProvider = Provider<StackFoodApiService>((ref) {
  return ref.watch(stackFoodApiServiceProvider);
});

/// Provider for restaurant remote data source
final restaurantRemoteDataSourceProvider = Provider<RestaurantRemoteDataSource>((ref) {
  final apiService = ref.watch(restaurantApiServiceProvider);
  return RestaurantRemoteDataSource(apiService);
});

/// Provider for restaurant repository
final restaurantRepositoryProvider = Provider<RestaurantRepository>((ref) {
  final remoteDataSource = ref.watch(restaurantRemoteDataSourceProvider);
  return RestaurantRepositoryImpl(remoteDataSource);
});

/// Provider for get restaurants use case
final getRestaurantsUseCaseProvider = Provider<GetRestaurantsUseCase>((ref) {
  final repository = ref.watch(restaurantRepositoryProvider);
  return GetRestaurantsUseCase(repository);
});

/// Provider for restaurant notifier
final restaurantNotifierProvider = StateNotifierProvider<RestaurantNotifier, RestaurantState>((ref) {
  final useCase = ref.watch(getRestaurantsUseCaseProvider);
  return RestaurantNotifier(useCase);
});

/// Provider to check if we can load more restaurants
final canLoadMoreRestaurantsProvider = Provider<bool>((ref) {
  final state = ref.watch(restaurantNotifierProvider);
  return state is RestaurantLoaded && state.hasMoreData;
});

/// Provider to check if restaurants are currently loading more
final isLoadingMoreRestaurantsProvider = Provider<bool>((ref) {
  final state = ref.watch(restaurantNotifierProvider);
  return state is RestaurantLoadingMore;
});
