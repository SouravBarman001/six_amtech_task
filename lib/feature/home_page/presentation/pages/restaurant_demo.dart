import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/restaurants_section.dart';

/// Demo page to test the restaurant pagination functionality
class RestaurantDemo extends ConsumerWidget {
  const RestaurantDemo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant Pagination Demo'),
        backgroundColor: const Color(0xFFFF6B35),
        foregroundColor: Colors.white,
      ),
      body: const SingleChildScrollView(
        child: RestaurantsSection(),
      ),
    );
  }
}
