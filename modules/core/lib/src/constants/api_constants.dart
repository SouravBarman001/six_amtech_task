/// API Configuration Constants for StackFood
class ApiConstants {
  /// Zone ID for API requests
  static const String zoneId = '[1]';
  
  /// Default latitude for location-based requests
  static const String defaultLatitude = '23.735129';
  
  /// Default longitude for location-based requests
  static const String defaultLongitude = '90.425614';
  
  /// Content type for API requests
  static const String contentType = 'application/json; charset=UTF-8';
  
  /// Accept header value
  static const String acceptType = 'application/json';
  
  /// Default pagination limit
  static const int defaultLimit = 10;
  
  /// Default pagination offset
  static const int defaultOffset = 1;
}

/// HTTP Headers for StackFood API
class ApiHeaders {
  /// Standard headers for public API requests
  static Map<String, String> get publicHeaders => {
    'Content-Type': ApiConstants.contentType,
    'Accept': ApiConstants.acceptType,
    'zoneId': ApiConstants.zoneId,
    'latitude': ApiConstants.defaultLatitude,
    'longitude': ApiConstants.defaultLongitude,
  };
  
  /// Headers for protected API requests (with authentication)
  static Map<String, String> protectedHeaders(String token) => {
    ...publicHeaders,
    'Authorization': 'Bearer $token',
  };
}
