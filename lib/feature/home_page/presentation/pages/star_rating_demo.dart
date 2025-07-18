import 'package:flutter/material.dart';
import '../widgets/star_rating_widget.dart';

/// Demo widget to showcase different star rating examples
class StarRatingDemo extends StatelessWidget {
  const StarRatingDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Star Rating Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Dynamic Star Rating Examples:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildRatingExample('Perfect Rating', 5.0),
            _buildRatingExample('Great Rating', 4.5),
            _buildRatingExample('Good Rating', 4.0),
            _buildRatingExample('Average Rating', 3.2),
            _buildRatingExample('Poor Rating', 2.1),
            _buildRatingExample('Very Poor Rating', 1.0),
            _buildRatingExample('No Rating', 0.0),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingExample(String label, double rating) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          StarRatingWidget(
            rating: rating,
            size: 20.0,
          ),
          const SizedBox(width: 10),
          Text(
            rating.toStringAsFixed(1),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
