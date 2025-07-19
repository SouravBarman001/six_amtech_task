import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/utils/shimmer_template.dart';
import '../providers/category_providers.dart';
import '../../domain/entities/category.dart' as domain;

class CategoryList extends ConsumerStatefulWidget {
  const CategoryList({super.key});

  @override
  ConsumerState<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends ConsumerState<CategoryList> {
  final Map<int, bool> _hoveredCategories = {};
  
  @override
  void initState() {
    super.initState();
    // Trigger category fetch when widget initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(categoryNotifierProvider.notifier).getCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Watch category state
    final categoryState = ref.watch(categoryStateProvider);
    final isLoading = ref.watch(isCategoryLoadingProvider);
    final categories = ref.watch(categoriesListProvider);
    final hasError = categoryState.hasError;


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
            mobile: 1.0,
            tablet: 10.0,
            desktop: 15.0,
          )),
          
          // Categories Content
          _buildCategoriesContent(
            isLoading: isLoading,
            hasError: hasError,
            categories: categories,
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
          'Categories',
          style: TextStyle(
            fontSize: titleFontSize,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF000743),
          ),
        ),
        TextButton(
          onPressed: () {
            HapticFeedback.mediumImpact();
            // TODO: Navigate to all categories page
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

  Widget _buildCategoriesContent({
    required bool isLoading,
    required bool hasError,
    required List<domain.Category> categories,
  }) {
    if (isLoading) {
      return _buildShimmerList();
    }

    if (hasError) {
      return _buildErrorState();
    }

    if (categories.isEmpty) {
      return _buildEmptyState();
    }

    return _buildCategoryList(categories);
  }

  Widget _buildShimmerList() {
    final itemHeight = ResponsiveHelper.getHeight(
      context: context,
      mobile: 90.0,
      tablet: 100.0,
      desktop: 110.0,
    );

    final shimmerImageSize = ResponsiveHelper.getWidth(
      context: context,
      mobile: 50.0,
      tablet: 55.0,
      desktop: 60.0,
    );

    return SizedBox(
      height: itemHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 8, // Show 8 shimmer items
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              right: ResponsiveHelper.getWidth(
                context: context,
                mobile: 16.0,
                tablet: 18.0,
                desktop: 20.0,
              ),
            ),
            child: ShimmerTemplate.category(
              size: shimmerImageSize,
            ),
          );
        },
      ),
    );
  }

  Widget _buildErrorState() {
    final errorMessage = ref.watch(categoryErrorProvider);
    
    return Container(
      height: ResponsiveHelper.getHeight(
        context: context,
        mobile: 120.0,
        tablet: 130.0,
        desktop: 140.0,
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
              errorMessage ?? 'Failed to load categories',
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
                ref.read(categoryNotifierProvider.notifier).retry();
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
        mobile: 120.0,
        tablet: 130.0,
        desktop: 140.0,
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
              Icons.category_outlined,
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
              'No categories available',
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

  Widget _buildCategoryList(List<domain.Category> categories) {
    final itemHeight = ResponsiveHelper.getHeight(
      context: context,
      mobile: 90.0,
      tablet: 100.0,
      desktop: 140.0,
    );

    return Container(

      height: itemHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              right: ResponsiveHelper.getWidth(
                context: context,
                mobile: 10.0,
                tablet: 16.0,
                desktop: 20.0,
              ),
            ),
            child: _buildCategoryItem(categories[index]),
          );
        },
      ),
    );
  }

  Widget _buildCategoryItem(domain.Category category) {
    final borderRadius = ResponsiveHelper.getBorderRadius(
      context: context,
      mobile: 10.0,
      tablet: 10.0,
      desktop: 10.0,
    );

    final itemWidth = ResponsiveHelper.getWidth(
      context: context,
      mobile: 70.0,
      tablet: 75.0,
      desktop: 100.0,
    );

    final imageSize = ResponsiveHelper.getWidth(
      context: context,
      mobile: 62.0,
      tablet: 65.0,
      desktop: 90.0,
    );

    final nameFontSize = ResponsiveHelper.getFontSize(
      context: context,
      mobile: 10.0,
      tablet: 12.0,
      desktop: 13.0,
    );

    // Remove internal padding for all screen sizes to show full image
    final containerPadding = EdgeInsets.zero;

    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        // TODO: Navigate to category products page
        print('Tapped on category: ${category.name}');
      },
      child: Container(

        width: itemWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Category Image Container with white background and shadow
            ResponsiveHelper.isDesktop(context)
                ? _buildDesktopHoverCategoryImage(category, imageSize, borderRadius, containerPadding)
                : _buildStandardCategoryImage(category, imageSize, borderRadius, containerPadding),
            
            SizedBox(height: ResponsiveHelper.getHeight(
              context: context,
              mobile: 6.0,
              tablet: 8.0,
              desktop: 10.0,
            )),
            
            // Category Name positioned below the container
            Text(
              category.name,
              style: TextStyle(
                fontSize: nameFontSize,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF000743),
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopHoverCategoryImage(
    domain.Category category, 
    double imageSize, 
    double borderRadius, 
    EdgeInsets containerPadding
  ) {
    final isHovered = _hoveredCategories[category.id] ?? false;
    
    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredCategories[category.id] = true),
      onExit: (_) => setState(() => _hoveredCategories[category.id] = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedScale(
        scale: isHovered ? 1.1 : 1.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: _buildStandardCategoryImage(category, imageSize, borderRadius, containerPadding),
      ),
    );
  }

  Widget _buildStandardCategoryImage(
    domain.Category category, 
    double imageSize, 
    double borderRadius, 
    EdgeInsets containerPadding
  ) {
    return Container(
      width: imageSize,
      height: imageSize,
      padding: containerPadding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: CachedNetworkImage(
          imageUrl: category.image,
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            color: Colors.grey.shade100,
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
                strokeCap: StrokeCap.round,
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
                mobile: 16.0,
                tablet: 18.0,
                desktop: 20.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
