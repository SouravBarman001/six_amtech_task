import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../providers/campaign_providers.dart';
import '../../domain/entities/campaign.dart' as domain;
import 'star_rating_widget.dart';

class FoodCampaignList extends ConsumerStatefulWidget {
  const FoodCampaignList({super.key});

  @override
  ConsumerState<FoodCampaignList> createState() => _FoodCampaignListState();
}

class _FoodCampaignListState extends ConsumerState<FoodCampaignList> {
  @override
  void initState() {
    super.initState();
    // Trigger campaign fetch when widget initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(campaignNotifierProvider.notifier).getCampaigns();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Watch campaign state
    final campaignState = ref.watch(campaignStateProvider);
    final isLoading = ref.watch(isCampaignLoadingProvider);
    final campaigns = ref.watch(campaignsListProvider);
    final hasError = campaignState.hasError;

    final horizontalPadding = ResponsiveHelper.getPadding(
      context: context,
      mobile: 16.0,
      tablet: 20.0,
      desktop: 24.0,
    );

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          _buildSectionHeader(),
          
          SizedBox(height: ResponsiveHelper.getHeight(
            context: context,
            mobile: 16.0,
            tablet: 18.0,
            desktop: 20.0,
          )),
          
          // Campaigns Content
          _buildCampaignsContent(
            isLoading: isLoading,
            hasError: hasError,
            campaigns: campaigns,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader() {
    final titleFontSize = ResponsiveHelper.getFontSize(
      context: context,
      mobile: 18.0,
      tablet: 20.0,
      desktop: 22.0,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Food Campaign',
          style: TextStyle(
            fontSize: titleFontSize,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF000743),
          ),
        ),
        TextButton(
          onPressed: () {
            HapticFeedback.mediumImpact();
            // TODO: Navigate to all campaigns page
          },
          child: Text(
            'View All',
            style: TextStyle(
              fontSize: ResponsiveHelper.getFontSize(
                context: context,
                mobile: 14.0,
                tablet: 16.0,
                desktop: 18.0,
              ),
              color: const Color(0xFFFF6B35),
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
              decorationColor: const Color(0xFFFF6B35),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCampaignsContent({
    required bool isLoading,
    required bool hasError,
    required List<domain.Campaign> campaigns,
  }) {
    if (isLoading) {
      return _buildShimmerList();
    }

    if (hasError) {
      return _buildErrorState();
    }

    if (campaigns.isEmpty) {
      return _buildEmptyState();
    }

    return _buildCampaignList(campaigns);
  }

  Widget _buildShimmerList() {
    final itemHeight = ResponsiveHelper.getHeight(
      context: context,
      mobile: 110.0,  // Reduced from 140.0
      tablet: 120.0,  // Reduced from 150.0
      desktop: 130.0, // Reduced from 160.0
    );

    return SizedBox(
      height: itemHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3, // Show 3 shimmer items
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              right: ResponsiveHelper.getWidth(
                context: context,
                mobile: 16.0,
                tablet: 18.0,
                desktop: 20.0,
              ),
              bottom: 8.0,
              left: 4.0,
            ),
            child: _buildCampaignShimmer(
              width: ResponsiveHelper.getWidth(
                context: context,
                mobile: 280.0,
                tablet: 300.0,
                desktop: 320.0,
              ),
              height: itemHeight - 8.0,
            ),
          );
        },
      ),
    );
  }

  Widget _buildErrorState() {
    final errorMessage = ref.watch(campaignErrorProvider);
    
    return Container(
      height: ResponsiveHelper.getHeight(
        context: context,
        mobile: 110.0,  // Reduced from 120.0
        tablet: 120.0,  // Reduced from 130.0
        desktop: 130.0, // Reduced from 140.0
      ),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.red.shade400,
              size: ResponsiveHelper.getIconSize(
                context: context,
                mobile: 24.0,
                tablet: 26.0,
                desktop: 28.0,
              ),
            ),
            SizedBox(height: ResponsiveHelper.getHeight(
              context: context,
              mobile: 8.0,
              tablet: 10.0,
              desktop: 12.0,
            )),
            Text(
              errorMessage ?? 'Failed to load campaigns',
              style: TextStyle(
                color: Colors.red.shade600,
                fontSize: ResponsiveHelper.getFontSize(
                  context: context,
                  mobile: 12.0,
                  tablet: 14.0,
                  desktop: 16.0,
                ),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: ResponsiveHelper.getHeight(
              context: context,
              mobile: 8.0,
              tablet: 10.0,
              desktop: 12.0,
            )),
            ElevatedButton(
              onPressed: () {
                HapticFeedback.mediumImpact();
                ref.read(campaignNotifierProvider.notifier).retry();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade400,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveHelper.getPadding(
                    context: context,
                    mobile: 12.0,
                    tablet: 16.0,
                    desktop: 20.0,
                  ),
                  vertical: ResponsiveHelper.getPadding(
                    context: context,
                    mobile: 6.0,
                    tablet: 8.0,
                    desktop: 10.0,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Retry',
                style: TextStyle(
                  fontSize: ResponsiveHelper.getFontSize(
                    context: context,
                    mobile: 12.0,
                    tablet: 14.0,
                    desktop: 16.0,
                  ),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      height: ResponsiveHelper.getHeight(
        context: context,
        mobile: 110.0,  // Reduced from 120.0
        tablet: 120.0,  // Reduced from 130.0
        desktop: 130.0, // Reduced from 140.0
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.campaign_outlined,
              color: Colors.grey.shade400,
              size: ResponsiveHelper.getIconSize(
                context: context,
                mobile: 24.0,
                tablet: 26.0,
                desktop: 28.0,
              ),
            ),
            SizedBox(height: ResponsiveHelper.getHeight(
              context: context,
              mobile: 8.0,
              tablet: 10.0,
              desktop: 12.0,
            )),
            Text(
              'No campaigns available',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: ResponsiveHelper.getFontSize(
                  context: context,
                  mobile: 12.0,
                  tablet: 14.0,
                  desktop: 16.0,
                ),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCampaignList(List<domain.Campaign> campaigns) {
    final itemHeight = ResponsiveHelper.getHeight(
      context: context,
      mobile: 110.0,  // Reduced from 140.0
      tablet: 120.0,  // Reduced from 150.0
      desktop: 130.0, // Reduced from 160.0
    );

    return SizedBox(
      height: itemHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: campaigns.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              right: ResponsiveHelper.getWidth(
                context: context,
                mobile: 16.0,
                tablet: 18.0,
                desktop: 20.0,
              ),
              bottom: 8.0,
              left: 4.0,
            ),
            child: _buildCampaignItem(campaigns[index]),
          );
        },
      ),
    );
  }

  Widget _buildCampaignItem(domain.Campaign campaign) {
    final borderRadius = ResponsiveHelper.getBorderRadius(
      context: context,
      mobile: 12.0,
      tablet: 14.0,
      desktop: 16.0,
    );

    final itemWidth = ResponsiveHelper.getWidth(
      context: context,
      mobile: 280.0,
      tablet: 300.0,
      desktop: 320.0,
    );

    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        // TODO: Navigate to campaign details page
        print('Tapped on campaign: ${campaign.name}');
      },
      child: Container(
        width: itemWidth,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 8,
              offset: const Offset(-2, 4), // Left and bottom shadow
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 4,
              offset: const Offset(-1, 2), // Additional subtle shadow
            ),
          ],
        ),
        child: Row(
          children: [
            // Image Section with Discount Badge
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  Container(
                    height: double.infinity,
                    margin: EdgeInsets.all(ResponsiveHelper.getPadding(
                      context: context,
                      mobile: 8.0,
                      tablet: 10.0,
                      desktop: 12.0,
                    )),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(borderRadius),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(borderRadius),
                      child: CachedNetworkImage(
                        imageUrl: campaign.imageFullUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        placeholder: (context, url) => Container(
                          color: Colors.grey.shade100,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: const Color(0xFFFF6B35),
                              strokeWidth: 2,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.grey.shade100,
                          child: Icon(
                            Icons.restaurant,
                            color: Colors.grey.shade400,
                            size: ResponsiveHelper.getIconSize(
                              context: context,
                              mobile: 24.0,
                              tablet: 26.0,
                              desktop: 28.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Discount Badge Overlay
                  Positioned(
                    top: ResponsiveHelper.getHeight(
                      context: context,
                      mobile: 24.0,
                      tablet: 24.0,
                      desktop: 26.0,
                    ),
                    left: ResponsiveHelper.getWidth(
                      context: context,
                      mobile: 2.0,
                      tablet: 4.0,
                      desktop: 6.0,
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: ResponsiveHelper.getPadding(
                          context: context,
                          mobile: 8.0,
                          tablet: 10.0,
                          desktop: 12.0,
                        ),
                        vertical: ResponsiveHelper.getPadding(
                          context: context,
                          mobile: 4.0,
                          tablet: 6.0,
                          desktop: 8.0,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF04CF45),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        campaign.formattedDiscount,
                        style: TextStyle(
                          fontSize: ResponsiveHelper.getFontSize(
                            context: context,
                            mobile: 10.0,
                            tablet: 11.0,
                            desktop: 12.0,
                          ),
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
                padding: EdgeInsets.all(ResponsiveHelper.getPadding(
                  context: context,
                  mobile: 8.0,  // Reduced from 12.0
                  tablet: 10.0, // Reduced from 14.0
                  desktop: 12.0, // Reduced from 16.0
                )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          campaign.name,
                          style: TextStyle(
                            fontSize: ResponsiveHelper.getFontSize(
                              context: context,
                              mobile: 14.0,  // Reduced from 16.0
                              tablet: 15.0,  // Reduced from 17.0
                              desktop: 16.0, // Reduced from 18.0
                            ),
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: ResponsiveHelper.getHeight(
                          context: context,
                          mobile: 2.0,  // Reduced from 4.0
                          tablet: 4.0,  // Reduced from 6.0
                          desktop: 6.0, // Reduced from 8.0
                        )),
                        Text(
                          campaign.restaurantName,
                          style: TextStyle(
                            fontSize: ResponsiveHelper.getFontSize(
                              context: context,
                              mobile: 11.0,  // Reduced from 12.0
                              tablet: 12.0,  // Reduced from 13.0
                              desktop: 13.0, // Reduced from 14.0
                            ),
                            color: Colors.grey[600],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: ResponsiveHelper.getHeight(
                          context: context,
                          mobile: 6.0,
                          tablet: 8.0,
                          desktop: 10.0,
                        )),
                        Row(
                          children: [
                            ResponsiveStarRating(
                              rating: campaign.rating,
                              filledColor: const Color(0xFFFF6B35),
                              emptyColor: const Color(0xFFE0E0E0),
                              showHalfStars: true,
                            ),
                            SizedBox(width: ResponsiveHelper.getWidth(
                              context: context,
                              mobile: 4.0,
                              tablet: 6.0,
                              desktop: 8.0,
                            )),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                child: Text(
                                  campaign.formattedDiscountedPrice,
                                  style: TextStyle(
                                    fontSize: ResponsiveHelper.getFontSize(
                                      context: context,
                                      mobile: 12.0,  // Reduced from 14.0
                                      tablet: 13.0,  // Reduced from 15.0
                                      desktop: 14.0, // Reduced from 16.0
                                    ),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(width: ResponsiveHelper.getWidth(
                                context: context,
                                mobile: 4.0,
                                tablet: 6.0,
                                desktop: 8.0,
                              )),
                              Flexible(
                                child: Text(
                                  campaign.formattedOriginalPrice,
                                  style: TextStyle(
                                    fontSize: ResponsiveHelper.getFontSize(
                                      context: context,
                                      mobile: 10.0,  // Reduced from 11.0
                                      tablet: 11.0,  // Reduced from 12.0
                                      desktop: 12.0, // Reduced from 13.0
                                    ),
                                    color: Colors.grey[500],
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: ResponsiveHelper.getWidth(
                          context: context,
                          mobile: 8.0,
                          tablet: 10.0,
                          desktop: 12.0,
                        )),
                        Container(
                          width: ResponsiveHelper.getWidth(
                            context: context,
                            mobile: 24.0,  // Reduced from 28.0
                            tablet: 26.0,  // Reduced from 30.0
                            desktop: 28.0, // Reduced from 32.0
                          ),
                          height: ResponsiveHelper.getHeight(
                            context: context,
                            mobile: 24.0,  // Reduced from 28.0
                            tablet: 26.0,  // Reduced from 30.0
                            desktop: 28.0, // Reduced from 32.0
                          ),
                          child: Icon(
                            Icons.add,
                            color: Colors.black,
                            size: ResponsiveHelper.getIconSize(
                              context: context,
                              mobile: 25.0,  // Reduced from 22.0
                              tablet: 25.0,  // Reduced from 24.0
                              desktop: 30.0, // Reduced from 26.0
                            ),
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
      ),
    );
  }

  Widget _buildCampaignShimmer({required double width, required double height}) {
    final borderRadius = ResponsiveHelper.getBorderRadius(
      context: context,
      mobile: 12.0,
      tablet: 14.0,
      desktop: 16.0,
    );

    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 8,
              offset: const Offset(-2, 4),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 4,
              offset: const Offset(-1, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Image shimmer section
            Expanded(
              flex: 2,
              child: Container(
                margin: EdgeInsets.all(ResponsiveHelper.getPadding(
                  context: context,
                  mobile: 8.0,
                  tablet: 10.0,
                  desktop: 12.0,
                )),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ),
            ),
            // Content shimmer section
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.all(ResponsiveHelper.getPadding(
                  context: context,
                  mobile: 12.0,
                  tablet: 14.0,
                  desktop: 16.0,
                )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title shimmer
                    Container(
                      height: 14.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                    // Restaurant name shimmer
                    Container(
                      height: 12.0,
                      width: width * 0.25,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                    // Stars and rating shimmer
                    Row(
                      children: [
                        // Stars shimmer
                        Row(
                          children: List.generate(5, (index) => Container(
                            width: 12.0,
                            height: 12.0,
                            margin: const EdgeInsets.only(right: 2.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              shape: BoxShape.circle,
                            ),
                          )),
                        ),
                        const SizedBox(width: 6.0),
                        // Rating text shimmer
                        Container(
                          height: 11.0,
                          width: 40.0,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                      ],
                    ),
                    // Price section shimmer
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Price shimmer
                        Row(
                          children: [
                            Container(
                              height: 14.0,
                              width: width * 0.15,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            Container(
                              height: 12.0,
                              width: width * 0.12,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                            ),
                          ],
                        ),
                        // Add button shimmer
                        Container(
                          width: 28.0,
                          height: 28.0,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            shape: BoxShape.circle,
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
      ),
    );
  }
}
