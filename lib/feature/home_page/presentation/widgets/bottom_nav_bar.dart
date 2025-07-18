import 'package:flutter/material.dart';
import '../../../../core/utils/responsive_helper.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final navBarHeight = ResponsiveHelper.getHeight(
      context: context,
      mobile: 60.0,
      tablet: 70.0,
      desktop: 80.0,
    );
    
    final cartButtonSize = ResponsiveHelper.getWidth(
      context: context,
      mobile: 60.0,
      tablet: 70.0,
      desktop: 80.0,
    );
    
    final cartIconSize = ResponsiveHelper.getIconSize(
      context: context,
      mobile: 24.0,
      tablet: 28.0,
      desktop: 32.0,
    );
    
    final navIconSize = ResponsiveHelper.getIconSize(
      context: context,
      mobile: 24.0,
      tablet: 26.0,
      desktop: 28.0,
    );
    
    return Container(
      color: Colors.white,
      height: navBarHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Bottom Nav Background Bar
          Container(
            height: navBarHeight,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8.0,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  icon: Icons.home,
                  index: 0,
                  isActive: selectedIndex == 0,
                  iconSize: navIconSize,
                ),
                _buildNavItem(
                  icon: Icons.favorite_border,
                  index: 1,
                  isActive: selectedIndex == 1,
                  iconSize: navIconSize,
                ),
                SizedBox(width: cartButtonSize), // Space for center button
                _buildNavItem(
                  icon: Icons.receipt_long,
                  index: 2,
                  isActive: selectedIndex == 2,
                  iconSize: navIconSize,
                ),
                _buildNavItem(
                  icon: Icons.menu,
                  index: 3,
                  isActive: selectedIndex == 3,
                  iconSize: navIconSize,
                ),
              ],
            ),
          ),

          // Floating Cart Button
          Positioned(
            top: -(cartButtonSize * 0.4),
            left: MediaQuery.of(context).size.width / 2 - (cartButtonSize / 2),
            child: GestureDetector(
              onTap: () => onTap(4),
              child: Container(
                height: cartButtonSize,
                width: cartButtonSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6.0,
                      offset: const Offset(0, 3),
                    )
                  ],
                ),
                child: Icon(
                  Icons.shopping_cart, 
                  color: Colors.white, 
                  size: cartIconSize,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required int index,
    required bool isActive,
    required double iconSize,
  }) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Icon(
        icon,
        size: iconSize,
        color: isActive ? Colors.green : Colors.blueGrey,
      ),
    );
  }
}
