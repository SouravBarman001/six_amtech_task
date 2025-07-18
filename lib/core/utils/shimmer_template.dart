import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// A comprehensive shimmer effect template for loading states
/// Can be used for banners, categories, popular food, campaigns, and restaurants
class ShimmerTemplate extends StatelessWidget {
  const ShimmerTemplate._({
    super.key,
    required this.child,
    this.baseColor,
    this.highlightColor,
    this.enabled = true,
  });

  final Widget child;
  final Color? baseColor;
  final Color? highlightColor;
  final bool enabled;

  /// Banner shimmer effect - horizontal rectangular card
  factory ShimmerTemplate.banner({
    Key? key,
    double height = 180.0,
    double? width,
    BorderRadius? borderRadius,
    bool enabled = true,
  }) {
    return ShimmerTemplate._(
      key: key,
      enabled: enabled,
      child: Container(
        height: height,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius ?? BorderRadius.circular(12.0),
        ),
      ),
    );
  }

  /// Category item shimmer effect - square card with text below
  factory ShimmerTemplate.category({
    Key? key,
    double size = 80.0,
    bool enabled = true,
  }) {
    return ShimmerTemplate._(
      key: key,
      enabled: enabled,
      child: Column(
        children: [
          Container(
            height: size,
            width: size,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          const SizedBox(height: 8.0),
          Container(
            height: 12.0,
            width: size * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6.0),
            ),
          ),
          const SizedBox(height: 4.0),
          Container(
            height: 10.0,
            width: size * 0.6,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ],
      ),
    );
  }

  /// Food item shimmer effect - rectangular card with image and details
  factory ShimmerTemplate.foodItem({
    Key? key,
    double height = 200.0,
    double width = 160.0,
    bool enabled = true,
  }) {
    return ShimmerTemplate._(
      key: key,
      enabled: enabled,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image placeholder
            Container(
              height: height * 0.6,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Container(
                    height: 14.0,
                    width: width * 0.8,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                  ),
                  const SizedBox(height: 6.0),
                  // Subtitle
                  Container(
                    height: 12.0,
                    width: width * 0.6,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  // Price
                  Container(
                    height: 16.0,
                    width: width * 0.4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Restaurant item shimmer effect - horizontal card with image and details
  factory ShimmerTemplate.restaurant({
    Key? key,
    double height = 120.0,
    bool enabled = true,
  }) {
    return ShimmerTemplate._(
      key: key,
      enabled: enabled,
      child: Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          children: [
            // Image placeholder
            Container(
              height: height,
              width: height,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  bottomLeft: Radius.circular(12.0),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Restaurant name
                    Container(
                      height: 16.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    // Cuisine type
                    Container(
                      height: 12.0,
                      width: 150.0,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                    ),
                    // Rating and delivery info
                    Row(
                      children: [
                        Container(
                          height: 12.0,
                          width: 60.0,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                        ),
                        const SizedBox(width: 12.0),
                        Container(
                          height: 12.0,
                          width: 80.0,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Campaign item shimmer effect - square card with rounded corners
  factory ShimmerTemplate.campaign({
    Key? key,
    double height = 160.0,
    double width = 120.0,
    bool enabled = true,
  }) {
    return ShimmerTemplate._(
      key: key,
      enabled: enabled,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          children: [
            // Image placeholder
            Container(
              height: height * 0.7,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 12.0,
                      width: width * 0.8,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Container(
                      height: 10.0,
                      width: width * 0.6,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Custom shimmer template for any widget
  factory ShimmerTemplate.custom({
    Key? key,
    required Widget child,
    Color? baseColor,
    Color? highlightColor,
    bool enabled = true,
  }) {
    return ShimmerTemplate._(
      key: key,
      baseColor: baseColor,
      highlightColor: highlightColor,
      enabled: enabled,
      child: child,
    );
  }

  /// List shimmer effect - vertical list of items
  static Widget list({
    Key? key,
    required Widget Function() itemBuilder,
    int itemCount = 5,
    double spacing = 12.0,
    EdgeInsets? padding,
    bool enabled = true,
  }) {
    return ListView.separated(
      key: key,
      padding: padding ?? const EdgeInsets.all(16.0),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: itemCount,
      separatorBuilder: (context, index) => SizedBox(height: spacing),
      itemBuilder: (context, index) => ShimmerTemplate._(
        enabled: enabled,
        child: itemBuilder(),
      ),
    );
  }

  /// Grid shimmer effect - grid layout of items
  static Widget grid({
    Key? key,
    required Widget Function() itemBuilder,
    int itemCount = 6,
    int crossAxisCount = 2,
    double spacing = 12.0,
    EdgeInsets? padding,
    double childAspectRatio = 1.0,
    bool enabled = true,
  }) {
    return GridView.builder(
      key: key,
      padding: padding ?? const EdgeInsets.all(16.0),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) => ShimmerTemplate._(
        enabled: enabled,
        child: itemBuilder(),
      ),
    );
  }

  /// Horizontal list shimmer effect
  static Widget horizontalList({
    Key? key,
    required Widget Function() itemBuilder,
    int itemCount = 5,
    double spacing = 12.0,
    EdgeInsets? padding,
    double? itemWidth,
    bool enabled = true,
  }) {
    return SizedBox(
      height: 200.0, // Default height, can be customized
      child: ListView.separated(
        key: key,
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 16.0),
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itemCount,
        separatorBuilder: (context, index) => SizedBox(width: spacing),
        itemBuilder: (context, index) => SizedBox(
          width: itemWidth,
          child: ShimmerTemplate._(
            enabled: enabled,
            child: itemBuilder(),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!enabled) {
      return child;
    }

    return Shimmer.fromColors(
      baseColor: baseColor ?? Colors.grey[300]!,
      highlightColor: highlightColor ?? Colors.grey[100]!,
      child: child,
    );
  }
}

/// Extension methods for easier shimmer usage
extension ShimmerExtension on Widget {
  /// Apply shimmer effect to any widget
  Widget shimmer({
    Color? baseColor,
    Color? highlightColor,
    bool enabled = true,
  }) {
    return ShimmerTemplate.custom(
      baseColor: baseColor,
      highlightColor: highlightColor,
      enabled: enabled,
      child: this,
    );
  }
}
