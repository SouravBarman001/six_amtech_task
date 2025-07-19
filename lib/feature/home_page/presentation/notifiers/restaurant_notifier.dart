import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/get_restaurants_usecase.dart';
import '../state/restaurant_state.dart';

/// Notifier for managing restaurant state and operations
class RestaurantNotifier extends StateNotifier<RestaurantState> {
  final GetRestaurantsUseCase _getRestaurantsUseCase;
  static const int _defaultLimit = 10; // Changed to 10 items per pagination

  RestaurantNotifier(this._getRestaurantsUseCase) : super(const RestaurantInitial());

  /// Get initial list of restaurants
  Future<void> getRestaurants() async {
    if (state is RestaurantLoading) return; // Prevent multiple simultaneous calls

    state = const RestaurantLoading();
    
    try {
      print('🔄 Making initial API call - Offset: 0, Limit: $_defaultLimit');
      
      final response = await _getRestaurantsUseCase.execute(
        offset: 0, // API uses 0-based offset
        limit: _defaultLimit,
      );

      // Check if we have more data based on actual response
      // If we got fewer restaurants than requested, we've reached the end
      final hasMoreData = response.restaurants.length >= _defaultLimit;

      print('✅ Loaded ${response.restaurants.length} restaurants');
      print('📊 Total available: ${response.totalSize}');
      print('📄 Has more: $hasMoreData (received ${response.restaurants.length}/$_defaultLimit)');

      state = RestaurantLoaded(
        restaurants: response.restaurants,
        hasMoreData: hasMoreData,
        totalSize: response.totalSize,
        currentOffset: _defaultLimit, // Next offset will be 10
      );
    } catch (e) {
      print('❌ Error loading restaurants: $e');
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
      final nextOffset = currentState.currentOffset; // Use currentOffset directly as next offset
      print('🔄 Loading more - Offset: $nextOffset, Limit: $_defaultLimit');
      print('📊 Current loaded: ${currentState.restaurants.length}');
      
      final response = await _getRestaurantsUseCase.execute(
        offset: nextOffset,
        limit: _defaultLimit,
      );

      // Combine current restaurants with new ones
      final allRestaurants = [
        ...currentState.restaurants,
        ...response.restaurants,
      ];

      // Check if we have more data based on actual response
      // If we got fewer restaurants than requested, we've reached the end
      final hasMoreData = response.restaurants.length >= _defaultLimit;

      print('✅ Loaded ${response.restaurants.length} more restaurants');
      print('📊 Total loaded: ${allRestaurants.length}/${response.totalSize}');
      print('📄 Has more: $hasMoreData (received ${response.restaurants.length}/$_defaultLimit)');

      state = RestaurantLoaded(
        restaurants: allRestaurants,
        hasMoreData: hasMoreData,
        totalSize: response.totalSize,
        currentOffset: nextOffset + _defaultLimit, // Next offset
      );
    } catch (e) {
      print('❌ Error loading more restaurants: $e');
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
