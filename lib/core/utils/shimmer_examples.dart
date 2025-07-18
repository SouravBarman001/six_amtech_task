import 'package:flutter/material.dart';
import 'shimmer_template.dart';

/// Example usage widgets for ShimmerTemplate
/// This file demonstrates how to use different shimmer effects

class ShimmerExamples extends StatelessWidget {
  const ShimmerExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shimmer Examples'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('Banner Shimmer', _buildBannerExample()),
            _buildSection('Category Grid Shimmer', _buildCategoryExample()),
            _buildSection('Popular Food Shimmer', _buildFoodExample()),
            _buildSection('Campaign Shimmer', _buildCampaignExample()),
            _buildSection('Restaurant Shimmer', _buildRestaurantExample()),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        child,
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildBannerExample() {
    return Column(
      children: [
        // Single banner
        ShimmerTemplate.banner(
          height: 180,
          borderRadius: BorderRadius.circular(16),
        ),
        const SizedBox(height: 12),
        // Horizontal banner list
        ShimmerTemplate.horizontalList(
          itemBuilder: () => ShimmerTemplate.banner(
            height: 120,
            borderRadius: BorderRadius.circular(12),
          ),
          itemWidth: 300,
          itemCount: 3,
        ),
      ],
    );
  }

  Widget _buildCategoryExample() {
    return ShimmerTemplate.grid(
      itemBuilder: () => ShimmerTemplate.category(size: 80),
      crossAxisCount: 4,
      itemCount: 8,
      childAspectRatio: 0.8,
    );
  }

  Widget _buildFoodExample() {
    return Column(
      children: [
        // Horizontal food list
        ShimmerTemplate.horizontalList(
          itemBuilder: () => ShimmerTemplate.foodItem(
            height: 220,
            width: 160,
          ),
          itemWidth: 160,
          itemCount: 4,
        ),
        const SizedBox(height: 16),
        // Vertical food list
        ShimmerTemplate.list(
          itemBuilder: () => ShimmerTemplate.foodItem(
            height: 120,
            width: double.infinity,
          ),
          itemCount: 3,
        ),
      ],
    );
  }

  Widget _buildCampaignExample() {
    return ShimmerTemplate.horizontalList(
      itemBuilder: () => ShimmerTemplate.campaign(
        height: 160,
        width: 120,
      ),
      itemWidth: 120,
      itemCount: 5,
    );
  }

  Widget _buildRestaurantExample() {
    return ShimmerTemplate.list(
      itemBuilder: () => ShimmerTemplate.restaurant(height: 120),
      itemCount: 4,
    );
  }
}

/// Individual shimmer widgets that can be used in actual screens

class BannerShimmer extends StatelessWidget {
  final double height;
  final BorderRadius? borderRadius;

  const BannerShimmer({
    super.key,
    this.height = 180,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ShimmerTemplate.banner(
      height: height,
      borderRadius: borderRadius ?? BorderRadius.circular(12),
    );
  }
}

class CategoryGridShimmer extends StatelessWidget {
  final int itemCount;
  final int crossAxisCount;

  const CategoryGridShimmer({
    super.key,
    this.itemCount = 8,
    this.crossAxisCount = 4,
  });

  @override
  Widget build(BuildContext context) {
    return ShimmerTemplate.grid(
      itemBuilder: () => ShimmerTemplate.category(),
      crossAxisCount: crossAxisCount,
      itemCount: itemCount,
      childAspectRatio: 0.8,
    );
  }
}

class PopularFoodShimmer extends StatelessWidget {
  final int itemCount;

  const PopularFoodShimmer({
    super.key,
    this.itemCount = 4,
  });

  @override
  Widget build(BuildContext context) {
    return ShimmerTemplate.horizontalList(
      itemBuilder: () => ShimmerTemplate.foodItem(
        height: 200,
        width: 160,
      ),
      itemWidth: 160,
      itemCount: itemCount,
    );
  }
}

class FoodCampaignShimmer extends StatelessWidget {
  final int itemCount;

  const FoodCampaignShimmer({
    super.key,
    this.itemCount = 5,
  });

  @override
  Widget build(BuildContext context) {
    return ShimmerTemplate.horizontalList(
      itemBuilder: () => ShimmerTemplate.campaign(
        height: 160,
        width: 120,
      ),
      itemWidth: 120,
      itemCount: itemCount,
    );
  }
}

class RestaurantListShimmer extends StatelessWidget {
  final int itemCount;

  const RestaurantListShimmer({
    super.key,
    this.itemCount = 5,
  });

  @override
  Widget build(BuildContext context) {
    return ShimmerTemplate.list(
      itemBuilder: () => ShimmerTemplate.restaurant(),
      itemCount: itemCount,
    );
  }
}

/// Extension widget for quick shimmer replacement
class LoadingWrapper extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  final Widget shimmer;

  const LoadingWrapper({
    super.key,
    required this.isLoading,
    required this.child,
    required this.shimmer,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading ? shimmer : child;
  }
}

/// Quick shimmer builders for common use cases
class QuickShimmers {
  static Widget bannerList({int count = 3}) {
    return ShimmerTemplate.horizontalList(
      itemBuilder: () => ShimmerTemplate.banner(height: 150),
      itemWidth: 280,
      itemCount: count,
    );
  }

  static Widget categoryGrid({int count = 8}) {
    return ShimmerTemplate.grid(
      itemBuilder: () => ShimmerTemplate.category(),
      crossAxisCount: 4,
      itemCount: count,
      childAspectRatio: 0.8,
    );
  }

  static Widget foodGrid({int count = 6}) {
    return ShimmerTemplate.grid(
      itemBuilder: () => ShimmerTemplate.foodItem(height: 200, width: 160),
      crossAxisCount: 2,
      itemCount: count,
      childAspectRatio: 0.75,
    );
  }

  static Widget restaurantList({int count = 5}) {
    return ShimmerTemplate.list(
      itemBuilder: () => ShimmerTemplate.restaurant(),
      itemCount: count,
    );
  }
}
