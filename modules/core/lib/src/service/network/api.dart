class API {
  /// Base URL
  static const String base = "https://stackfood-admin.6amtech.com";

  /// API Endpoints
  static const String config = "/api/v1/config";
  static const String banner = "/api/v1/banners";
  static const String category = "/api/v1/categories";
  static const String popularFood = "/api/v1/products/popular";
  static const String foodCampaign = "/api/v1/campaigns/item";
  static const String restaurants = "/api/v1/restaurants/get-restaurants/all";

  /// Headers
  static const Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'zoneId': '[1]',
    'latitude': '23.735129',
    'longitude': '90.425614',
  };

  /// Build complete URL
  static String buildUrl(String endpoint, {Map<String, dynamic>? queryParams}) {
    String url = base + endpoint;
    
    if (queryParams != null && queryParams.isNotEmpty) {
      final queryString = queryParams.entries
          .map((e) => '${e.key}=${e.value}')
          .join('&');
      url += '?$queryString';
    }
    
    return url;
  }

  /// Pagination parameters for restaurants
  static Map<String, dynamic> getRestaurantParams({int offset = 1, int limit = 10}) {
    return {
      'offset': offset,
      'limit': limit,
    };
  }
}
