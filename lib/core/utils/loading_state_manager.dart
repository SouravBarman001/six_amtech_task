import 'package:flutter/material.dart';

/// Loading state manager for shimmer effects
enum LoadingState {
  initial,
  loading,
  loaded,
  error,
}

/// Mixin to provide loading state functionality
mixin LoadingStateMixin<T extends StatefulWidget> on State<T> {
  LoadingState _loadingState = LoadingState.initial;
  String? _errorMessage;

  LoadingState get loadingState => _loadingState;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _loadingState == LoadingState.loading;
  bool get hasError => _loadingState == LoadingState.error;
  bool get hasData => _loadingState == LoadingState.loaded;

  void setLoading() {
    setState(() {
      _loadingState = LoadingState.loading;
      _errorMessage = null;
    });
  }

  void setLoaded() {
    setState(() {
      _loadingState = LoadingState.loaded;
      _errorMessage = null;
    });
  }

  void setError(String message) {
    setState(() {
      _loadingState = LoadingState.error;
      _errorMessage = message;
    });
  }

  void resetState() {
    setState(() {
      _loadingState = LoadingState.initial;
      _errorMessage = null;
    });
  }
}

/// Widget builder for handling different loading states
class LoadingStateBuilder extends StatelessWidget {
  final LoadingState state;
  final Widget Function() loadingBuilder;
  final Widget Function() dataBuilder;
  final Widget Function(String error)? errorBuilder;
  final Widget Function()? initialBuilder;

  const LoadingStateBuilder({
    super.key,
    required this.state,
    required this.loadingBuilder,
    required this.dataBuilder,
    this.errorBuilder,
    this.initialBuilder,
  });

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case LoadingState.initial:
        return initialBuilder?.call() ?? loadingBuilder();
      case LoadingState.loading:
        return loadingBuilder();
      case LoadingState.loaded:
        return dataBuilder();
      case LoadingState.error:
        return errorBuilder?.call('An error occurred') ?? 
               const Center(child: Text('Something went wrong'));
    }
  }
}

/// Shimmer configuration constants
class ShimmerConfig {
  static const Duration animationDuration = Duration(milliseconds: 1500);
  static const Color baseColor = Color(0xFFE0E0E0);
  static const Color highlightColor = Color(0xFFF5F5F5);
  
  // Responsive sizes
  static double getResponsiveSize(BuildContext context, {
    required double mobile,
    required double tablet,
    required double desktop,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 600) {
      return mobile;
    } else if (screenWidth < 1200) {
      return tablet;
    } else {
      return desktop;
    }
  }
  
  static int getResponsiveItemCount(BuildContext context, {
    required int mobile,
    required int tablet,
    required int desktop,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 600) {
      return mobile;
    } else if (screenWidth < 1200) {
      return tablet;
    } else {
      return desktop;
    }
  }
}

/// Theme-aware shimmer colors
class ShimmerTheme {
  static Color getBaseColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.light 
        ? const Color(0xFFE0E0E0)
        : const Color(0xFF424242);
  }
  
  static Color getHighlightColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.light 
        ? const Color(0xFFF5F5F5)
        : const Color(0xFF616161);
  }
}
