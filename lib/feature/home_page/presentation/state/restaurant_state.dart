import 'package:equatable/equatable.dart';
import '../../domain/entities/restaurant.dart';

/// State for restaurant operations
abstract class RestaurantState extends Equatable {
  const RestaurantState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class RestaurantInitial extends RestaurantState {
  const RestaurantInitial();
}

/// Loading state for initial load
class RestaurantLoading extends RestaurantState {
  const RestaurantLoading();
}

/// Loading more restaurants (pagination)
class RestaurantLoadingMore extends RestaurantState {
  final List<Restaurant> currentRestaurants;

  const RestaurantLoadingMore(this.currentRestaurants);

  @override
  List<Object?> get props => [currentRestaurants];
}

/// Success state with restaurant data
class RestaurantLoaded extends RestaurantState {
  final List<Restaurant> restaurants;
  final bool hasMoreData;
  final int totalSize;
  final int currentOffset;

  const RestaurantLoaded({
    required this.restaurants,
    required this.hasMoreData,
    required this.totalSize,
    required this.currentOffset,
  });

  @override
  List<Object?> get props => [restaurants, hasMoreData, totalSize, currentOffset];

  /// Create a copy with updated data (for pagination)
  RestaurantLoaded copyWith({
    List<Restaurant>? restaurants,
    bool? hasMoreData,
    int? totalSize,
    int? currentOffset,
  }) {
    return RestaurantLoaded(
      restaurants: restaurants ?? this.restaurants,
      hasMoreData: hasMoreData ?? this.hasMoreData,
      totalSize: totalSize ?? this.totalSize,
      currentOffset: currentOffset ?? this.currentOffset,
    );
  }
}

/// Error state
class RestaurantError extends RestaurantState {
  final String message;

  const RestaurantError(this.message);

  @override
  List<Object?> get props => [message];
}
