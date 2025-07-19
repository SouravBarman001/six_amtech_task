import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/utils/shimmer_template.dart';
import '../providers/product_providers.dart';
import '../../domain/entities/product.dart' as domain;

class PopularFoodList extends ConsumerStatefulWidget {
  const PopularFoodList({super.key});

  @override
  ConsumerState<PopularFoodList> createState() => _PopularFoodListState();
}

class _PopularFoodListState extends ConsumerState<PopularFoodList> {
  final Map<String, bool> _hoveredFoodItems = {};
  
  @override
  void initState() {
    super.initState();
    // Trigger product fetch when widget initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(productNotifierProvider.notifier).getPopularProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Watch product state
    final productState = ref.watch(productStateProvider);
    final isLoading = ref.watch(isProductLoadingProvider);
    final products = ref.watch(productsListProvider);
    final hasError = productState.hasError;

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
            mobile: 5.0,
            tablet: 8.0,
            desktop: 15.0,
          )),
          
          // Products Content
          _buildProductsContent(
            isLoading: isLoading,
            hasError: hasError,
            products: products,
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
          'Popular Food Nearby',
          style: TextStyle(
            fontSize: titleFontSize,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF000743),
          ),
        ),
        TextButton(
          onPressed: () {
            HapticFeedback.mediumImpact();
            // TODO: Navigate to all popular food page
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

  Widget _buildProductsContent({
    required bool isLoading,
    required bool hasError,
    required List<domain.Product> products,
  }) {
    if (isLoading) {
      return _buildShimmerList();
    }

    if (hasError) {
      return _buildErrorState();
    }

    if (products.isEmpty) {
      return _buildEmptyState();
    }

    return _buildProductList(products);
  }

  Widget _buildShimmerList() {
    final itemHeight = ResponsiveHelper.getHeight(
      context: context,
      mobile: 210.0, // Match the product list height
      tablet: 230.0,
      desktop: 250.0,
    );

    final itemWidth = ResponsiveHelper.getWidth(
      context: context,
      mobile: 160.0,
      tablet: 180.0,
      desktop: 200.0,
    );

    return SizedBox(
      height: itemHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 6, // Show 6 shimmer items
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              right: ResponsiveHelper.getWidth(
                context: context,
                mobile: 16.0,
                tablet: 18.0,
                desktop: 20.0,
              ),
              bottom: 8.0, // Add bottom padding for shadow visibility
              left: 4.0,   // Add left padding for shadow visibility
            ),
            child: ShimmerTemplate.foodItem(
              width: itemWidth,
              height: itemHeight - 8.0, // Subtract bottom padding from height
            ),
          );
        },
      ),
    );
  }

  Widget _buildErrorState() {
    final errorMessage = ref.watch(productErrorProvider);
    
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
              errorMessage ?? 'Failed to load popular food',
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
                ref.read(productNotifierProvider.notifier).retry();
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
              Icons.restaurant_menu_outlined,
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
              'No popular food available',
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

  Widget _buildProductList(List<domain.Product> products) {
    final itemHeight = ResponsiveHelper.getHeight(
      context: context,
      mobile: 200.0, // Increased to accommodate shadow
      tablet: 230.0,
      desktop: 250.0,
    );

    return SizedBox(
      height: itemHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              right: ResponsiveHelper.getWidth(
                context: context,
                mobile: 16.0,
                tablet: 18.0,
                desktop: 20.0,
              ),
              bottom: 8.0, // Add bottom padding for shadow visibility
              left: 2.0,   // Add left padding for shadow visibility
            ),
            child: _buildProductItem(products[index]),
          );
        },
      ),
    );
  }

  Widget _buildProductItem(domain.Product product) {
    final borderRadius = ResponsiveHelper.getBorderRadius(
      context: context,
      mobile: 12.0,
      tablet: 14.0,
      desktop: 16.0,
    );

    final itemWidth = ResponsiveHelper.getWidth(
      context: context,
      mobile: 160.0,
      tablet: 180.0,
      desktop: 200.0,
    );

    final imageHeight = ResponsiveHelper.getHeight(
      context: context,
      mobile: 105.0,
      tablet: 110.0,
      desktop: 120.0,
    );

    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        // TODO: Navigate to product details page
        print('Tapped on product: ${product.name}');
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            ResponsiveHelper.isDesktop(context)
                ? _buildDesktopHoverProductImage(product, borderRadius, imageHeight)
                : _buildStandardProductImage(product, borderRadius, imageHeight),
            
            // Product Details
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(ResponsiveHelper.getPadding(
                  context: context,
                  mobile: 10.0,
                  tablet: 12.0,
                  desktop: 14.0,
                )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Product Name
                    Flexible(
                      child: Text(
                        product.name,
                        style: TextStyle(
                          fontSize: ResponsiveHelper.getFontSize(
                            context: context,
                            mobile: 13.0,
                            tablet: 14.0,
                            desktop: 15.0,
                          ),
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    
                    // Restaurant Name
                    Text(
                      product.restaurantName,
                      style: TextStyle(
                        fontSize: ResponsiveHelper.getFontSize(
                          context: context,
                          mobile: 11.0,
                          tablet: 12.0,
                          desktop: 13.0,
                        ),
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w600,
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
                    
                    // Price and Rating Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Price
                        Flexible(
                          child: Text(
                            product.formattedPrice,
                            style: TextStyle(
                              fontSize: ResponsiveHelper.getFontSize(
                                context: context,
                                mobile: 13.0,
                                tablet: 14.0,
                                desktop: 15.0,
                              ),
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        
                        // Rating
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.grey,
                              size: ResponsiveHelper.getIconSize(
                                context: context,
                                mobile: 12.0,
                                tablet: 13.0,
                                desktop: 14.0,
                              ),
                            ),
                            SizedBox(width: ResponsiveHelper.getWidth(
                              context: context,
                              mobile: 2.0,
                              tablet: 3.0,
                              desktop: 4.0,
                            )),
                            Text(
                              product.formattedRating,
                              style: TextStyle(
                                fontSize: ResponsiveHelper.getFontSize(
                                  context: context,
                                  mobile: 11.0,
                                  tablet: 12.0,
                                  desktop: 13.0,
                                ),
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w500,
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
      ),
    );
  }

  Widget _buildDesktopHoverProductImage(
    domain.Product product, 
    double borderRadius, 
    double imageHeight
  ) {
    final isHovered = _hoveredFoodItems[product.imageFullUrl] ?? false;
    
    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredFoodItems[product.imageFullUrl] = true),
      onExit: (_) => setState(() => _hoveredFoodItems[product.imageFullUrl] = false),
      cursor: SystemMouseCursors.click,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
        ),
        child: AnimatedScale(
          scale: isHovered ? 1.1 : 1.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: _buildStandardProductImage(product, borderRadius, imageHeight),
        ),
      ),
    );
  }

  Widget _buildStandardProductImage(
    domain.Product product, 
    double borderRadius, 
    double imageHeight
  ) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(borderRadius),
        topRight: Radius.circular(borderRadius),
      ),
      child: Container(
        height: imageHeight,
        width: double.infinity,
        child: CachedNetworkImage(
          imageUrl: product.imageFullUrl,
          fit: BoxFit.cover,
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
              Icons.fastfood,
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
    );
  }
}
