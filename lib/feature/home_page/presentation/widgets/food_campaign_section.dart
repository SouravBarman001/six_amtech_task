import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/foundation.dart';

class FoodCampaignSection extends StatelessWidget {
  const FoodCampaignSection({super.key});

  final List<Map<String, dynamic>> campaigns = const [
    {
      'name': 'Burger',
      'restaurant': 'Mc Donald',
      'location': 'New york, USA',
      'price': '\$5',
      'originalPrice': '\$10',
      'discount': '30% off',
      'rating': 5.0,
      'image': 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=300&h=200&fit=crop',
    },
    {
      'name': 'Burger',
      'restaurant': 'Mc Donald',
      'location': 'New york, USA',
      'price': '\$5',
      'originalPrice': '\$10',
      'discount': '30% off',
      'rating': 5.0,
      'image': 'https://images.unsplash.com/photo-1571091718767-18b5b1457add?w=300&h=200&fit=crop',
    },
  ];

  double _getResponsiveHeight() {
    // Check if running on web platform
    bool isWeb = kIsWeb;
    // Check screen width
    bool isWideScreen = ScreenUtil().screenWidth > 500;
    
    // Web or wide screen gets larger height
    if (isWeb || isWideScreen) {
      return 140.h;
    }
    // Mobile gets smaller height
    return 125.h;
  }

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
                'Food Campaign',
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
          height: _getResponsiveHeight(),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            itemCount: campaigns.length,
            itemBuilder: (context, index) {
              final campaign = campaigns[index];
              return Container(
                width: 280.w,
                margin: EdgeInsets.only(right: 16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Image Section with Overlay Badge
                    Expanded(
                      flex: 2,
                      child: Stack(
                        children: [
                          Container(
                            height: double.infinity,
                            margin: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12.r),
                              child: Image.network(
                                campaign['image'],
                                fit: BoxFit.cover,
                                width: double.infinity,
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
                          // Discount Badge Overlay - positioned on the image directly
                          Positioned(
                            top: 16.h,
                            left: 2.w,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                color: const Color(0xFF4CAF50),
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                              child: Text(
                                campaign['discount'],
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Content Section
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: EdgeInsets.all(12.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  campaign['name'],
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  '${campaign['restaurant']}, ${campaign['location']}',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.grey[600],
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 6.h),
                                Row(
                                  children: List.generate(5, (index) {
                                    return Icon(
                                      Icons.star,
                                      size: 12.sp,
                                      color: const Color(0xFF4CAF50),
                                    );
                                  }),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      campaign['price'],
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(width: 6.w),
                                    Text(
                                      campaign['originalPrice'],
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.grey[500],
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  ],
                                ),
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
