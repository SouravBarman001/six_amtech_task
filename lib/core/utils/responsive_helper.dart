import 'package:flutter/material.dart';

class ResponsiveHelper {
  static const double mobileMaxWidth = 600;
  static const double tabletMaxWidth = 1200;
  
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < mobileMaxWidth;
  }
  
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= mobileMaxWidth && width < tabletMaxWidth;
  }
  
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= tabletMaxWidth;
  }
  
  // Responsive values for different screen types
  static double getResponsiveValue({
    required BuildContext context,
    required double mobile,
    required double tablet,
    required double desktop,
  }) {
    if (isMobile(context)) {
      return mobile;
    } else if (isTablet(context)) {
      return tablet;
    } else {
      return desktop;
    }
  }
  
  // Font sizes
  static double getFontSize({
    required BuildContext context,
    required double mobile,
    required double tablet,
    required double desktop,
  }) {
    return getResponsiveValue(
      context: context,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
  }
  
  // Icon sizes
  static double getIconSize({
    required BuildContext context,
    required double mobile,
    required double tablet,
    required double desktop,
  }) {
    return getResponsiveValue(
      context: context,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
  }
  
  // Container heights
  static double getHeight({
    required BuildContext context,
    required double mobile,
    required double tablet,
    required double desktop,
  }) {
    return getResponsiveValue(
      context: context,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
  }
  
  // Container widths
  static double getWidth({
    required BuildContext context,
    required double mobile,
    required double tablet,
    required double desktop,
  }) {
    return getResponsiveValue(
      context: context,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
  }
  
  // Padding values
  static double getPadding({
    required BuildContext context,
    required double mobile,
    required double tablet,
    required double desktop,
  }) {
    return getResponsiveValue(
      context: context,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
  }
  
  // Margin values
  static double getMargin({
    required BuildContext context,
    required double mobile,
    required double tablet,
    required double desktop,
  }) {
    return getResponsiveValue(
      context: context,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
  }
  
  // Border radius values
  static double getBorderRadius({
    required BuildContext context,
    required double mobile,
    required double tablet,
    required double desktop,
  }) {
    return getResponsiveValue(
      context: context,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
  }
  
  // Grid cross axis count
  static int getCrossAxisCount({
    required BuildContext context,
    required int mobile,
    required int tablet,
    required int desktop,
  }) {
    if (isMobile(context)) {
      return mobile;
    } else if (isTablet(context)) {
      return tablet;
    } else {
      return desktop;
    }
  }
  
  // Aspect ratio
  static double getAspectRatio({
    required BuildContext context,
    required double mobile,
    required double tablet,
    required double desktop,
  }) {
    return getResponsiveValue(
      context: context,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
  }
}
