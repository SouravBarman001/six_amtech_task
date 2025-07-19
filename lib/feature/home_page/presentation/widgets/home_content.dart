import 'package:flutter/material.dart';
import 'package:six_amtech_task/feature/home_page/presentation/widgets/popular_food_list.dart';
import 'package:six_amtech_task/feature/home_page/presentation/widgets/promotional_banner.dart';
import '../../../../core/utils/responsive_helper.dart';
import 'home_app_bar.dart';
import 'search_bar_widget.dart';
import 'categories_section.dart';
import 'popular_food_section.dart';
import 'food_campaign_section.dart';
import 'restaurants_section.dart';

class HomeContent extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;
  
  const HomeContent({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFFF5F5F5),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveHelper.getPadding(
            context: context,
            mobile: 0.0,
            tablet: 20.0,
            desktop: 80.0,
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: ResponsiveHelper.getWidth(
                context: context,
                mobile: double.infinity,
                tablet: 800.0,
                desktop: 1200.0,
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            HomeAppBar(
                              selectedIndex: selectedIndex,
                              onTap: onTap,
                            ),
                            SizedBox(height: ResponsiveHelper.getHeight(
                              context: context,
                              mobile: 8.0,
                              tablet: 10.0,
                              desktop: 12.0,
                            )),
                            const SearchBarWidget(),
                            SizedBox(height: ResponsiveHelper.getHeight(
                              context: context,
                              mobile: 20.0,
                              tablet: 22.0,
                              desktop: 24.0,
                            )),
                            const PromotionalBanner(),
                            SizedBox(height: ResponsiveHelper.getHeight(
                              context: context,
                              mobile: 10.0,
                              tablet: 12.0,
                              desktop: 16.0,
                            )),
                            const CategoriesSection(),
                            SizedBox(height: ResponsiveHelper.getHeight(
                              context: context,
                              mobile: 24.0,
                              tablet: 28.0,
                              desktop: 32.0,
                            )),
                            const PopularFoodSection(),
                            SizedBox(height: ResponsiveHelper.getHeight(
                              context: context,
                              mobile: 24.0,
                              tablet: 28.0,
                              desktop: 32.0,
                            )),
                            const FoodCampaignSection(),
                            SizedBox(height: ResponsiveHelper.getHeight(
                              context: context,
                              mobile: 24.0,
                              tablet: 28.0,
                              desktop: 32.0,
                            )),
                            const RestaurantsSection(),
                            SizedBox(height: ResponsiveHelper.getHeight(
                              context: context,
                              mobile: 100.0,
                              tablet: 120.0,
                              desktop: 140.0,
                            )), // Space for bottom nav
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
      ),
    );
  }
}
