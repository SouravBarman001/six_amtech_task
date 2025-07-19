import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/utils/shimmer_template.dart';
import '../providers/banner_providers.dart';
import '../../domain/entities/banner.dart' as domain;

class PromotionalBanner extends ConsumerStatefulWidget {
  const PromotionalBanner({super.key});

  @override
  ConsumerState<PromotionalBanner> createState() => _PromotionalBannerState();
}

class _PromotionalBannerState extends ConsumerState<PromotionalBanner> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    // Trigger banner fetch when widget initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(bannerNotifierProvider.notifier).getBanners();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Watch banner state
    final bannerState = ref.watch(bannerStateProvider);
    final isLoading = ref.watch(isBannerLoadingProvider);
    final banners = ref.watch(bannersListProvider);
    final hasError = bannerState.hasError;

    final bannerHeight = ResponsiveHelper.getHeight(
      context: context,
      mobile: 150.0,
      tablet: 190.0,
      desktop: 200.0,
    );
    
    final horizontalPadding = ResponsiveHelper.getPadding(
      context: context,
      mobile: 20.0,
      tablet: 28.0,
      desktop: 24.0,
    );
    
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Column(
        children: [
          Container(

           // margin: EdgeInsets.only(right: 20),
            height: bannerHeight,
            child: _buildBannerContent(
              isLoading: isLoading,
              hasError: hasError,
              banners: banners,
              bannerHeight: bannerHeight,
            ),
          ),
          if (!isLoading && !hasError && banners.isNotEmpty) ...[
            SizedBox(height: ResponsiveHelper.getHeight(
              context: context,
              mobile: 12.0,
              tablet: 14.0,
              desktop: 16.0,
            )),
            _buildDotIndicator(banners.length),
          ],
        ],
      ),
    );
  }

  Widget _buildBannerContent({
    required bool isLoading,
    required bool hasError,
    required List<domain.Banner> banners,
    required double bannerHeight,
  }) {
    if (isLoading) {
      return _buildShimmerBanner(bannerHeight);
    }

    if (hasError) {
      return _buildErrorBanner(bannerHeight);
    }

    if (banners.isEmpty) {
      return _buildEmptyBanner(bannerHeight);
    }

    return PageView.builder(
      controller: _pageController,
      itemCount: ResponsiveHelper.isDesktop(context) 
          ? (banners.length / 3).ceil() 
          : ResponsiveHelper.isTablet(context)
              ? (banners.length / 2).ceil()
              : banners.length,
      onPageChanged: (index) {
        setState(() {
          _currentPage = index;
        });
        // Update banner index in state
        ref.read(bannerNotifierProvider.notifier).updateCurrentIndex(index);
      },
      itemBuilder: (context, index) {
        if (ResponsiveHelper.isDesktop(context)) {
          // Desktop: Show 3 banners per page
          return _buildDesktopBannerPage(banners, index);
        } else if (ResponsiveHelper.isTablet(context)) {
          // Tablet: Show 2 banners per page
          return _buildTabletBannerPage(banners, index);
        } else {
          // Mobile: Show 1 banner per page
          return _buildBannerItem(banners[index]);
        }
      },
    );
  }

  Widget _buildShimmerBanner(double bannerHeight) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: ShimmerTemplate.banner(
        height: bannerHeight,
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }

  Widget _buildErrorBanner(double bannerHeight) {
    final errorMessage = ref.watch(bannerErrorProvider);
    
    return Container(
      height: bannerHeight,
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(16),
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
                mobile: 32.0,
                tablet: 36.0,
                desktop: 40.0,
              ),
            ),
            SizedBox(height: ResponsiveHelper.getHeight(
              context: context,
              mobile: 8.0,
              tablet: 10.0,
              desktop: 12.0,
            )),
            Text(
              errorMessage ?? 'Failed to load banners',
              style: TextStyle(
                color: Colors.red.shade600,
                fontSize: ResponsiveHelper.getFontSize(
                  context: context,
                  mobile: 14.0,
                  tablet: 16.0,
                  desktop: 18.0,
                ),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: ResponsiveHelper.getHeight(
              context: context,
              mobile: 12.0,
              tablet: 14.0,
              desktop: 16.0,
            )),
            ElevatedButton(
              onPressed: () {
                ref.read(bannerNotifierProvider.notifier).retry();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade400,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveHelper.getPadding(
                    context: context,
                    mobile: 16.0,
                    tablet: 20.0,
                    desktop: 24.0,
                  ),
                  vertical: ResponsiveHelper.getPadding(
                    context: context,
                    mobile: 8.0,
                    tablet: 10.0,
                    desktop: 12.0,
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
                    mobile: 14.0,
                    tablet: 16.0,
                    desktop: 18.0,
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

  Widget _buildEmptyBanner(double bannerHeight) {
    return Container(
      height: bannerHeight,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.image_not_supported_outlined,
              color: Colors.grey.shade400,
              size: ResponsiveHelper.getIconSize(
                context: context,
                mobile: 32.0,
                tablet: 36.0,
                desktop: 40.0,
              ),
            ),
            SizedBox(height: ResponsiveHelper.getHeight(
              context: context,
              mobile: 8.0,
              tablet: 10.0,
              desktop: 12.0,
            )),
            Text(
              'No banners available',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: ResponsiveHelper.getFontSize(
                  context: context,
                  mobile: 14.0,
                  tablet: 16.0,
                  desktop: 18.0,
                ),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopBannerPage(List<domain.Banner> banners, int pageIndex) {
    final startIndex = pageIndex * 3;
    final endIndex = (startIndex + 3).clamp(0, banners.length);
    final pageBanners = banners.sublist(startIndex, endIndex);
    
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.getPadding(
          context: context,
          mobile: 0.0,
          tablet: 0.0,
          desktop: 8.0,
        ),
      ),
      child: Row(
        children: [
          for (int i = 0; i < pageBanners.length; i++) ...[
            Expanded(
              child: _buildBannerItem(pageBanners[i]),
            ),
            if (i < pageBanners.length - 1)
              SizedBox(width: ResponsiveHelper.getWidth(
                context: context,
                mobile: 0.0,
                tablet: 0.0,
                desktop: 12.0,
              )),
          ],
        ],
      ),
    );
  }

  Widget _buildTabletBannerPage(List<domain.Banner> banners, int pageIndex) {
    final startIndex = pageIndex * 2;
    final endIndex = (startIndex + 2).clamp(0, banners.length);
    final pageBanners = banners.sublist(startIndex, endIndex);
    
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.getPadding(
          context: context,
          mobile: 0.0,
          tablet: 6.0,
          desktop: 0.0,
        ),
      ),
      child: Row(
        children: [
          for (int i = 0; i < pageBanners.length; i++) ...[
            Expanded(
              child: _buildBannerItem(pageBanners[i]),
            ),
            if (i < pageBanners.length - 1)
              SizedBox(width: ResponsiveHelper.getWidth(
                context: context,
                mobile: 0.0,
                tablet: 12.0,
                desktop: 0.0,
              )),
          ],
        ],
      ),
    );
  }

  Widget _buildDotIndicator(int itemCount) {
    // Calculate total pages based on screen type
    final totalPages = ResponsiveHelper.isDesktop(context) 
        ? (itemCount / 3).ceil() 
        : ResponsiveHelper.isTablet(context)
            ? (itemCount / 2).ceil()
            : itemCount;
        
    final dotMargin = ResponsiveHelper.getMargin(
      context: context,
      mobile: 4.0,
      tablet: 5.0,
      desktop: 6.0,
    );
    
    final activeDotSize = ResponsiveHelper.getWidth(
      context: context,
      mobile: 10.0,
      tablet: 12.0,
      desktop: 14.0,
    );
    
    final inactiveDotSize = ResponsiveHelper.getWidth(
      context: context,
      mobile: 6.0,
      tablet: 8.0,
      desktop: 10.0,
    );
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalPages, (index) {
        bool isActive = _currentPage == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: EdgeInsets.symmetric(horizontal: dotMargin),
          width: isActive ? activeDotSize : inactiveDotSize,
          height: isActive ? activeDotSize : inactiveDotSize,
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

  Widget _buildBannerItem(domain.Banner banner) {
    final borderRadius = ResponsiveHelper.getBorderRadius(
      context: context,
      mobile: 16.0,
      tablet: 18.0,
      desktop: 20.0,
    );
    
    final contentPadding = ResponsiveHelper.getPadding(
      context: context,
      mobile: 20.0,
      tablet: 24.0,
      desktop: 28.0,
    );
    
    return Container(
      padding: ResponsiveHelper.isDesktop(context) 
          ? EdgeInsets.zero 
          : EdgeInsets.only(left: 10, right: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Stack(
          children: [
            // Background image from API
            Positioned.fill(
              child: CachedNetworkImage(
                imageUrl: banner.image,
                fit: ResponsiveHelper.isDesktop(context) ? BoxFit.cover : BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                alignment: Alignment.center,
                placeholder: (context, url) => ShimmerTemplate.banner(
                  height: double.infinity,
                  borderRadius: BorderRadius.zero,
                ),
                errorWidget: (context, url, error) => Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFFF6B35), Color(0xFFFF8A50)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image_not_supported,
                          color: Colors.white.withOpacity(0.7),
                          size: ResponsiveHelper.getIconSize(
                            context: context,
                            mobile: 40.0,
                            tablet: 45.0,
                            desktop: 50.0,
                          ),
                        ),
                        SizedBox(height: ResponsiveHelper.getHeight(
                          context: context,
                          mobile: 8.0,
                          tablet: 10.0,
                          desktop: 12.0,
                        )),
                        Text(
                          'Image not available',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: ResponsiveHelper.getFontSize(
                              context: context,
                              mobile: 12.0,
                              tablet: 14.0,
                              desktop: 16.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Content from API data
            Positioned(
              left: contentPadding,
              top: contentPadding,
              right: contentPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(height: ResponsiveHelper.getHeight(
                    context: context,
                    mobile: 12.0,
                    tablet: 14.0,
                    desktop: 16.0,
                  ),
                  ),

                  // Banner title from API
                  // if (banner.title.isNotEmpty)
                  //   Text(
                  //     banner.title,
                  //     style: TextStyle(
                  //       fontSize: titleFontSize,
                  //       fontWeight: FontWeight.bold,
                  //       color: Colors.white,
                  //       height: 1.2,
                  //       shadows: [
                  //         Shadow(
                  //           color: Colors.black.withOpacity(0.8),
                  //           offset: const Offset(1, 1),
                  //           blurRadius: 4,
                  //         ),
                  //       ],
                  //     ),
                  //     maxLines: 2,
                  //     overflow: TextOverflow.ellipsis,
                  //   ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
