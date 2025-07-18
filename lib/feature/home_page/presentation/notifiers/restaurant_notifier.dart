import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/get_restaurants_usecase.dart';
import '../state/restaurant_state.dart';

/// Notifier for managing restaurant state and operations
class RestaurantNotifier extends StateNotifier<RestaurantState> {
  final GetRestaurantsUseCase _getRestaurantsUseCase;
  static const int _defaultLimit = 10;

  RestaurantNotifier(this._getRestaurantsUseCase) : super(const RestaurantInitial());

  /// Get initial list of restaurants
  Future<void> getRestaurants() async {
    if (state is RestaurantLoading) return; // Prevent multiple simultaneous calls

    state = const RestaurantLoading();
    
    try {
      final response = await _getRestaurantsUseCase.execute(
        offset: 1, // API uses 1-based offset
        limit: _defaultLimit,
      );

      state = RestaurantLoaded(
        restaurants: response.restaurants,
        hasMoreData: response.hasMoreData,
        totalSize: response.totalSize,
        currentOffset: int.tryParse(response.offset) ?? 1,
      );
    } catch (e) {
      state = RestaurantError('Failed to load restaurants: ${e.toString()}');
    }
  }

  /// Load more restaurants (pagination)
  Future<void> loadMoreRestaurants() async {
    final currentState = state;
    if (currentState is! RestaurantLoaded) return;
    if (!currentState.hasMoreData) return;
    if (state is RestaurantLoadingMore) return; // Prevent multiple calls

    state = RestaurantLoadingMore(currentState.restaurants);

    try {
      final nextOffset = currentState.currentOffset + _defaultLimit;
      final response = await _getRestaurantsUseCase.execute(
        offset: nextOffset,
        limit: _defaultLimit,
      );

      // Combine current restaurants with new ones
      final allRestaurants = [
        ...currentState.restaurants,
        ...response.restaurants,
      ];

      state = RestaurantLoaded(
        restaurants: allRestaurants,
        hasMoreData: response.hasMoreData,
        totalSize: response.totalSize,
        currentOffset: nextOffset,
      );
    } catch (e) {
      // Revert to previous state on error
      state = currentState;
      // You might want to show a snackbar or toast here
    }
  }

  /// Refresh the restaurant list
  Future<void> refreshRestaurants() async {
    state = const RestaurantInitial();
    await getRestaurants();
  }
}
