import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    return Column(
      children: [
        SizedBox(
          height: 120.h,
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
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: _buildBannerItem(),
              );
            },
          ),
        ),
        SizedBox(height: 10.h),
        _buildDotIndicator(),
      ],
    );
  }

  Widget _buildDotIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_totalPages, (index) {
        bool isActive = _currentPage == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          width: isActive ? 10.w : 6.w,
          height: isActive ? 10.h : 6.h,
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
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        gradient: const LinearGradient(
          colors: [Color(0xFFFF6B35), Color(0xFFFF8A50)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 20.w,
            top: 15.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    '50% off',
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFFF6B35),
                    ),
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  'TODAY',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
                Text(
                  'Special',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
                Text(
                  'MENU',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 15.w,
            top: 10.h,
            child: Container(
              width: 70.w,
              height: 70.h,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white24,
              ),
              child: Center(
                child: Container(
                  width: 55.w,
                  height: 55.h,
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
                            size: 24.sp,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Additional food circles
          Positioned(
            right: 40.w,
            top: 25.h,
            child: Container(
              width: 40.w,
              height: 40.h,
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
                  'https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445?w=100&h=100&fit=crop',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: Icon(
                        Icons.restaurant,
                        color: Colors.grey[600],
                        size: 16.sp,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Positioned(
            right: 65.w,
            top: 45.h,
            child: Container(
              width: 35.w,
              height: 35.h,
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
                  'https://images.unsplash.com/photo-1571091718767-18b5b1457add?w=100&h=100&fit=crop',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: Icon(
                        Icons.restaurant,
                        color: Colors.grey[600],
                        size: 14.sp,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
