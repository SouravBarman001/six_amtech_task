import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RestaurantsSection extends StatelessWidget {
  const RestaurantsSection({super.key});

  final List<Map<String, dynamic>> restaurants = const [
    {
      'name': 'Item Name',
      'restaurant': 'Mc Donald',
      'price': '\$5.55',
      'rating': 5.0,
      'image': 'https://images.unsplash.com/photo-1571091718767-18b5b1457add?w=300&h=200&fit=crop',
    },
    {
      'name': 'Item Name',
      'restaurant': 'Mc Donald',
      'price': '\$5.55',
      'rating': 5.0,
      'image': 'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=300&h=200&fit=crop',
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
                'Restaurants',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.tune,
                  size: 20.sp,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          itemCount: restaurants.length,
          itemBuilder: (context, index) {
            final restaurant = restaurants[index];
            return Container(
              margin: EdgeInsets.only(bottom: 16.h),
              padding: EdgeInsets.only(
                left: 5.w,right: 18.w,top: 10.h,bottom: 10.h,
              ),
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
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Container(
                      width: 80.w,
                      height: 80.h,
                      child: Image.network(
                        restaurant['image'],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: Icon(
                              Icons.restaurant,
                              color: Colors.grey[600],
                              size: 30.sp,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurant['name'],
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          restaurant['restaurant'],
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            ...List.generate(5, (index) {
                              return Icon(
                                Icons.star,
                                size: 14.sp,
                                color: const Color(0xFFFFB800),
                              );
                            }),
                            SizedBox(width: 8.w),
                            Text(
                              restaurant['price'],
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8.w),
                        // decoration: BoxDecoration(
                        //   color: Colors.grey[100],
                        //   shape: BoxShape.circle,
                        // ),
                        child: Icon(
                          Icons.favorite_border,
                          size: 24.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Container(
                        width: 32.w,
                        height: 32.h,
                        // decoration: BoxDecoration(
                        //   color: const Color(0xFF4CAF50),
                        //   borderRadius: BorderRadius.circular(8.r),
                        // ),
                        child: Icon(
                          Icons.add,
                          color: Colors.black,
                          size: 26.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
