import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    return Container(
      color: Colors.white,
      height: 70.h,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Bottom Nav Background Bar
          Container(
            height: 70.h,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8.r,
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
                ),
                _buildNavItem(
                  icon: Icons.favorite_border,
                  index: 1,
                  isActive: selectedIndex == 1,
                ),
                SizedBox(width: 60.w), // Space for center button
                _buildNavItem(
                  icon: Icons.receipt_long,
                  index: 2,
                  isActive: selectedIndex == 2,
                ),
                _buildNavItem(
                  icon: Icons.menu,
                  index: 3,
                  isActive: selectedIndex == 3,
                ),
              ],
            ),
          ),

          // Floating Cart Button
          Positioned(
            top: -30.h,
            left: MediaQuery.of(context).size.width / 2 - 30.w,
            child: GestureDetector(
              onTap: () => onTap(4),
              child: Container(
                height: 70.w,
                width: 70.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6.r,
                      offset: Offset(0, 3.h),
                    )
                  ],
                ),
                child: Icon(Icons.shopping_cart, color: Colors.white, size: 28.sp),
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
  }) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Icon(
        icon,
        size: 26.sp,
        color: isActive ? Colors.green : Colors.blueGrey,
      ),
    );
  }
}
