import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:badges/badges.dart' as badges;

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 16.h,
        left: 20.w,
        right: 20.w,
        bottom: 8.h,
      ),
      color: Colors.white,
      child: Row(
        children: [
          Icon(
            Icons.home,
            color: Colors.grey[600],
            size: 20.sp,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              '76A eighth avenue, New York, US',
              style: TextStyle(
                fontSize: 14.sp,
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
                fontSize: 10.sp,
                fontWeight: FontWeight.bold,
              ),
            ),

            badgeStyle: badges.BadgeStyle(
              badgeColor: Colors.red,
              padding: EdgeInsets.all(5.r),
              borderSide: BorderSide(
                color: Colors.white,
                width: 1.r,
              ),
            ),
            position: badges.BadgePosition.topEnd(
              top: -6,
              end: 2,
            ),
            child: Container(
              child: Icon(
                Icons.notifications,
                color: Colors.black,
                size: 23.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
