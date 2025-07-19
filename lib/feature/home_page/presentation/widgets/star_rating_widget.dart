import 'package:flutter/material.dart';
import '../../../../core/utils/responsive_helper.dart';

/// A reusable star rating widget that displays stars based on rating value
class StarRatingWidget extends StatelessWidget {
  final double rating;
  final double size;
  final Color filledColor;
  final Color emptyColor;
  final bool showHalfStars;

  const StarRatingWidget({
    super.key,
    required this.rating,
    this.size = 16.0,
    this.filledColor = const Color(0xFF049D55),
    this.emptyColor = const Color(0xFFE0E0E0),
    this.showHalfStars = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          _getStarIcon(index),
          size: size,
          color: _getStarColor(index),
        );
      }),
    );
  }

  /// Get the appropriate icon for the star at the given index
  IconData _getStarIcon(int index) {
    double starValue = index + 1.0;
    
    if (rating >= starValue) {
      // Full star
      return Icons.star;
    } else if (showHalfStars && rating >= starValue - 0.5) {
      // Half star
      return Icons.star_half;
    } else {
      // Empty star
      return Icons.star_border;
    }
  }

  /// Get the appropriate color for the star at the given index
  Color _getStarColor(int index) {
    double starValue = index + 1.0;
    
    if (rating >= starValue) {
      return filledColor;
    } else if (showHalfStars && rating >= starValue - 0.5) {
      return filledColor;
    } else {
      return emptyColor;
    }
  }
}

/// A responsive star rating widget that adapts to different screen sizes
class ResponsiveStarRating extends StatelessWidget {
  final double rating;
  final Color filledColor;
  final Color emptyColor;
  final bool showHalfStars;

  const ResponsiveStarRating({
    super.key,
    required this.rating,
    this.filledColor = const Color(0xFF049D55),
    this.emptyColor = const Color(0xFFE0E0E0),
    this.showHalfStars = true,
  });

  @override
  Widget build(BuildContext context) {
    return StarRatingWidget(
      rating: rating,
      size: ResponsiveHelper.getIconSize(
        context: context,
        mobile: 10.0,
        tablet: 11.0,
        desktop: 12.0,
      ),
      filledColor: filledColor,
      emptyColor: emptyColor,
      showHalfStars: showHalfStars,
    );
  }
}
