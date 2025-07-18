import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import '../../../../core/utils/responsive_helper.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

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
            child: Text(
              '76A eighth avenue, New York, US',
              style: TextStyle(
                fontSize: fontSize,
                color: Colors.grey[600],
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
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
                Icons.notifications_none,
                color: Colors.black,
                size: iconSize,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
