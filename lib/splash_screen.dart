import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'core/utils/responsive_helper.dart';
import 'feature/home_page/presentation/pages/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _loadingController;
  late AnimationController _iconController;
  late Animation<double> _loadingAnimation;
  late Animation<double> _iconOpacityAnimation;
  
  final List<Map<String, dynamic>> _foodItems = [
    {
      'asset': 'assets/pizza.png',
      'icon': Icons.local_pizza,
      'name': 'Pizza'
    },
    {
      'asset': 'assets/hamburger.png',
      'icon': Icons.lunch_dining,
      'name': 'Burger'
    },
    {
      'asset': 'assets/biryani.png',
      'icon': Icons.rice_bowl,
      'name': 'Biryani'
    },
    {
      'asset': 'assets/donut.png',
      'icon': Icons.cake,
      'name': 'Donut'
    },
    {
      'asset': 'assets/fast-food.png',
      'icon': Icons.fastfood,
      'name': 'Fast Food'
    },
  ];
  
  int _currentIconIndex = 0;
  Timer? _iconTimer;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _startSplashSequence();
  }

  void _setupAnimations() {
    // Loading bar animation
    _loadingController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    
    _loadingAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _loadingController,
      curve: Curves.easeInOut,
    ));

    // Icon fade animation
    _iconController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    
    _iconOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _iconController,
      curve: Curves.easeIn,
    ));
  }

  void _startSplashSequence() {
    // Start loading animation
    _loadingController.forward();
    
    // Start icon sequence
    _startIconSequence();
    
    // Navigate to home page after 2 seconds
    Timer(const Duration(seconds: 2), () {
      if (mounted) {
        HapticFeedback.lightImpact();
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const HomePage(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );
      }
    });
  }

  void _startIconSequence() {
    _iconController.forward();
    
    _iconTimer = Timer.periodic(const Duration(milliseconds: 800), (timer) {
      setState(() {
        _currentIconIndex = (_currentIconIndex + 1) % _foodItems.length;
      });
      _iconController.reset();
      _iconController.forward();
    });
  }

  @override
  void dispose() {
    _loadingController.dispose();
    _iconController.dispose();
    _iconTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Single Food Icon in Center
            Container(
              height: ResponsiveHelper.getHeight(
                context: context,
                mobile: 80.0,
                tablet: 90.0,
                desktop: 100.0,
              ),
              width: ResponsiveHelper.getWidth(
                context: context,
                mobile: 80.0,
                tablet: 90.0,
                desktop: 100.0,
              ),
              child: AnimatedBuilder(
                animation: _iconOpacityAnimation,
                builder: (context, child) {
                  return AnimatedScale(
                    scale: _iconOpacityAnimation.value * 0.3 + 0.7,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: Center(
                      child: Icon(
                        _foodItems[_currentIconIndex]['icon'],
                        size: ResponsiveHelper.getIconSize(
                          context: context,
                          mobile: 60.0,
                          tablet: 60.0,
                          desktop: 70.0,
                        ),
                        color: const Color(0xFF049D55),
                      ),
                    ),
                  );
                },
              ),
            ),
            
            SizedBox(height: ResponsiveHelper.getHeight(
              context: context,
              mobile: 10.0,
              tablet: 12.0,
              desktop: 15.0,
            )),
            
            // Loading Bar Only
            Container(
              width: ResponsiveHelper.getWidth(
                context: context,
                mobile: 200.0,
                tablet: 250.0,
                desktop: 300.0,
              ),
              height: ResponsiveHelper.getHeight(
                context: context,
                mobile: 6.0,
                tablet: 8.0,
                desktop: 10.0,
              ),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: AnimatedBuilder(
                animation: _loadingAnimation,
                builder: (context, child) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: _loadingAnimation.value,
                      backgroundColor: Colors.transparent,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Color(0xFF049D55),
                      ),
                      minHeight: ResponsiveHelper.getHeight(
                        context: context,
                        mobile: 6.0,
                        tablet: 8.0,
                        desktop: 10.0,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
