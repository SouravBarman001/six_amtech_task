import 'dart:convert';

/// Utility class for debugging API responses and handling restaurant data
class RestaurantApiDebugger {
  /// Print formatted JSON response for debugging
  static void printResponse(String response) {
    try {
      final Map<String, dynamic> jsonData = json.decode(response);
      final prettyJson = const JsonEncoder.withIndent('  ').convert(jsonData);
      print('=== Restaurant API Response ===');
      print(prettyJson);
      print('================================');
      
      // Print key metrics
      final totalSize = jsonData['total_size'] ?? 0;
      final limit = jsonData['limit'] ?? '10';
      final offset = jsonData['offset'] ?? '1';
      final restaurants = jsonData['restaurants'] as List<dynamic>? ?? [];
      
      print('Total Restaurants: $totalSize');
      print('Current Limit: $limit');
      print('Current Offset: $offset');
      print('Restaurants in this page: ${restaurants.length}');
      
      // Print first restaurant for structure verification
      if (restaurants.isNotEmpty) {
        print('First restaurant structure:');
        print(const JsonEncoder.withIndent('  ').convert(restaurants.first));
      }
    } catch (e) {
      print('Error parsing response: $e');
      print('Raw response: $response');
    }
  }
  
  /// Print API headers being used
  static void printApiHeaders() {
    print('=== API Headers Used ===');
    print('Content-Type: application/json; charset=UTF-8');
    print('zoneId: [1]');
    print('latitude: 23.735129');
    print('longitude: 90.425614');
    print('========================');
  }
  
  /// Print API URL being called
  static void printApiUrl({int offset = 1, int limit = 10}) {
    final baseUrl = 'https://stackfood-admin.6amtech.com';
    final endpoint = '/api/v1/restaurants/get-restaurants/all';
    final fullUrl = '$baseUrl$endpoint?offset=$offset&limit=$limit';
    
    print('=== API URL ===');
    print('Base URL: $baseUrl');
    print('Endpoint: $endpoint');
    print('Query Params: offset=$offset&limit=$limit');
    print('Full URL: $fullUrl');
    print('===============');
  }
  
  /// Generate mock data for testing when API is not available
  static Map<String, dynamic> generateMockResponse({
    int offset = 1,
    int limit = 10,
    int totalSize = 50,
  }) {
    final List<Map<String, dynamic>> restaurants = [];
    
    final restaurantNames = [
      'Café Monarch', 'Pizza Palace', 'Burger Junction', 'Sushi Express',
      'Italian Bistro', 'Mexican Cantina', 'Chinese Garden', 'Indian Spice',
      'French Café', 'Thai Kitchen', 'Greek Taverna', 'American Grill',
      'Japanese Ramen', 'Korean BBQ', 'Mediterranean Delight', 'Seafood Harbor'
    ];
    
    for (int i = 0; i < limit && (offset + i - 1) < totalSize; i++) {
      final restaurantIndex = (offset + i - 1) % restaurantNames.length;
      restaurants.add({
        'id': offset + i,
        'name': restaurantNames[restaurantIndex],
        'avg_rating': (3.0 + (i % 3) * 0.5 + 0.5).clamp(3.0, 5.0),
        'cover_photo_full_url': 'https://picsum.photos/300/200?random=${offset + i}',
      });
    }
    
    return {
      'filter_data': 'all',
      'total_size': totalSize,
      'limit': limit.toString(),
      'offset': offset.toString(),
      'restaurants': restaurants,
    };
  }
}
