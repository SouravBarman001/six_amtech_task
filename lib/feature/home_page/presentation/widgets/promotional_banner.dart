import 'package:flutter/material.dart';
import '../../../../core/utils/responsive_helper.dart';

class PromotionalBanner extends StatefulWidget {
  const PromotionalBanner({super.key});

  @override
  State<PromotionalBanner> createState() => _PromotionalBannerState();
}

class _PromotionalBannerState extends State<PromotionalBanner> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _totalPages = 3;

  @override
  Widget build(BuildContext context) {
    final bannerHeight = ResponsiveHelper.getHeight(
      context: context,
      mobile: 120.0,
      tablet: 140.0,
      desktop: 160.0,
    );
    
    final horizontalPadding = ResponsiveHelper.getPadding(
      context: context,
      mobile: 8.0,
      tablet: 12.0,
      desktop: 16.0,
    );
    
    return Column(
      children: [
        SizedBox(
          height: bannerHeight,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _totalPages,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: _buildBannerItem(),
              );
            },
          ),
        ),
        SizedBox(height: ResponsiveHelper.getHeight(
          context: context,
          mobile: 10.0,
          tablet: 12.0,
          desktop: 14.0,
        )),
        _buildDotIndicator(),
      ],
    );
  }

  Widget _buildDotIndicator() {
    final dotMargin = ResponsiveHelper.getMargin(
      context: context,
      mobile: 4.0,
      tablet: 5.0,
      desktop: 6.0,
    );
    
    final activeDotSize = ResponsiveHelper.getWidth(
      context: context,
      mobile: 10.0,
      tablet: 12.0,
      desktop: 14.0,
    );
    
    final inactiveDotSize = ResponsiveHelper.getWidth(
      context: context,
      mobile: 6.0,
      tablet: 8.0,
      desktop: 10.0,
    );
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_totalPages, (index) {
        bool isActive = _currentPage == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: EdgeInsets.symmetric(horizontal: dotMargin),
          width: isActive ? activeDotSize : inactiveDotSize,
          height: isActive ? activeDotSize : inactiveDotSize,
          decoration: BoxDecoration(
            color: isActive 
                ? const Color(0xFFFF6B35) 
                : Colors.grey[300],
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }

  Widget _buildBannerItem() {
    final borderRadius = ResponsiveHelper.getBorderRadius(
      context: context,
      mobile: 16.0,
      tablet: 18.0,
      desktop: 20.0,
    );
    
    final leftPadding = ResponsiveHelper.getPadding(
      context: context,
      mobile: 20.0,
      tablet: 24.0,
      desktop: 28.0,
    );
    
    final topPadding = ResponsiveHelper.getPadding(
      context: context,
      mobile: 15.0,
      tablet: 18.0,
      desktop: 20.0,
    );
    
    final badgePadding = ResponsiveHelper.getPadding(
      context: context,
      mobile: 8.0,
      tablet: 10.0,
      desktop: 12.0,
    );
    
    final badgeVerticalPadding = ResponsiveHelper.getPadding(
      context: context,
      mobile: 4.0,
      tablet: 5.0,
      desktop: 6.0,
    );
    
    final badgeBorderRadius = ResponsiveHelper.getBorderRadius(
      context: context,
      mobile: 12.0,
      tablet: 14.0,
      desktop: 16.0,
    );
    
    final badgeFontSize = ResponsiveHelper.getFontSize(
      context: context,
      mobile: 11.0,
      tablet: 12.0,
      desktop: 13.0,
    );
    
    final titleFontSize = ResponsiveHelper.getFontSize(
      context: context,
      mobile: 14.0,
      tablet: 16.0,
      desktop: 18.0,
    );
    
    final menuFontSize = ResponsiveHelper.getFontSize(
      context: context,
      mobile: 18.0,
      tablet: 20.0,
      desktop: 22.0,
    );
    
    final rightPadding = ResponsiveHelper.getPadding(
      context: context,
      mobile: 15.0,
      tablet: 20.0,
      desktop: 25.0,
    );
    
    final circleSize = ResponsiveHelper.getWidth(
      context: context,
      mobile: 70.0,
      tablet: 80.0,
      desktop: 90.0,
    );
    
    final innerCircleSize = ResponsiveHelper.getWidth(
      context: context,
      mobile: 55.0,
      tablet: 65.0,
      desktop: 75.0,
    );
    
    final iconSize = ResponsiveHelper.getIconSize(
      context: context,
      mobile: 24.0,
      tablet: 28.0,
      desktop: 32.0,
    );
    
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: const LinearGradient(
          colors: [Color(0xFFFF6B35), Color(0xFFFF8A50)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: leftPadding,
            top: topPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: badgePadding, 
                    vertical: badgeVerticalPadding,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(badgeBorderRadius),
                  ),
                  child: Text(
                    '50% off',
                    style: TextStyle(
                      fontSize: badgeFontSize,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFFF6B35),
                    ),
                  ),
                ),
                SizedBox(height: ResponsiveHelper.getHeight(
                  context: context,
                  mobile: 6.0,
                  tablet: 8.0,
                  desktop: 10.0,
                )),
                Text(
                  'TODAY',
                  style: TextStyle(
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
                Text(
                  'Special',
                  style: TextStyle(
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
                Text(
                  'MENU',
                  style: TextStyle(
                    fontSize: menuFontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: rightPadding,
            top: topPadding,
            child: Container(
              width: circleSize,
              height: circleSize,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white24,
              ),
              child: Center(
                child: Container(
                  width: innerCircleSize,
                  height: innerCircleSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.network(
                      'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=200&h=200&fit=crop&crop=center',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: Icon(
                            Icons.restaurant,
                            color: Colors.grey[600],
                            size: iconSize,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Additional food circles with responsive sizing
          _buildAdditionalCircle(
            right: ResponsiveHelper.getWidth(context: context, mobile: 40.0, tablet: 50.0, desktop: 60.0),
            top: ResponsiveHelper.getHeight(context: context, mobile: 25.0, tablet: 30.0, desktop: 35.0),
            size: ResponsiveHelper.getWidth(context: context, mobile: 40.0, tablet: 45.0, desktop: 50.0),
            iconSize: ResponsiveHelper.getIconSize(context: context, mobile: 16.0, tablet: 18.0, desktop: 20.0),
            imageUrl: 'https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445?w=100&h=100&fit=crop',
          ),
          _buildAdditionalCircle(
            right: ResponsiveHelper.getWidth(context: context, mobile: 65.0, tablet: 75.0, desktop: 85.0),
            top: ResponsiveHelper.getHeight(context: context, mobile: 45.0, tablet: 50.0, desktop: 55.0),
            size: ResponsiveHelper.getWidth(context: context, mobile: 35.0, tablet: 40.0, desktop: 45.0),
            iconSize: ResponsiveHelper.getIconSize(context: context, mobile: 14.0, tablet: 16.0, desktop: 18.0),
            imageUrl: 'https://images.unsplash.com/photo-1571091718767-18b5b1457add?w=100&h=100&fit=crop',
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalCircle({
    required double right,
    required double top,
    required double size,
    required double iconSize,
    required String imageUrl,
  }) {
    return Positioned(
      right: right,
      top: top,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: ClipOval(
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[300],
                child: Icon(
                  Icons.restaurant,
                  color: Colors.grey[600],
                  size: iconSize,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
