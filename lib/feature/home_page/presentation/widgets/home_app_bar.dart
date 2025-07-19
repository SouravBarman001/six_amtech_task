import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:badges/badges.dart' as badges;
import '../../../../core/utils/responsive_helper.dart';
import '../providers/location_providers.dart';

class HomeAppBar extends ConsumerStatefulWidget {
  final int selectedIndex;
  final Function(int) onTap;
  
  const HomeAppBar({
    super.key,
    this.selectedIndex = 0,
    required this.onTap,
  });

  @override
  ConsumerState<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends ConsumerState<HomeAppBar> {
  @override
  void initState() {
    super.initState();
    // Load location when widget initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(locationNotifierProvider.notifier).getCurrentLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = ResponsiveHelper.getPadding(
      context: context,
      mobile: 16.0,
      tablet: 20.0,
      desktop: 24.0,
    );
    
    final horizontalPadding = ResponsiveHelper.getPadding(
      context: context,
      mobile: 20.0,
      tablet: 24.0,
      desktop: 28.0,
    );
    
    final bottomPadding = ResponsiveHelper.getPadding(
      context: context,
      mobile: 8.0,
      tablet: 10.0,
      desktop: 12.0,
    );
    
    final iconSize = ResponsiveHelper.getIconSize(
      context: context,
      mobile: 24.0,
      tablet: 26.0,
      desktop: 26.0,
    );
    
    final fontSize = ResponsiveHelper.getFontSize(
      context: context,
      mobile: 14.0,
      tablet: 16.0,
      desktop: 18.0,
    );
    
    final badgeFontSize = ResponsiveHelper.getFontSize(
      context: context,
      mobile: 10.0,
      tablet: 12.0,
      desktop: 14.0,
    );
    
    final spacingWidth = ResponsiveHelper.getWidth(
      context: context,
      mobile: 8.0,
      tablet: 10.0,
      desktop: 12.0,
    );
    
    final badgePadding = ResponsiveHelper.getPadding(
      context: context,
      mobile: 4.0,
      tablet: 5.0,
      desktop: 6.0,
    );
    
    final iconPadding = ResponsiveHelper.getPadding(
      context: context,
      mobile: 8.0,
      tablet: 10.0,
      desktop: 12.0,
    );

    // Watch location state
    final isLoading = ref.watch(isLocationLoadingProvider);
    final locationError = ref.watch(locationErrorProvider);
    final currentAddress = ref.watch(currentLocationAddressProvider);
    
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + topPadding,
        left: horizontalPadding,
        right: horizontalPadding,
        bottom: bottomPadding,
      ),
      color: Colors.white,
      child: Row(
        children: [
          Icon(
            Icons.home,
            color: Colors.grey[600],
            size: iconSize,
          ),
          SizedBox(width: spacingWidth),
          Expanded(
            child: GestureDetector(
              onTap: () {
                HapticFeedback.mediumImpact();
                // Refresh location on tap
                ref.read(locationNotifierProvider.notifier).refreshLocation();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isLoading)
                    Row(
                      children: [
                        SizedBox(
                          width: 12,
                          height: 12,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Getting location...',
                          style: TextStyle(
                            fontSize: fontSize * 0.9,
                            color: Colors.grey[500],
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    )
                  else if (locationError != null)
                    Row(
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 16,
                          color: Colors.red[400],
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            'Tap to retry location',
                            style: TextStyle(
                              fontSize: fontSize * 0.9,
                              color: Colors.red[400],
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    Text(
                      currentAddress ?? '76A eighth avenue, New York, US',
                      style: TextStyle(
                        fontSize: fontSize,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
          ),
          // Desktop Navigation Icons
          if (ResponsiveHelper.isDesktop(context)) ...[
            _buildDesktopNavItem(
              icon: Icons.favorite_border,
              index: 1,
              isActive: widget.selectedIndex == 1,
              iconSize: iconSize,
            ),
            SizedBox(width: spacingWidth),
            _buildDesktopNavItem(
              icon: Icons.shopping_cart,
              index: 4,
              isActive: widget.selectedIndex == 4,
              iconSize: iconSize,
            ),
            SizedBox(width: spacingWidth),
          ],
          badges.Badge(
            badgeContent: Text(
              '',
              style: TextStyle(
                color: Colors.white,
                fontSize: badgeFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),

            badgeStyle: badges.BadgeStyle(
              badgeColor: Colors.red,
              padding: EdgeInsets.all(badgePadding),
              borderSide: BorderSide(
                color: Colors.white,
                width: 1.0,
              ),
            ),
            position: badges.BadgePosition.topEnd(top: 3, end:11),
            child: Container(
              padding: EdgeInsets.all(iconPadding),
              child: Icon(
                Icons.notifications,
                color: Colors.black,
                size: iconSize,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopNavItem({
    required IconData icon,
    required int index,
    required bool isActive,
    required double iconSize,
  }) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        widget.onTap(index);
      },
      child: Container(
        padding: EdgeInsets.all(ResponsiveHelper.getPadding(
          context: context,
          mobile: 8.0,
          tablet: 10.0,
          desktop: 12.0,
        )),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF049D55).withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          size: iconSize,
          color: isActive ? const Color(0xFF049D55) : Colors.grey[600],
        ),
      ),
    );
  }
}
