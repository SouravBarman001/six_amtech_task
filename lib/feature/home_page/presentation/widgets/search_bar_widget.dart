import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              'Search food or restaurant here...',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[400],
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Icon(
            Icons.search,
            color: Colors.grey[400],
            size: 22.sp,
          ),
        ],
      ),
    );
  }
}
