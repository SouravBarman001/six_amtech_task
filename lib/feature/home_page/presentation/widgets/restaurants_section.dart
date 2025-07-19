import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import '../providers/restaurant_providers.dart';
import '../state/restaurant_state.dart';
import '../../domain/entities/restaurant.dart' as domain;
import 'star_rating_widget.dart';
import '../../../../core/utils/responsive_helper.dart';

class RestaurantsSection extends ConsumerStatefulWidget {
  const RestaurantsSection({super.key});

  @override
  ConsumerState<RestaurantsSection> createState() => _RestaurantsSectionState();
}

class _RestaurantsSectionState extends ConsumerState<RestaurantsSection> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Initialize restaurants fetch
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(restaurantNotifierProvider.notifier).getRestaurants();
    });

    // Add scroll listener for pagination
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      // Load more when near the bottom
      final canLoadMore = ref.read(canLoadMoreRestaurantsProvider);
      final isLoadingMore = ref.read(isLoadingMoreRestaurantsProvider);
      
      if (canLoadMore && !isLoadingMore) {
        ref.read(restaurantNotifierProvider.notifier).loadMoreRestaurants();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final restaurantState = ref.watch(restaurantNotifierProvider);

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveHelper.getPadding(
              context: context,
              mobile: 16.0,
              tablet: 20.0,
              desktop: 24.0,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Restaurants',
                style: TextStyle(
                  fontSize: ResponsiveHelper.getFontSize(
                    context: context,
                    mobile: 18.0,
                    tablet: 20.0,
                    desktop: 22.0,
                  ),
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF000743),
                ),
              ),
              Container(
                padding: EdgeInsets.all(
                  ResponsiveHelper.getPadding(
                    context: context,
                    mobile: 8.0,
                    tablet: 10.0,
                    desktop: 12.0,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(
                    ResponsiveHelper.getBorderRadius(
                      context: context,
                      mobile: 8.0,
                      tablet: 10.0,
                      desktop: 12.0,
                    ),
                  ),
                ),
                child: Icon(
                  Icons.tune,
                  size: ResponsiveHelper.getIconSize(
                    context: context,
                    mobile: 20.0,
                    tablet: 22.0,
                    desktop: 24.0,
                  ),
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: ResponsiveHelper.getHeight(
            context: context,
            mobile: 16.0,
            tablet: 18.0,
            desktop: 20.0,
          ),
        ),
        _buildRestaurantContent(restaurantState),
      ],
    );
  }

  Widget _buildRestaurantContent(RestaurantState state) {
    if (state is RestaurantInitial) {
      return const SizedBox.shrink();
    } else if (state is RestaurantLoading) {
      return _buildShimmerLoading();
    } else if (state is RestaurantLoaded) {
      return _buildRestaurantList(state.restaurants, state.hasMoreData);
    } else if (state is RestaurantLoadingMore) {
      return _buildRestaurantList(state.currentRestaurants, true, showLoadingMore: true);
    } else if (state is RestaurantError) {
      return _buildErrorWidget(state.message);
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _buildRestaurantList(List<domain.Restaurant> restaurants, bool hasMoreData, {bool showLoadingMore = false}) {
    return ListView.builder(
      controller: _scrollController,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.getPadding(
          context: context,
          mobile: 16.0,
          tablet: 20.0,
          desktop: 24.0,
        ),
      ),
      itemCount: restaurants.length + (showLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == restaurants.length && showLoadingMore) {
          return _buildLoadingMoreIndicator();
        }
        
        final restaurant = restaurants[index];
        return _buildRestaurantItem(restaurant);
      },
    );
  }

  Widget _buildRestaurantItem(domain.Restaurant restaurant) {
    return Container(
      margin: EdgeInsets.only(
        bottom: ResponsiveHelper.getMargin(
          context: context,
          mobile: 16.0,
          tablet: 18.0,
          desktop: 20.0,
        ),
      ),
      padding: EdgeInsets.only(
        left: ResponsiveHelper.getPadding(
          context: context,
          mobile: 5.0,
          tablet: 8.0,
          desktop: 10.0,
        ),
        right: ResponsiveHelper.getPadding(
          context: context,
          mobile: 18.0,
          tablet: 20.0,
          desktop: 22.0,
        ),
        top: ResponsiveHelper.getPadding(
          context: context,
          mobile: 10.0,
          tablet: 12.0,
          desktop: 14.0,
        ),
        bottom: ResponsiveHelper.getPadding(
          context: context,
          mobile: 10.0,
          tablet: 12.0,
          desktop: 14.0,
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          ResponsiveHelper.getBorderRadius(
            context: context,
            mobile: 16.0,
            tablet: 18.0,
            desktop: 20.0,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(
              ResponsiveHelper.getBorderRadius(
                context: context,
                mobile: 12.0,
                tablet: 14.0,
                desktop: 16.0,
              ),
            ),
            child: Container(
              width: ResponsiveHelper.getWidth(
                context: context,
                mobile: 80.0,
                tablet: 85.0,
                desktop: 90.0,
              ),
              height: ResponsiveHelper.getHeight(
                context: context,
                mobile: 80.0,
                tablet: 85.0,
                desktop: 90.0,
              ),
              child: CachedNetworkImage(
                imageUrl: restaurant.coverPhotoFullUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey[300],
                  child: Icon(
                    Icons.restaurant,
                    color: Colors.grey[600],
                    size: ResponsiveHelper.getIconSize(
                      context: context,
                      mobile: 30.0,
                      tablet: 32.0,
                      desktop: 34.0,
                    ),
                  ),
                ),
                errorWidget: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: Icon(
                      Icons.restaurant,
                      color: Colors.grey[600],
                      size: ResponsiveHelper.getIconSize(
                        context: context,
                        mobile: 30.0,
                        tablet: 32.0,
                        desktop: 34.0,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(
            width: ResponsiveHelper.getWidth(
              context: context,
              mobile: 12.0,
              tablet: 14.0,
              desktop: 16.0,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant.name,
                  style: TextStyle(
                    fontSize: ResponsiveHelper.getFontSize(
                      context: context,
                      mobile: 16.0,
                      tablet: 18.0,
                      desktop: 20.0,
                    ),
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: ResponsiveHelper.getHeight(
                    context: context,
                    mobile: 4.0,
                    tablet: 5.0,
                    desktop: 6.0,
                  ),
                ),
                Text(
                  'Restaurant', // Default text since restaurant type is not in API
                  style: TextStyle(
                    fontSize: ResponsiveHelper.getFontSize(
                      context: context,
                      mobile: 14.0,
                      tablet: 15.0,
                      desktop: 16.0,
                    ),
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(
                  height: ResponsiveHelper.getHeight(
                    context: context,
                    mobile: 8.0,
                    tablet: 10.0,
                    desktop: 12.0,
                  ),
                ),
                Row(
                  children: [
                    StarRatingWidget(
                      rating: restaurant.avgRating,
                      size: ResponsiveHelper.getIconSize(
                        context: context,
                        mobile: 14.0,
                        tablet: 15.0,
                        desktop: 16.0,
                      ),
                      filledColor: const Color(0xFFFFB800),
                      emptyColor: Colors.grey[300]!,
                    ),
                    SizedBox(
                      width: ResponsiveHelper.getWidth(
                        context: context,
                        mobile: 8.0,
                        tablet: 10.0,
                        desktop: 12.0,
                      ),
                    ),
                    Text(
                      restaurant.formattedRating,
                      style: TextStyle(
                        fontSize: ResponsiveHelper.getFontSize(
                          context: context,
                          mobile: 12.0,
                          tablet: 13.0,
                          desktop: 14.0,
                        ),
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(
                  ResponsiveHelper.getPadding(
                    context: context,
                    mobile: 8.0,
                    tablet: 10.0,
                    desktop: 12.0,
                  ),
                ),
                child: Icon(
                  Icons.favorite_border,
                  size: ResponsiveHelper.getIconSize(
                    context: context,
                    mobile: 24.0,
                    tablet: 26.0,
                    desktop: 28.0,
                  ),
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(
                height: ResponsiveHelper.getHeight(
                  context: context,
                  mobile: 12.0,
                  tablet: 14.0,
                  desktop: 16.0,
                ),
              ),
              Container(
                width: ResponsiveHelper.getWidth(
                  context: context,
                  mobile: 32.0,
                  tablet: 34.0,
                  desktop: 36.0,
                ),
                height: ResponsiveHelper.getHeight(
                  context: context,
                  mobile: 32.0,
                  tablet: 34.0,
                  desktop: 36.0,
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.black,
                  size: ResponsiveHelper.getIconSize(
                    context: context,
                    mobile: 26.0,
                    tablet: 28.0,
                    desktop: 30.0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveHelper.getPadding(
            context: context,
            mobile: 16.0,
            tablet: 20.0,
            desktop: 24.0,
          ),
        ),
        itemCount: 3, // Show 3 shimmer items
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(
              bottom: ResponsiveHelper.getMargin(
                context: context,
                mobile: 16.0,
                tablet: 18.0,
                desktop: 20.0,
              ),
            ),
            padding: EdgeInsets.all(
              ResponsiveHelper.getPadding(
                context: context,
                mobile: 16.0,
                tablet: 18.0,
                desktop: 20.0,
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                ResponsiveHelper.getBorderRadius(
                  context: context,
                  mobile: 16.0,
                  tablet: 18.0,
                  desktop: 20.0,
                ),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: ResponsiveHelper.getWidth(
                    context: context,
                    mobile: 80.0,
                    tablet: 85.0,
                    desktop: 90.0,
                  ),
                  height: ResponsiveHelper.getHeight(
                    context: context,
                    mobile: 80.0,
                    tablet: 85.0,
                    desktop: 90.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(
                      ResponsiveHelper.getBorderRadius(
                        context: context,
                        mobile: 12.0,
                        tablet: 14.0,
                        desktop: 16.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: ResponsiveHelper.getWidth(
                    context: context,
                    mobile: 12.0,
                    tablet: 14.0,
                    desktop: 16.0,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: ResponsiveHelper.getHeight(
                          context: context,
                          mobile: 16.0,
                          tablet: 18.0,
                          desktop: 20.0,
                        ),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(
                            ResponsiveHelper.getBorderRadius(
                              context: context,
                              mobile: 4.0,
                              tablet: 5.0,
                              desktop: 6.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: ResponsiveHelper.getHeight(
                          context: context,
                          mobile: 8.0,
                          tablet: 10.0,
                          desktop: 12.0,
                        ),
                      ),
                      Container(
                        height: ResponsiveHelper.getHeight(
                          context: context,
                          mobile: 14.0,
                          tablet: 16.0,
                          desktop: 18.0,
                        ),
                        width: ResponsiveHelper.getWidth(
                          context: context,
                          mobile: 100.0,
                          tablet: 110.0,
                          desktop: 120.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(
                            ResponsiveHelper.getBorderRadius(
                              context: context,
                              mobile: 4.0,
                              tablet: 5.0,
                              desktop: 6.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: ResponsiveHelper.getHeight(
                          context: context,
                          mobile: 8.0,
                          tablet: 10.0,
                          desktop: 12.0,
                        ),
                      ),
                      Row(
                        children: [
                          Row(
                            children: List.generate(5, (index) => Container(
                              width: ResponsiveHelper.getWidth(
                                context: context,
                                mobile: 14.0,
                                tablet: 15.0,
                                desktop: 16.0,
                              ),
                              height: ResponsiveHelper.getHeight(
                                context: context,
                                mobile: 14.0,
                                tablet: 15.0,
                                desktop: 16.0,
                              ),
                              margin: EdgeInsets.only(
                                right: ResponsiveHelper.getMargin(
                                  context: context,
                                  mobile: 2.0,
                                  tablet: 3.0,
                                  desktop: 4.0,
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                shape: BoxShape.circle,
                              ),
                            )),
                          ),
                          SizedBox(
                            width: ResponsiveHelper.getWidth(
                              context: context,
                              mobile: 8.0,
                              tablet: 10.0,
                              desktop: 12.0,
                            ),
                          ),
                          Container(
                            height: ResponsiveHelper.getHeight(
                              context: context,
                              mobile: 12.0,
                              tablet: 14.0,
                              desktop: 16.0,
                            ),
                            width: ResponsiveHelper.getWidth(
                              context: context,
                              mobile: 30.0,
                              tablet: 35.0,
                              desktop: 40.0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(
                                ResponsiveHelper.getBorderRadius(
                                  context: context,
                                  mobile: 4.0,
                                  tablet: 5.0,
                                  desktop: 6.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      width: ResponsiveHelper.getWidth(
                        context: context,
                        mobile: 24.0,
                        tablet: 26.0,
                        desktop: 28.0,
                      ),
                      height: ResponsiveHelper.getHeight(
                        context: context,
                        mobile: 24.0,
                        tablet: 26.0,
                        desktop: 28.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(
                      height: ResponsiveHelper.getHeight(
                        context: context,
                        mobile: 12.0,
                        tablet: 14.0,
                        desktop: 16.0,
                      ),
                    ),
                    Container(
                      width: ResponsiveHelper.getWidth(
                        context: context,
                        mobile: 32.0,
                        tablet: 34.0,
                        desktop: 36.0,
                      ),
                      height: ResponsiveHelper.getHeight(
                        context: context,
                        mobile: 32.0,
                        tablet: 34.0,
                        desktop: 36.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(
                          ResponsiveHelper.getBorderRadius(
                            context: context,
                            mobile: 8.0,
                            tablet: 10.0,
                            desktop: 12.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLoadingMoreIndicator() {
    return Container(
      padding: EdgeInsets.all(
        ResponsiveHelper.getPadding(
          context: context,
          mobile: 16.0,
          tablet: 18.0,
          desktop: 20.0,
        ),
      ),
      child: const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF6B35)),
        ),
      ),
    );
  }

  Widget _buildErrorWidget(String message) {
    return Container(
      padding: EdgeInsets.all(
        ResponsiveHelper.getPadding(
          context: context,
          mobile: 20.0,
          tablet: 24.0,
          desktop: 28.0,
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.error_outline,
            size: ResponsiveHelper.getIconSize(
              context: context,
              mobile: 48.0,
              tablet: 52.0,
              desktop: 56.0,
            ),
            color: Colors.grey[400],
          ),
          SizedBox(
            height: ResponsiveHelper.getHeight(
              context: context,
              mobile: 16.0,
              tablet: 18.0,
              desktop: 20.0,
            ),
          ),
          Text(
            'Error loading restaurants',
            style: TextStyle(
              fontSize: ResponsiveHelper.getFontSize(
                context: context,
                mobile: 16.0,
                tablet: 18.0,
                desktop: 20.0,
              ),
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(
            height: ResponsiveHelper.getHeight(
              context: context,
              mobile: 8.0,
              tablet: 10.0,
              desktop: 12.0,
            ),
          ),
          Text(
            message,
            style: TextStyle(
              fontSize: ResponsiveHelper.getFontSize(
                context: context,
                mobile: 14.0,
                tablet: 16.0,
                desktop: 18.0,
              ),
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: ResponsiveHelper.getHeight(
              context: context,
              mobile: 16.0,
              tablet: 18.0,
              desktop: 20.0,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              HapticFeedback.mediumImpact();
              ref.read(restaurantNotifierProvider.notifier).refreshRestaurants();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF6B35),
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveHelper.getPadding(
                  context: context,
                  mobile: 20.0,
                  tablet: 24.0,
                  desktop: 28.0,
                ),
                vertical: ResponsiveHelper.getPadding(
                  context: context,
                  mobile: 12.0,
                  tablet: 14.0,
                  desktop: 16.0,
                ),
              ),
            ),
            child: Text(
              'Retry',
              style: TextStyle(
                color: Colors.white,
                fontSize: ResponsiveHelper.getFontSize(
                  context: context,
                  mobile: 14.0,
                  tablet: 16.0,
                  desktop: 18.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
