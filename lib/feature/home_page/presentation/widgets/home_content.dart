import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'home_app_bar.dart';
import 'search_bar_widget.dart';
import 'promotional_banner.dart';
import 'categories_section.dart';
import 'popular_food_section.dart';
import 'food_campaign_section.dart';
import 'restaurants_section.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 600.w),
          child: Column(
            children: [
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          const HomeAppBar(),
                          SizedBox(height: 8.h),
                          const SearchBarWidget(),
                          SizedBox(height: 20.h),
                          const PromotionalBanner(),
                          SizedBox(height: 24.h),
                          const CategoriesSection(),
                          SizedBox(height: 24.h),
                          const PopularFoodSection(),
                          SizedBox(height: 24.h),
                          const FoodCampaignSection(),
                          SizedBox(height: 24.h),
                          const RestaurantsSection(),
                          SizedBox(height: 100.h), // Space for bottom nav
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
