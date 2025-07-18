# Shimmer Effect Template

A comprehensive shimmer effect template system for loading states in Flutter applications. This implementation provides pre-built shimmer templates for different UI components like banners, categories, food items, campaigns, and restaurants.

## Features

- 🎨 **Pre-built Templates**: Ready-to-use shimmer effects for common UI components
- 📱 **Responsive Design**: Automatically adapts to different screen sizes
- 🎭 **Theme Support**: Light and dark theme compatibility
- 🔧 **Customizable**: Easy to customize colors, sizes, and animations
- 📦 **Modular**: Clean separation with factory constructors
- 🚀 **Easy Integration**: Simple to integrate with existing codebases

## Available Shimmer Templates

### 1. Banner Shimmer
```dart
// Single banner
ShimmerTemplate.banner(
  height: 180,
  borderRadius: BorderRadius.circular(16),
)

// Banner carousel
ShimmerTemplate.horizontalList(
  itemBuilder: () => ShimmerTemplate.banner(height: 150),
  itemWidth: 280,
  itemCount: 3,
)
```

### 2. Category Shimmer
```dart
// Category grid
ShimmerTemplate.grid(
  itemBuilder: () => ShimmerTemplate.category(size: 80),
  crossAxisCount: 4,
  itemCount: 8,
  childAspectRatio: 0.8,
)

// Single category item
ShimmerTemplate.category(size: 80)
```

### 3. Food Item Shimmer
```dart
// Popular food horizontal list
ShimmerTemplate.horizontalList(
  itemBuilder: () => ShimmerTemplate.foodItem(
    height: 200,
    width: 160,
  ),
  itemWidth: 160,
  itemCount: 4,
)

// Food grid
ShimmerTemplate.grid(
  itemBuilder: () => ShimmerTemplate.foodItem(height: 200, width: 160),
  crossAxisCount: 2,
  itemCount: 6,
  childAspectRatio: 0.75,
)
```

### 4. Campaign Shimmer
```dart
// Campaign horizontal list
ShimmerTemplate.horizontalList(
  itemBuilder: () => ShimmerTemplate.campaign(
    height: 160,
    width: 120,
  ),
  itemWidth: 120,
  itemCount: 5,
)
```

### 5. Restaurant Shimmer
```dart
// Restaurant list
ShimmerTemplate.list(
  itemBuilder: () => ShimmerTemplate.restaurant(height: 120),
  itemCount: 5,
)
```

## Quick Usage Examples

### Using Pre-built Shimmer Widgets

```dart
// In your home screen
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Banner section
          LoadingWrapper(
            isLoading: isLoadingBanners,
            shimmer: BannerShimmer(height: 180),
            child: BannerCarousel(banners: banners),
          ),
          
          // Categories section
          LoadingWrapper(
            isLoading: isLoadingCategories,
            shimmer: CategoryGridShimmer(itemCount: 8),
            child: CategoryGrid(categories: categories),
          ),
          
          // Popular food section
          LoadingWrapper(
            isLoading: isLoadingPopularFood,
            shimmer: PopularFoodShimmer(itemCount: 4),
            child: PopularFoodList(foods: popularFoods),
          ),
          
          // Restaurants section
          LoadingWrapper(
            isLoading: isLoadingRestaurants,
            shimmer: RestaurantListShimmer(itemCount: 5),
            child: RestaurantList(restaurants: restaurants),
          ),
        ],
      ),
    );
  }
}
```

### Using with Riverpod State Management

```dart
class HomePageView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bannersState = ref.watch(bannersNotifierProvider);
    final categoriesState = ref.watch(categoriesNotifierProvider);
    
    return Column(
      children: [
        // Banner section with shimmer
        if (bannersState.isLoading)
          QuickShimmers.bannerList(count: 3)
        else if (bannersState.hasError)
          ErrorWidget(bannersState.errorMessage!)
        else
          BannerCarousel(bannersState.data),
          
        // Categories with shimmer
        if (categoriesState.isLoading)
          QuickShimmers.categoryGrid(count: 8)
        else if (categoriesState.hasError)
          ErrorWidget(categoriesState.errorMessage!)
        else
          CategoryGrid(categoriesState.data),
      ],
    );
  }
}
```

### Custom Shimmer

```dart
// Custom shimmer for any widget
Container(
  height: 100,
  width: 200,
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
  ),
).shimmer() // Using extension method

// Or using the template
ShimmerTemplate.custom(
  baseColor: Colors.grey[300],
  highlightColor: Colors.grey[100],
  child: CustomWidget(),
)
```

## Advanced Usage

### Responsive Shimmer

```dart
// Responsive category grid
ShimmerTemplate.grid(
  itemBuilder: () => ShimmerTemplate.category(
    size: ShimmerConfig.getResponsiveSize(
      context,
      mobile: 60,
      tablet: 80,
      desktop: 100,
    ),
  ),
  crossAxisCount: ShimmerConfig.getResponsiveItemCount(
    context,
    mobile: 3,
    tablet: 4,
    desktop: 6,
  ),
  itemCount: 12,
)
```

### Theme-aware Shimmer

```dart
ShimmerTemplate.custom(
  baseColor: ShimmerTheme.getBaseColor(context),
  highlightColor: ShimmerTheme.getHighlightColor(context),
  child: CustomWidget(),
)
```

### Loading State Management

```dart
class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> with LoadingStateMixin {
  @override
  void initState() {
    super.initState();
    _loadData();
  }
  
  Future<void> _loadData() async {
    setLoading();
    try {
      // Fetch data
      await Future.delayed(Duration(seconds: 2));
      setLoaded();
    } catch (e) {
      setError('Failed to load data');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return LoadingStateBuilder(
      state: loadingState,
      loadingBuilder: () => QuickShimmers.bannerList(),
      dataBuilder: () => ActualContent(),
      errorBuilder: (error) => ErrorWidget(error),
    );
  }
}
```

## Dependencies

Add these to your `pubspec.yaml`:

```yaml
dependencies:
  shimmer: ^3.0.0
  equatable: ^2.0.5 # For Location entity
```

## File Structure

```
lib/
├── core/
│   └── utils/
│       ├── shimmer_template.dart      # Main shimmer template
│       ├── shimmer_examples.dart      # Usage examples and pre-built widgets
│       └── loading_state_manager.dart # Loading state management utilities
```

## Best Practices

1. **Use appropriate shimmer types**: Match the shimmer to your actual UI components
2. **Consistent timing**: Keep shimmer duration consistent across your app
3. **Responsive design**: Use responsive values for different screen sizes
4. **Theme consistency**: Use theme-aware colors for light/dark mode support
5. **Performance**: Don't overuse shimmer effects, use them only for loading states

## Customization

### Colors
```dart
ShimmerTemplate.custom(
  baseColor: Color(0xFFE0E0E0),      // Base shimmer color
  highlightColor: Color(0xFFF5F5F5), // Highlight color
  child: widget,
)
```

### Animation Speed
The shimmer package uses a default animation duration. You can customize the animation by wrapping with your own AnimationController if needed.

### Sizes
All templates accept size parameters:
```dart
ShimmerTemplate.banner(height: 200, width: 300)
ShimmerTemplate.category(size: 100)
ShimmerTemplate.foodItem(height: 250, width: 180)
```

This shimmer system provides a complete solution for loading states in your Flutter application with minimal setup and maximum flexibility.
