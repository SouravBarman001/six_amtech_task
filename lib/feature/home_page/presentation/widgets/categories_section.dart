import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  final List<Map<String, dynamic>> categories = const [
    {'name': 'All', 'icon': '🍽️', 'isSelected': true},
    {'name': 'Coffee', 'icon': '☕', 'isSelected': false},
    {'name': 'Drink', 'icon': '🥤', 'isSelected': false},
    {'name': 'Fast Food', 'icon': '🍔', 'isSelected': false},
    {'name': 'Cake', 'icon': '🧁', 'isSelected': false},
    {'name': 'Sushi', 'icon': '🍣', 'isSelected': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Categories',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                'View All',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF4CAF50),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 90.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return Container(
                margin: EdgeInsets.only(right: 16.w),
                child: Column(
                  children: [
                    Container(
                      width: 56.w,
                      height: 56.h,
                      decoration: BoxDecoration(
                        color: category['isSelected'] 
                            ? const Color(0xFF4CAF50) 
                            : Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: category['isSelected'] 
                              ? const Color(0xFF4CAF50) 
                              : Colors.grey[300]!,
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          category['icon'],
                          style: TextStyle(fontSize: 20.sp),
                        ),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      category['name'],
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                        color: category['isSelected'] 
                            ? const Color(0xFF4CAF50) 
                            : Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
