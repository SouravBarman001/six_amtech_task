import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PopularFoodSection extends StatelessWidget {
  const PopularFoodSection({super.key});

  final List<Map<String, dynamic>> foods = const [
    {
      'name': 'Fried Noodles',
      'restaurant': 'Mc Donald',
      'price': '\$7.56',
      'rating': '4.9',
      'image': 'https://images.unsplash.com/photo-1585032226651-759b368d7246?w=300&h=200&fit=crop',
    },
    {
      'name': 'Fried Noodles',
      'restaurant': 'Mc Donald',
      'price': '\$7.56',
      'rating': '4.9',
      'image': 'https://images.unsplash.com/photo-1612929633738-8fe44f7ec841?w=300&h=200&fit=crop',
    },
    {
      'name': 'Fried Rice',
      'restaurant': 'Mc Donald',
      'price': '\$7.50',
      'rating': '4.8',
      'image': 'https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=300&h=200&fit=crop',
    },
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
                'Popular Food Nearby',
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
          height: 170.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            itemCount: foods.length,
            itemBuilder: (context, index) {
              final food = foods[index];
              return Container(
                width: 140.w,
                margin: EdgeInsets.only(right: 16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.r),
                        topRight: Radius.circular(16.r),
                      ),
                      child: Container(
                        height: 85.h,
                        width: double.infinity,
                        child: Image.network(
                          food['image'],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[300],
                              child: Icon(
                                Icons.restaurant,
                                color: Colors.grey[600],
                                size: 28.sp,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  food['name'],
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  food['restaurant'],
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    color: Colors.grey[600],
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  food['price'],
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: const Color(0xFFFFB800),
                                      size: 11.sp,
                                    ),
                                    SizedBox(width: 2.w),
                                    Text(
                                      food['rating'],
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
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
